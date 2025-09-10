/*
 * main.cpp
 *
 * Created: 2025-08-22
 * Author : @brunob45
 */

#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/wdt.h>
#include <util/delay.h>

#include "buffer.h"

static Buffer buf;
volatile uint32_t _millis;

const uint8_t ADC_INPUTS[] = {
    ADC_MUXPOS_AIN1_gc,
    ADC_MUXPOS_AIN2_gc,
    ADC_MUXPOS_AIN3_gc,
    ADC_MUXPOS_AIN4_gc,
    ADC_MUXPOS_AIN5_gc,
    ADC_MUXPOS_AIN6_gc,
    ADC_MUXPOS_AIN7_gc,
};

ISR(RTC_PIT_vect)
{
    // Clear interrupt flag
    RTC.PITINTFLAGS = RTC_PI_bm;

    // Increment millis counter
    _millis += 1;
}

ISR(SPI0_INT_vect)
{
    // Clear interrupt flag
    SPI0.INTFLAGS = SPI_IF_bm;

    // Get analog value
    const uint8_t value = buf.get();

    // Send value
    SPI0.DATA = value;
}

ISR(ADC0_RESRDY_vect)
{
    static uint8_t index = 0;

    // 16 kHz (in theory)
    // Clear interrupt flag
    ADC0.INTFLAGS = ADC_RESRDY_bm;
    // PORTD.OUTTGL = PIN3_bm;

    // result for channel n is ready
    buf.put(ADC_INPUTS[index]);
    buf.put(ADC0.RESL);
    buf.put(ADC0.RESH);

    // prepare channel n+1
    index += 1;
    if (index >= 7)
        index = 0;

    ADC0.MUXPOS = ADC_INPUTS[index];

    // start conversion
    ADC0.COMMAND = ADC_STCONV_bm;
}

static void CLK_init()
{
    // Select 24 MHz internal oscillator
    CCP = CCP_IOREG_gc;
    CLKCTRL.OSCHFCTRLA = CLKCTRL_FRQSEL_24M_gc;

    // Wait until oscillator is stable
    while (!(CLKCTRL.OSCHFCTRLA & CLKCTRL_OSCHFS_bm))
        ;

    // RTC - Select 32kHz CLK
    RTC.CLKSEL = RTC_CLKSEL_OSC32K_gc;

    // Enable PIT interrupt
    RTC.PITINTCTRL = RTC_PI_bm;

    // Enable PIT @ 1kHz
    RTC.PITCTRLA = RTC_PERIOD_CYC32_gc | RTC_PITEN_bm;
}

static uint32_t millis()
{
    // Actually fires every 0.9765625 ms.
    // Disable interrupt while reading to avoid corrupted value
    RTC.PITINTCTRL &= ~RTC_PI_bm;
    const uint32_t res = _millis;
    RTC.PITINTCTRL |= RTC_PI_bm;
    return res;
}

static void ADC0_init()
{
    // Configure the ADC voltage reference in the Voltage Reference (VREF) peripheral.
    VREF.ADC0REF = VREF_REFSEL_VDD_gc;

    // Configure the number of samples to be accumulated per conversion by writing to the Sample Accumulation Number Select (SAMPNUM) bit field in the Control B (ADCn.CTRLB) register.
    ADC0.CTRLB = ADC_SAMPNUM_ACC4_gc;

    // Configure the ADC clock (CLK_ADC) by writing to the Prescaler (PRESC) bit field in the Control C (ADCn.CTRLC) register.
    ADC0.CTRLC = ADC_PRESC_DIV24_gc; // 24 MHz / 24 = 1 MHz => 1 us (0.5 > x > 8us)

    // Select the positive ADC input by writing to the MUXPOS bit field in the ADCn.MUXPOS register.
    ADC0.MUXPOS = ADC_MUXPOS_AIN1_gc;

    // Enable the ADC by writing a ‘1’ to the ADC Enable (ENABLE) bit in the ADCn.CTRLA register.
    ADC0.CTRLA |= (1 << ADC_ENABLE_bp);

    // Wait until ADC is ready (>6us)
    _delay_us(100);

    // Start conversion
    ADC0.COMMAND = ADC_STCONV_bm;

    // Enable interrupt
    ADC0.INTCTRL = ADC_RESRDY_bm;
}

static void SPI0_init()
{
    // PORTMUX = ALT5
    // PC0 => MOSI
    // PC1 => MISO
    // PC2 => SCK
    // PC3 => CS
    PORTMUX.SPIROUTEA = PORTMUX_SPI0_ALT5_gc;

    // Set MISO (PC1) as output, others as input
    PORTC.DIRSET = PIN1_bm;                     // MISO
    PORTC.DIRCLR = PIN0_bm | PIN2_bm | PIN3_bm; // MOSI, SCK, SS

    // Enable the SPI by writing a ‘1’ to the ENABLE bit in SPIn.CTRLA
    SPI0.CTRLA = SPI_ENABLE_bm;

    // Enable interrupt
    SPI0.INTCTRL = SPI_IE_bm;
}

int main(void)
{
    PORTA.DIRSET = (1 << 6); // PA6 is the top right pin

    CLK_init();
    ADC0_init();
    SPI0_init();
    wdt_enable(WDTO_250MS);

    sei();

    uint32_t last = millis();

    while (1)
    {
        wdt_reset();
        const uint32_t now = millis();
        if (now - last > 500)
        {
            last = now;
            PORTA.OUTTGL = (1 << 6);
        }
    }
}
