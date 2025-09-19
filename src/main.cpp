#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/watchdog.h"
#include "hardware/gpio.h"
#include "hardware/adc.h"

#include "avr.h"
#include "bilinterp.h"

static int16_t axis[] = {100, 200, 300, 400};
static uint16_t table[] = {
    10, 20, 30, 40,
    20, 30, 40, 50,
    30, 40, 50, 60,
    40, 50, 60, 70,
};
volatile uint16_t test;

int main()
{
    stdio_init_all();

    // Watchdog example code
    if (watchdog_caused_reboot())
    {
        printf("Rebooted by Watchdog!\n");
        // Whatever action you may take if a watchdog caused a reboot
    }

    // Init onboard LED
    gpio_init(PICO_DEFAULT_LED_PIN);
    gpio_set_dir(PICO_DEFAULT_LED_PIN, 1);
    gpio_put(PICO_DEFAULT_LED_PIN, 1);

    interp_config cfg = interp_default_config();
    interp_config_set_blend(&cfg, true);
    interp_set_config(interp0, 0, &cfg);

    cfg = interp_default_config();
    interp_set_config(interp0, 1, &cfg);

    cfg = interp_default_config();
    interp_config_set_clamp(&cfg, true);
    interp_config_set_signed(&cfg, true);
    interp_set_config(interp1, 0, &cfg);

    // Enable the watchdog, requiring the watchdog to be updated every 100ms or the chip will reboot
    // second arg is pause on debug which means the watchdog will pause when stepping through code
    watchdog_enable(100, 1);

    // You need to call this function at least more often than the 100ms in the enable call to prevent a reboot
    watchdog_update();

    avr_init();
    adc_init();
    adc_set_temp_sensor_enabled(true);
    adc_select_input(ADC_TEMPERATURE_CHANNEL_NUM);

    auto last_trx = get_absolute_time();

    while (true)
    {
        watchdog_update();
        avr_update();

        if (get_absolute_time() - last_trx > 1'000'000) // 1000 ms
        {
            last_trx = get_absolute_time();

            auto adc_value = adc_read();
            float volt = 3.3f * adc_value / 4095;
            float temperature = 27 - (volt - 0.706f) / 0.001721f;

            // Print ADC values
            // for (int i = 0; i < 7; i++)
            //     printf("%d %d, ", i, avr_get_adc(i));
            // printf("%0.2f\n", temperature);
            uint32_t cpt = 0;
            absolute_time_t end = get_absolute_time() + 1000;
            while (get_absolute_time() < end)
            {
                int16_t x = 150, y = 150, z;
                test = bilinear_interp(axis, 4, axis, 4, table, x, y);
                // printf("x:%d y:%d z:%d\n", x, y, z);
                // y = 250;
                // z = bilinear_interp(axis, 4, axis, 4, table, x, y);
                // printf("x:%d y:%d z:%d\n", x, y, z);
                // y = 350;
                // z = bilinear_interp(axis, 4, axis, 4, table, x, y);
                // printf("x:%d y:%d z:%d\n", x, y, z);
                cpt++;
            }
            printf("%ld\n", cpt);
        }
    }
}
