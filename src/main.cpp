#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/util/queue.h"
#include "hardware/timer.h"
#include "hardware/watchdog.h"

#include "button.h"
#include "decoder.h"

const uint LED1 = 16;

queue_t input_queue;
volatile bool button_pressed = false;

void gpio_init_out(uint pin)
{
    gpio_init(pin);
    gpio_set_dir(pin, GPIO_OUT);
}

int64_t alarm_callback(alarm_id_t, void *data)
{
    static uint8_t cpt = 0;
    static uint button_count = 0;

    decoder_t *d = (decoder_t *)data;

    if (!button_pressed)
    {
        gpio_put(LED1, (cpt & 1) && (cpt >= (2 * d->n_missing)));
        cpt = (cpt + 1) % (d->n_pulses * 2);
    }
    const bool button = get_bootsel_button();
    if (button_pressed)
    {
        if (!button)
        {
            button_count += 1;
        }
        else
        {
            button_count = 0;
        }
        if (button_count >= 3)
        {
            button_pressed = false;
        }
    }
    else
    {
        if (button)
        {
            button_count += 1;
        }
        else
        {
            button_count = 0;
        }
        if (button_count >= 3)
        {
            button_pressed = true;
        }
    }
    return -2'000; // wait for another 2ms
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

    {
        queue_init(&input_queue, sizeof(uint32_t), 2);
        gpio_irq_callback_t cb = [](uint, uint32_t)
        {
            const uint32_t timestamp = time_us_32();
            queue_try_add(&input_queue, &timestamp);
        };
        gpio_set_irq_enabled_with_callback(LED1, GPIO_IRQ_EDGE_RISE, true, cb);
    }

    decoder_t d;
    decoder_enable(&d);

    // Timer example code - This example fires off the callback after 2000ms
    add_alarm_in_ms(500, alarm_callback, &d, false);
    // For more examples of timer use see https://github.com/raspberrypi/pico-examples/tree/master/timer

    while (true)
    {
        // You need to call this function at least more often than the 100ms in the enable call to prevent a reboot
        watchdog_update();
        decoder_update(&d);
    }
}
