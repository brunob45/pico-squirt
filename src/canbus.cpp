// https://github.com/KevinOConnor/can2040/blob/master/docs/API.md#startup

#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/irq.h"

extern "C"
{
#include "can2040.h"
}

static can2040 can0;

static void can2040_cb(can2040 *cd, uint32_t notify, can2040_msg *msg)
{
    if (notify & CAN2040_NOTIFY_RX)
    {
        // a message was received
    }
    else if (notify & CAN2040_NOTIFY_TX)
    {
        // a message was successfully transmited
    }
    else if (notify & CAN2040_NOTIFY_ERROR)
    {
        // CPU could not keep up for some read data - pio state was reset
    }
}

static void PIOx_IRQHandler(void)
{
    can2040_pio_irq_handler(&can0);
}

void canbus_setup(void)
{
    uint32_t pio_num = 0;
    uint32_t sys_clock = SYS_CLK_HZ, bitrate = 500'000;
    uint32_t gpio_rx = 4, gpio_tx = 5;

    // Setup canbus
    can2040_setup(&can0, pio_num);
    can2040_callback_config(&can0, can2040_cb);

    // Enable irqs
    irq_set_exclusive_handler(PIO0_IRQ_0, PIOx_IRQHandler);
    irq_set_priority(PIO0_IRQ_0, 1);
    irq_set_enabled(PIO0_IRQ_0, 1);

    // Start canbus
    can2040_start(&can0, sys_clock, bitrate, gpio_rx, gpio_tx);
}