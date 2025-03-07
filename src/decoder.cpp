#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/util/queue.h"
#include "pico/sem.h"

#include "decoder.h"

static uint32_t ts_prev, delta_prev;
static uint sync_step = 0, sync_count = 0;
static volatile alarm_id_t timeout_alarm = 0;
static queue_t queue;
static uint pulse_angles[60];

const uint FULL_CYCLE = 7200UL;
const uint N_PULSES = 24;
const uint N_MISSING = 1;
const uint LED2 = 17;

struct Trigger
{
    // uint target_deg;
    int target_n = -1;
    uint target_us;
    uint pw;
    bool running = false;
    semaphore_t sem;

    static int64_t callback(alarm_id_t, void *data)
    {
        Trigger *t = (Trigger *)data;
        if (t->running)
        {
            gpio_clr_mask(1 << LED2);
            t->running = false;
            return 0;
        }
        else
        {
            gpio_set_mask(1 << LED2);
            t->running = true;
            const uint pw = t->pw;
            sem_release(&t->sem); // allow compute_target, alarm has fired
            return pw;
        }
    }
};

static Trigger triggers[2];

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
    for (i = 0; i < (N_PULSES - N_MISSING); i++)
        pulse_angles[i] = i * FULL_CYCLE / N_PULSES;
    pulse_angles[i] = FULL_CYCLE;

    for (uint i = 0; i < 2; i++)
        sem_init(&triggers[i].sem, 1, 1);

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
            sync_count = (sync_count < (N_PULSES - N_MISSING)) ? sync_count + 1 : 1;
            if (sync_count == (N_PULSES - N_MISSING))
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
    for (uint i = 0; i < (N_PULSES - N_MISSING); i++)
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
    if (sem_try_acquire(&target->sem))
    {
        const uint pulse_width_deg = pw * FULL_CYCLE / (delta_prev * N_PULSES);
        const uint target_deg = (end_deg >= pulse_width_deg)
                                    ? (end_deg - pulse_width_deg)
                                    : (FULL_CYCLE + end_deg - pulse_width_deg);
        target->target_n = find_pulse(target_deg);
        const uint error_deg = target_deg - pulse_angles[target->target_n];
        target->target_us = error_deg * delta_prev * N_PULSES / FULL_CYCLE;
        target->pw = pw;
        sem_release(&target->sem);
    }
}

void decoder_update()
{
    static uint32_t last_print;

    if (check_event())
    {
        for (uint i = 0; i < 2; i++)
        {
            if (sync_count == triggers[i].target_n)
            {
                sem_try_acquire(&triggers[i].sem); // block compute_target while alarm is pending
                add_alarm_in_us(triggers[i].target_us, Trigger::callback, &triggers[i], true);
            }
        }
    }
    compute_target(&triggers[0], 3850, 3000);
    compute_target(&triggers[1], 250, 3000);

    if (time_us_32() - last_print >= 100'000)
    {
        last_print = time_us_32();
        printf("start:%d+%d; end:%d+%d\n",
               triggers[0].target_n, triggers[0].target_us,
               triggers[1].target_n, triggers[1].target_us);
    }
}
