/*
 * main.cpp
 *
 * Created: 2025-08-22
 * Author : @brunob45
 */

#include <avr/io.h>
#include <avr/interrupt.h>

#include "adc.h"
#include "spi.h"

volatile uint32_t _millis;

uint32_t millis()
{
    // Actually fires every 0.9765625 ms.
    // Disable interrupt while reading to avoid corrupted value
    RTC.PITINTCTRL &= ~RTC_PI_bm;
    const auto res = _millis;
    RTC.PITINTCTRL |= RTC_PI_bm;
    return res;
}

ISR(RTC_PIT_vect)
{
    // Do not forget to clear the flag!
    RTC.PITINTFLAGS = RTC_PI_bm;

    // Increment millis counter
    _millis += 1;
}

int main(void)
{
    // Clock init - 24 MHz
    CCP = CCP_IOREG_gc;
    CLKCTRL.OSCHFCTRLA = CLKCTRL_FRQSEL_24M_gc;

    // RTC init - 1 kHz interrupt
    RTC.CLKSEL = RTC_CLKSEL_OSC32K_gc;
    RTC.PITINTCTRL = RTC_PI_bm;
    RTC.PITCTRLA = RTC_PERIOD_CYC32_gc | RTC_PITEN_bm;

    PORTD.DIRSET = 0xFF;

    adc_init();
    spi_init();

    sei();

    auto last = millis();
    int8_t temperature;

    while (1)
    {
        const auto now = millis();
        if (now - last > 500)
        {
            last = now;
            PORTD.OUTTGL = PIN1_bm;
        }
        int16_t temperature = adc_update();
        spi_update(temperature);
    }
}
