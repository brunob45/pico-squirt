#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/watchdog.h"

#include "canbus.h"
#include "simulation.h"
#include "decoder.h"
#include "trigger.h"

// #include "uart-bridge.h"

static Decoder decoder;
static Trigger trigger1, trigger2;

int main()
{
    // uart_bridge_run();

    uint16_t target1, target2;

    absolute_time_t last_print = get_absolute_time();

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
    simulation_enable(LED1, 5000);
    decoder.enable(LED1);

    const uint LED2 = 17;
    trigger1.init(LED2 + 0);
    trigger2.init(LED2 + 1);


    const uint LED3 = 19;
    gpio_init(LED3);
    gpio_set_dir(LED3, GPIO_OUT);
    gpio_clr_mask(1 << LED3);

    CANbus::setup();

    uint event_triggered = 0;
    uint cycle_time, cycle_max = 0;
    uint last_cycle = time_us_32();

    while (true)
    {
        gpio_xor_mask(1 << LED3);

        // You need to call this function at least more often than the 100ms in the enable call to prevent a reboot
        watchdog_update();
        simulation_update();

        if (decoder.update())
        {
            if (decoder.sync_count == 1)
            {
                if (event_triggered == 0)
                {
                    printf("missed event\n");
                }
                else if (event_triggered > 1)
                {
                    printf("multiple events %d\n", event_triggered);
                }
                event_triggered = 0;
            }
        }

        if (decoder.compute_target(&trigger1, target1, 3000))
        {
            event_triggered += 1;
            target1 += 91;
        }
        if (decoder.compute_target(&trigger2, target2, 3000))
        {
            target2 -= 91;
        }

        const absolute_time_t this_cycle = get_absolute_time();
        cycle_time = this_cycle - last_cycle;
        last_cycle = this_cycle;
        if (cycle_time > cycle_max)
            cycle_max = cycle_time;

        if (absolute_time_diff_us(last_print, this_cycle) >= 1e6)
        {
            last_print = this_cycle;
            CANbus::transmit(1 | 1<<31, 2, cycle_max, cycle_max>>8, 0, 0, 0, 0, 0, 0);
            // printf("%d,", cycle_max);
            // trigger1.print_debug();
            // trigger2.print_debug();
            // printf("\n");
            cycle_max = 0;
        }
    }
}
