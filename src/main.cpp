#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/watchdog.h"

#include "simulation.h"
#include "decoder.h"
#include "trigger.h"

static Decoder dec;
static Trigger triggers[2];

int main()
{
    uint32_t last_print;

    stdio_init_all();

    // Watchdog example code - https://github.com/raspberrypi/pico-examples/tree/master/watchdog
    if (watchdog_caused_reboot())
    {
        printf("Rebooted by Watchdog!\n");
    }

    // Enable the watchdog, requiring the watchdog to be updated every 100ms or the chip will reboot
    // second arg is pause on debug which means the watchdog will pause when stepping through code
    watchdog_enable(100, 1);

    const uint LED1 = 16;
    const uint LED2 = 17;
    simulation_enable(LED1, 5000);

    dec.enable(LED1);

    for (uint i = 0; i < 2; i++)
        triggers[i].init(LED2 + i);

    while (true)
    {
        // You need to call this function at least more often than the 100ms in the enable call to prevent a reboot
        watchdog_update();
        simulation_update();

        if (dec.update())
        {
            for (uint i = 0; i < 2; i++)
            {
                triggers[i].update(dec.sync_count, dec.ts_prev);
            }
        }

        dec.compute_target(&triggers[0], 3850, 3000);
        dec.compute_target(&triggers[1], 250, 3000);

        if (time_us_32() - last_print >= 100'000)
        {
            last_print = time_us_32();
            triggers[0].print_debug();
            triggers[1].print_debug();
            printf("\n");
        }
    }
}
