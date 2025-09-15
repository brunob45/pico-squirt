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

void spi_update()
{
    uint8_t spi_step, spi_data, adc_resl, adc_resh;
    uint16_t adc_res;

    spi_data = 1;
    spi_write_blocking(spi0, &spi_data, 1);
    // spi_get_hw(spi0)->dr = 1;
    do
    {
        // spi_read_blocking(spi0, 0, &spi_data, 1);
        spi_get_hw(spi0)->dr = 0;
        while (!spi_is_readable(spi0))
            ;
        spi_data = spi_get_hw(spi0)->dr;
    } while (spi_data == 0);

    // spi_read_blocking(spi0, 0, &adc_resl, 1);
    spi_get_hw(spi0)->dr = 0;
    while (!spi_is_readable(spi0))
        ;
    adc_resl = spi_get_hw(spi0)->dr;

    // spi_read_blocking(spi0, 0, &adc_resh, 1);
    spi_get_hw(spi0)->dr = 0;
    while (!spi_is_readable(spi0))
        ;
    adc_resh = spi_get_hw(spi0)->dr;

    adc_res = adc_resl + 256 * adc_resh;
    printf("%d %d\n", spi_data, adc_res);

    // spi_write_read_blocking(spi0, out, in, sizeof(out));
    // for(int i = 0; i < sizeof(in); i++)
    //     printf("%x ", in[i]);
    // printf("\n");
    // uint16_t adc_res = res[8] + 256*res[9];
    // printf("%d\n", adc_res);
    // printf("%0.2f %0.2f\n", temperature, res*0.25f);
    // printf("%d %d/n", 1, adc_res);
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

    gpio_init(25);
    gpio_set_dir(25, 1);
    gpio_put(25, 1);

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
    // gpio_init(5);
    // gpio_set_dir(5, true);
    // gpio_put(5, false);

    auto last_trx = get_absolute_time();

    uint8_t in[12], out[12];
    for (int i = 0; i < sizeof(out); i++)
    {
        out[i] = 0;
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

            spi_update();
        }
    }
}
