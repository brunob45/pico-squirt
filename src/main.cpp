#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/watchdog.h"
#include "hardware/gpio.h"
#include "hardware/spi.h"

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

    absolute_time_t last_trx = get_absolute_time();

    uint8_t cpt = 0, res;

    while (true)
    {
        watchdog_update();
        avr_update();
        if (get_absolute_time() - last_trx > 1'000'000) // 1000 ms
        {
            last_trx = get_absolute_time();
            spi_write_read_blocking(spi0, &cpt, &res, 1);
            printf("%d %d ", cpt, res);
            cpt += 1;
        }
    }
}
