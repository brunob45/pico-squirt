#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/timer.h"
#include "hardware/watchdog.h"
#include "pico/util/queue.h"

const uint LED1 = 16;
const uint LED2 = 17;

queue_t input_queue;
volatile alarm_id_t timeout_alarm = 0;

void gpio_init_out(uint pin)
{
    gpio_init(pin);
    gpio_set_dir(pin, GPIO_OUT);
}

int64_t alarm_callback(alarm_id_t, void *)
{
    static uint8_t cpt = 0;
    gpio_put(LED1, (cpt & 1) && (cpt >= 2));
    cpt = (cpt + 1) % 48; // 24 teeth
    return -2'000;        // wait for another 2ms
}

int64_t sync_loss_cb(alarm_id_t, void *data)
{
    gpio_xor_mask(1 << LED2);
    if (data)
    {
        uint *sync_step = (uint *)data;
        *sync_step = 0;
    }

    return 0;
}

void update_output_alarm(uint32_t us, uint *step)
{
    if (timeout_alarm > 0)
    {
        cancel_alarm(timeout_alarm);
    }
    timeout_alarm = add_alarm_in_us(us, sync_loss_cb, step, true);
}

bool about_same(uint32_t delta_now, uint32_t delta_prev)
{
    // 75 - 125%
    return (delta_now > (delta_prev * (3 / 4))) && (delta_now < (delta_prev * (5 / 4)));
}

bool about_half(uint32_t delta_now, uint32_t delta_prev)
{
    // 37-63%
    return (delta_now > (delta_prev * (3 / 8))) && (delta_now < (delta_prev * (5 / 8)));
}

bool about_double(uint32_t delta_now, uint32_t delta_prev)
{
    // 175-225%
    return (delta_now > (delta_prev * (7 / 4))) && (delta_now < (delta_prev * (9 / 4)));
}

int main()
{
    stdio_init_all();

    // Watchdog example code
    if (watchdog_caused_reboot())
    {
        printf("Rebooted by Watchdog!\n");
        // Whatever action you may take if a watchdog caused a reboot
    }

    // Enable the watchdog, requiring the watchdog to be updated every 100ms or the chip will reboot
    // second arg is pause on debug which means the watchdog will pause when stepping through code
    watchdog_enable(100, 1);

    gpio_init_out(LED1);
    gpio_init_out(LED2);

    {
        queue_init(&input_queue, sizeof(uint32_t), 2);
        gpio_irq_callback_t cb = [](uint, uint32_t)
        {
            const uint32_t timestamp = time_us_32();
            queue_try_add(&input_queue, &timestamp);
        };
        gpio_set_irq_enabled_with_callback(LED1, GPIO_IRQ_EDGE_RISE, true, cb);
    }

    // Timer example code - This example fires off the callback after 2000ms
    add_alarm_in_ms(500, alarm_callback, NULL, false);
    // For more examples of timer use see https://github.com/raspberrypi/pico-examples/tree/master/timer

    uint32_t ts_last, delta_last;
    uint sync_step = 0, sync_count = 0;

    while (true)
    {
        // You need to call this function at least more often than the 100ms in the enable call to prevent a reboot
        watchdog_update();

        uint32_t ts_now;
        if (queue_try_remove(&input_queue, &ts_now))
        {
            const uint32_t delta = ts_now - ts_last;
            uint32_t next_timeout_us = 0;
            switch (sync_step)
            {
            case 0: // first timestamp
                sync_step = 1;
                sync_count = 0;
                // rpm = 100 (arbitrary target)
                // n_pulses = 24 pulse/rotation
                // n_cycles = 2 (1=crank, 2=cam)
                // 60'000 / rpm / n_pulses * n_cycles
                next_timeout_us = 50'000; // 50ms
                break;
            case 1: // first delta
                sync_step = 2;
                // normal delta @ 100us, expect next pulse before 125us
                next_timeout_us = delta * 5 / 4;
                break;
            case 2: // confirm delta
                if (about_same(delta, delta_last))
                {
                    sync_step = 3;
                }
                // normal delta @ 100us, expect next pulse before 125us
                next_timeout_us = delta * 5 / 4;
                break;
            case 3: // wait for double delta
                if (about_double(delta, delta_last))
                {
                    sync_step = 4;
                    sync_count = 0;
                    // longer delta @ 200us, expect next pulse before 125us
                    next_timeout_us = delta * 5 / 8;
                }
                else
                {
                    // normal delta @ 100us, expect next pulse before 250us
                    next_timeout_us = delta * 10 / 4;
                    break;
                }
            case 4: // full sync
                sync_count = (sync_count < (24 - 1)) ? sync_count + 1 : 1;
                if (sync_count == 1)
                {
                    // longer delta @ 200us, expect next pulse before 125us
                    next_timeout_us = delta * 5 / 8;
                }
                else
                {
                    // normal delta @ 100us, expect next pulse before 250us
                    next_timeout_us = delta * 10 / 4;
                }
                break;
            default:;
            }

            update_output_alarm(next_timeout_us, &sync_step); // schedule timeout
            printf("%d, %d, %d\n", sync_step, sync_count, delta);
            delta_last = delta;
            ts_last = ts_now;
        }
    }
}
