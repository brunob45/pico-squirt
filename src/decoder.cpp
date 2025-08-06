#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/util/queue.h"
#include "pico/sem.h"

#include "decoder.h"
#include "trigger.h"

static queue_t *new_ts_queue;
void __not_in_flash_func(new_ts_callback)(uint, uint32_t)
{
    const absolute_time_t new_ts = get_absolute_time();
    queue_try_add(new_ts_queue, &new_ts);
}

void Decoder::enable(uint pin)
{
    uint i;
    for (i = 0; i < (N_PULSES - N_MISSING); i++)
        pulse_angles[i] = i * 0x10000 / N_PULSES;
    pulse_angles[i] = 0x10000;

    new_ts_queue = &queue;
    queue_init(&queue, sizeof(absolute_time_t), 1);
    gpio_set_irq_enabled_with_callback(pin, GPIO_IRQ_EDGE_RISE, true, new_ts_callback);
}

bool Decoder::update()
{
    absolute_time_t ts_now;
    if (queue_try_remove(&queue, &ts_now))
    {
        uint32_t delta = ts_now - ts_prev;
        uint32_t next_timeout_us = 0;
        switch (sync_step)
        {
        case 0: // first timestamp
            sync_step = 1;
            sync_count = 0;
            // rpm = 50 (arbitrary target)
            // n_pulses = 24 pulse/rotation
            // n_cycles = 2 (1=crank, 2=cam)
            // (60'000 / rpm / n_pulses * n_cycles) ms
            next_timeout_us = 100'000; // 100ms
            break;

        case 1: // first delta
            sync_step = 2;
            next_timeout_us = delta * 5 / 4; // normal pulse @ 125ms
            break;

        case 2:                               // confirm delta
            if (delta > (delta_prev * 3 / 4)) // expect at least 75ms
            {
                sync_step = 3;
            }
            next_timeout_us = delta * 10 / 4; // longer pulse @ 250ms
            break;

        case 3:                               // wait for longer delta
            if (delta > (delta_prev * 7 / 4)) // expect at least 175ms
            {
                sync_step = 4;
                sync_count = 0;
                delta = (delta + 1) / 2;         // longer delta detected, divide by 2
                next_timeout_us = delta * 5 / 4; // normal pulse @ 125ms
            }
            else
            {
                sync_count = 0;                   // challenge failed, sync loss
                next_timeout_us = delta * 10 / 4; // longer pulse @ 250ms
            }
            break;

        case 4: // full sync
            sync_count = (sync_count < (N_PULSES - N_MISSING - 1)) ? sync_count + 1 : 0;
            if (sync_count == (N_PULSES - N_MISSING - 1))
            {
                sync_step = 3;                    // challenge longer pulse
                next_timeout_us = delta * 10 / 4; // longer pulse @ 250ms
            }
            else
            {
                next_timeout_us = delta * 5 / 4; // normal pulse @ 125ms
            }
            break;

        default:;
        }
        update_output_alarm(next_timeout_us, &sync_step); // schedule timeout
        delta_prev = delta;
        ts_prev = ts_now;

        // update timing variables
        full_cycle_us = delta_prev * N_PULSES;
        fast_d = libdivide::divider<uint>(full_cycle_us);
        return true;
    }
    else
    {
        return false;
    }
}

bool Decoder::compute_target(Trigger *trig, uint end_deg, uint pw)
{
    const uint pw_deg = pw * 0x10000 / fast_d;
    const int deg_until_end = (end_deg - pulse_angles[sync_count]) & 0xFFFF;
    const int deg_until_start = deg_until_end - pw_deg;
    const int us_until_start = deg_until_start * full_cycle_us / 0x10000;

    const absolute_time_t target = ts_prev + us_until_start;
    const absolute_time_t now = get_absolute_time();

    if (absolute_time_diff_us(now, target) < 100) // 100 us = 6 deg at 10000 rpm
    {
        return trig->update(target, pw);
    }
    return false;
}
