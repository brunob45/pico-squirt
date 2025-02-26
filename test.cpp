#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/timer.h"
#include "hardware/watchdog.h"
#include "pico/util/queue.h"

queue_t input_queue;

int64_t alarm_callback(alarm_id_t id, void *user_data)
{
    static uint8_t cpt = 0;
    if (cpt >= 2) // missing 1 tooth
    {
        gpio_put(PICO_DEFAULT_LED_PIN, cpt & 1);
    }
    cpt = (cpt + 1) % 48; // 24 teeth
    return -10'000;       // wait for another 500ms
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

    {
        queue_init(&input_queue, sizeof(uint32_t), 2);
        gpio_irq_callback_t cb = [](uint, uint32_t)
        {
            const uint32_t timestamp = time_us_32();
            queue_try_add(&input_queue, &timestamp);
        };
        gpio_set_irq_enabled_with_callback(PICO_DEFAULT_LED_PIN, GPIO_IRQ_EDGE_RISE, true, cb);
    }

    // A device like Pico that uses a GPIO for the LED will define PICO_DEFAULT_LED_PIN
    // so we can use normal GPIO functionality to turn the led on and off
    gpio_init(PICO_DEFAULT_LED_PIN);
    gpio_set_dir(PICO_DEFAULT_LED_PIN, GPIO_OUT);

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
            printf("%d\n", now - last);
            last = now;
        }
        tight_loop_contents();
        sleep_ms(1);
    }
}
