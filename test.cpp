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
    return -10'000;       // wait for another 500ms
}

int64_t output_callback(alarm_id_t, void *)
{
    gpio_xor_mask(1 << LED2);
    timeout_alarm = 0;
    return 0;
}

void update_output_alarm(uint32_t us)
{
    if (timeout_alarm > 0)
    {
        cancel_alarm(timeout_alarm);
    }
    timeout_alarm = add_alarm_in_us(us, output_callback, NULL, true);
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

    uint32_t last = 0;

    while (true)
    {
        // You need to call this function at least more often than the 100ms in the enable call to prevent a reboot
        watchdog_update();

        uint32_t now;
        if (queue_try_remove(&input_queue, &now))
        {
            const uint32_t delta = now - last;
            update_output_alarm(delta * 3 / 2);
            printf("%d\n", delta);
            last = now;
        }
    }
}
