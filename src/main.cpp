#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/watchdog.h"
#include "hardware/gpio.h"
#include "hardware/adc.h"

#include "avr.h"
#include "global_state.h"

int main()
{
    GlobalState gs;

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
        avr_update(&gs);

        if (get_absolute_time() - last_trx > 1'000'000) // 1000 ms
        {
            last_trx = get_absolute_time();

            auto adc_value = adc_read();
            float volt = 3.3f * adc_value / 4095;
            float temperature = 27 - (volt - 0.706f) / 0.001721f;
            gs.pico_temperature = (int16_t)(temperature * 10);

            // Print ADC values
            for (int i = 0; i < 7; i++)
                printf("%d %d, ", i, gs.adc[i]);
            printf("%0.2f\n", temperature);
        }
    }
}
