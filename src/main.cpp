#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/watchdog.h"
#include "hardware/gpio.h"
#include "hardware/spi.h"
#include "hardware/adc.h"

#include "avr.h"

// GPIO2 => SCK
// GPIO3 => MOSI
// GPIO4 => MISO
// GPIO5 => CS

int main()
{
    stdio_init_all();

    // Watchdog example code
    if (watchdog_caused_reboot())
    {
        printf("Rebooted by Watchdog!\n");
        // Whatever action you may take if a watchdog caused a reboot
    }

    gpio_init(25);
    gpio_set_dir(25, 1);

    // Enable the watchdog, requiring the watchdog to be updated every 100ms or the chip will reboot
    // second arg is pause on debug which means the watchdog will pause when stepping through code
    watchdog_enable(100, 1);

    // You need to call this function at least more often than the 100ms in the enable call to prevent a reboot
    watchdog_update();

    avr_init();

    // Init SPI
    spi_init(spi0, 1'000'000);
    gpio_set_function(2, GPIO_FUNC_SPI);
    gpio_set_function(3, GPIO_FUNC_SPI);
    gpio_set_function(4, GPIO_FUNC_SPI);
    gpio_set_function(5, GPIO_FUNC_SPI);

    auto last_trx = get_absolute_time();

    uint8_t cpt[10], res[10];
    for (int i = 0; i < sizeof(cpt); i++)
    {
        cpt[i] = 0;
    }

    adc_init();
    adc_select_input(ADC_TEMPERATURE_CHANNEL_NUM);
    adc_set_temp_sensor_enabled(true);

    while (true)
    {
        watchdog_update();
        avr_update();
        if (get_absolute_time() - last_trx > 1'000'000) // 1000 ms
        {
            auto adc_value = adc_read();
            float volt = 3.3f * adc_value / 4095;
            float temperature = 27 - (volt - 0.706f) / 0.001721f;
            last_trx = get_absolute_time();
            cpt[0] = 1;
            spi_write_read_blocking(spi0, cpt, res, sizeof(cpt));
            uint16_t adc_res = res[8] + 256*res[9];
            printf("%d\n", adc_res);
            // printf("%0.2f %0.2f\n", temperature, res*0.25f);
        }
    }
}
