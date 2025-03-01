#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/watchdog.h"

#include "simulation.h"
#include "decoder.h"
#include "test_bindings.h"

int main()
{
    stdio_init_all();

    // Watchdog example code - https://github.com/raspberrypi/pico-examples/tree/master/watchdog
    if (watchdog_caused_reboot())
    {
        printf("Rebooted by Watchdog!\n");
    }

    uint result = add(1, 2);

    // Enable the watchdog, requiring the watchdog to be updated every 100ms or the chip will reboot
    // second arg is pause on debug which means the watchdog will pause when stepping through code
    watchdog_enable(100, 1);

    const uint LED1 = 16;
    simulation_enable(LED1);
    decoder_enable(LED1);

    while (true)
    {
        // You need to call this function at least more often than the 100ms in the enable call to prevent a reboot
        watchdog_update();
        simulation_update();
        decoder_update();
    }
}
