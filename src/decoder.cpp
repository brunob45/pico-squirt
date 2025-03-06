#include <stdio.h>
#include "pico/stdlib.h"

#include "decoder.h"

static uint32_t ts_prev, delta_prev;
static uint sync_step = 0, sync_count = 0;
static volatile alarm_id_t timeout_alarm = 0;
static queue_t queue;
static uint pulse_angles[60];

typedef struct
{
    // uint target_deg;
    int target_n = -1;
    uint target_us;
    uint pw;
    bool running = false;
} Trigger;

static Trigger triggers[2];

const uint n_pulses = 24;
const uint n_missing = 1;
const uint LED2 = 17;

static int64_t sync_loss_cb(alarm_id_t, void *data)
{
    gpio_xor_mask(1 << LED2);
    if (data)
    {
        uint *sync_step = (uint *)data;
        *sync_step = 0;
    }

    return 0;
}

static void update_output_alarm(uint32_t us, uint *step)
{
    if (timeout_alarm > 0)
    {
        cancel_alarm(timeout_alarm);
    }
    timeout_alarm = add_alarm_in_us(us, sync_loss_cb, step, true);
}

void decoder_enable(uint pin)
{
    gpio_init(LED2);
    gpio_set_dir(LED2, GPIO_OUT);

    uint i;
    for (i = 0; i < (n_pulses - n_missing); i++)
    {
        pulse_angles[i] = i * 7200UL / n_pulses;
    }
    pulse_angles[i] = 7200U;

    queue_init(&queue, sizeof(uint32_t), 2);
    gpio_irq_callback_t cb = [](uint, uint32_t)
    {
        const uint32_t timestamp = time_us_32();
        queue_try_add(&queue, &timestamp);
    };
    gpio_set_irq_enabled_with_callback(pin, GPIO_IRQ_EDGE_RISE, true, cb);
}

static bool check_event()
{
    uint32_t ts_now;
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
                sync_count = 1;
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
            sync_count = (sync_count < (n_pulses - n_missing)) ? sync_count + 1 : 1;
            if (sync_count == (n_pulses - n_missing))
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
        return true;
    }
    else
    {
        return false;
    }
}

uint find_pulse(uint angle)
{
    uint result;
    for (uint i = 0; i < (n_pulses - n_missing); i++)
    {
        if (pulse_angles[i] < angle)
        {
            result = i;
        }
    }
    return result;
}

void compute_target(Trigger *target, uint end_deg, uint pw)
{
    const uint pulse_width_deg = pw * 7200UL / (delta_prev * n_pulses);
    const uint target_deg = end_deg - pulse_width_deg;
    target->target_n = find_pulse(target_deg);
    const uint error_deg = target_deg - pulse_angles[target->target_n];
    target->target_us = error_deg * delta_prev * n_pulses / 7200UL;
    target->pw = pw;
}

void decoder_update()
{
    if (check_event())
    {
        if (sync_count == triggers[0].target_n)
        {
            alarm_callback_t cb = [](alarm_id_t, void *data) -> int64_t
            {
                Trigger *t = (Trigger *)data;
                t->running = !t->running;
                gpio_put(LED2, t->running);
                return (t->running) ? (t->pw) : 0;
            };
            add_alarm_in_us(triggers[0].target_us, cb, &triggers[0], true);
        }

        compute_target(&triggers[0], 3850, 3000);
        // compute_target(&triggers[1]);
        printf("start:%d+%d; end:%d+%d\n", triggers[0].target_n, triggers[0].target_us, triggers[1].target_n, triggers[1].target_us);
    }
}