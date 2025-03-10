
#include "pico/stdlib.h"
#include "hardware/sync.h"
#include "hardware/structs/ioqspi.h"

static uint _pin;
static repeating_timer_t _rt;
static volatile bool button_state;

// https://github.com/raspberrypi/pico-examples/tree/master/picoboard/button
bool __no_inline_not_in_flash_func(get_bootsel_button)()
{
    const uint CS_PIN_INDEX = 1;

    // Must disable interrupts, as interrupt handlers may be in flash, and we
    // are about to temporarily disable flash access!
    uint32_t flags = save_and_disable_interrupts();

    // Set chip select to Hi-Z
    hw_write_masked(&ioqspi_hw->io[CS_PIN_INDEX].ctrl,
                    GPIO_OVERRIDE_LOW << IO_QSPI_GPIO_QSPI_SS_CTRL_OEOVER_LSB,
                    IO_QSPI_GPIO_QSPI_SS_CTRL_OEOVER_BITS);

    // Note we can't call into any sleep functions in flash right now
    for (volatile int i = 0; i < 1000; ++i)
        ;

    // The HI GPIO registers in SIO can observe and control the 6 QSPI pins.
    // Note the button pulls the pin *low* when pressed.
#if PICO_RP2040
#define CS_BIT (1u << 1)
#else
#define CS_BIT SIO_GPIO_HI_IN_QSPI_CSN_BITS
#endif
    bool button_state = !(sio_hw->gpio_hi_in & CS_BIT);

    // Need to restore the state of chip select, else we are going to have a
    // bad time when we return to code in flash!
    hw_write_masked(&ioqspi_hw->io[CS_PIN_INDEX].ctrl,
                    GPIO_OVERRIDE_NORMAL << IO_QSPI_GPIO_QSPI_SS_CTRL_OEOVER_LSB,
                    IO_QSPI_GPIO_QSPI_SS_CTRL_OEOVER_BITS);

    restore_interrupts(flags);

    return button_state;
}

bool pulse_generation(repeating_timer_t *)
{
    static uint8_t cpt = 0;
    static uint button_count = 0;
    static bool button_pressed;
    if (button_pressed)
    {
        if (!button_state)
        {
            button_count += 1;
        }
        else
        {
            button_count = 0;
        }
        if (button_count >= 3)
        {
            button_pressed = false;
        }
    }
    else
    {
        if (button_state)
        {
            button_count += 1;
        }
        else
        {
            button_count = 0;
        }
        if (button_count >= 3)
        {
            button_pressed = true;
        }
    }
    if (!button_pressed)
    {
        gpio_put(_pin, (cpt & 1) && (cpt >= (2 * 1)));
        cpt = (cpt + 1) % (24 * 2);
    }
    return true; // continue forever
}

void simulation_enable(uint pin, int rpm)
{
    _pin = pin;
    gpio_init(_pin);
    gpio_set_dir(_pin, GPIO_OUT);

    // Negative timeout means exact delay (rather than delay between callbacks)
    int64_t pw = 60'000'000 * 2 / rpm / 24;
    add_repeating_timer_us(-pw / 2, pulse_generation, NULL, &_rt);
    // For more examples of timer use see https://github.com/raspberrypi/pico-examples/tree/master/timer
}

void simulation_update()
{
    static uint32_t last_update;
    const uint32_t now = time_us_32();
    if (now - last_update > 1000)
    {
        button_state = get_bootsel_button();
        last_update = now;
    }
}
