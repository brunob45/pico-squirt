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
#include "clock.h"
#include "buffer.h"

Buffer buf;

ISR(SPI0_INT_vect)
{
    SPI0.INTFLAGS = SPI_IF_bm; // Clear interrupt flag

    uint8_t value = 0;
    buf.get(&value);
    SPI0.DATA = value; // Send value
}

ISR(ADC0_RESRDY_vect)
{
    const uint8_t channels[] = {1, 2, 3, 4, 5, 6, 7};
    static uint8_t index = 0;

    // 2.63 kHz (average)
    // clear interrupt flag
    ADC0.INTFLAGS = ADC_RESRDY_bm;
    // PORTD.OUTTGL = PIN3_bm;

    // result for channel n is ready
    buf.put(channels[index]);
    buf.put(ADC0.RESL);
    buf.put(ADC0.RESH);

    // prepare channel n+1
    index += 1;
    if (index >= 7)
        index = 0;

    ADC0.MUXPOS = channels[index];
    // start conversion
    ADC0.COMMAND = ADC_STCONV_bm;
}

int main(void)
{
    // PORTD.DIRSET = 0xFF;

    clk_init();
    adc_init();
    spi_init();

    sei();

    uint32_t last = millis();
    int8_t temperature;

    while (1)
    {
        const uint32_t now = millis();
        if (now - last > 500)
        {
            last = now;
            // PORTD.OUTTGL = PIN1_bm;
        }
    }
}
