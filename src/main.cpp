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
    static uint8_t spi_step = 0, spi_data, adc_resl, adc_resh;
    static absolute_time_t last_time;
    uint16_t adc_res;

    spi_data = 1;
    switch (spi_step)
    {
    case 0: // Send channel
        gpio_put(5, 0);
        spi_data = spi_get_hw(spi0)->dr;
        sleep_us(5);
        spi_get_hw(spi0)->dr = 1;
        spi_step += 1;
        last_time = get_absolute_time();
        break;
    case 1: // Receive ready flag
        if (spi_is_readable(spi0))
        {
            spi_data = spi_get_hw(spi0)->dr;
            sleep_us(5);
            spi_get_hw(spi0)->dr = 0;
            if (spi_data > 0)
                spi_step += 1;
        }
        break;
    case 2: // Receive LSB
        if (spi_is_readable(spi0))
        {
            adc_resl = spi_get_hw(spi0)->dr;
            sleep_us(5);
            spi_get_hw(spi0)->dr = 0;
            if (spi_data > 0)
                spi_step += 1;
        }
        break;
    case 3: // Receive MSB and print
        if (spi_is_readable(spi0))
        {
            adc_resh = spi_get_hw(spi0)->dr;
            sleep_us(5);
            gpio_put(5, 1);
            spi_step += 1;

            adc_res = adc_resl + 256 * adc_resh;
            printf("%d %d\n", spi_data, adc_res);
        }
        break;
    case 4: // Wait 1 second
        if (get_absolute_time() - last_time > 1000000)
        {
            spi_step = 0;
        }
    }
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
    // gpio_set_function(5, GPIO_FUNC_SPI);
    gpio_init(5);
    gpio_set_dir(5, 1);
    gpio_put(5, 1);

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
        spi_update();

        if (get_absolute_time() - last_trx > 1'000'000) // 1000 ms
        {
            auto adc_value = adc_read();
            float volt = 3.3f * adc_value / 4095;
            float temperature = 27 - (volt - 0.706f) / 0.001721f;
            last_trx = get_absolute_time();
        }
    }
}
