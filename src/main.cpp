#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/util/queue.h"
#include "hardware/timer.h"
#include "hardware/watchdog.h"

#include "simulation.h"
#include "decoder.h"

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

    simulation_enable(16);
    decoder_enable(17);

    while (true)
    {
        // You need to call this function at least more often than the 100ms in the enable call to prevent a reboot
        watchdog_update();
        simulation_update();
        decoder_update();
    }
}
