#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/util/queue.h"
#include "hardware/timer.h"
#include "hardware/watchdog.h"

#include "button.h"
#include "decoder.h"

const uint LED1 = 16;

int64_t pulse_generation(alarm_id_t, void *)
{
    static uint8_t cpt = 0;
    static uint button_count = 0;
    static bool button_pressed;

    if (!button_pressed)
    {
        gpio_put(LED1, (cpt & 1) && (cpt >= (2 * 1)));
        cpt = (cpt + 1) % (24 * 2);
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

    gpio_init(LED1);
    gpio_set_dir(LED1, GPIO_OUT);

    decoder_enable(LED1);

    // Timer example code - This example fires off the callback after 2000ms
    add_alarm_in_ms(500, pulse_generation, NULL, false);
    // For more examples of timer use see https://github.com/raspberrypi/pico-examples/tree/master/timer

    while (true)
    {
        // You need to call this function at least more often than the 100ms in the enable call to prevent a reboot
        watchdog_update();
        decoder_update();
    }
}
