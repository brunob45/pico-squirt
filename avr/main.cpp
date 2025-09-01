/*
 * main.cpp
 *
 * Created: 2025-08-22
 * Author : @brunob45
 */

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

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

    // ADC init
    // 1. Configure the ADC voltage reference in the Voltage Reference (VREF) peripheral.
    VREF.ADC0REF = VREF_REFSEL_2V048_gc; // VREF_REFSEL_VDD_gc;
    // 2. Optional: Select between Single-Ended or Differential mode by writing to the Conversion Mode (CONVMODE) bit in the Control A (ADCn.CTRLA) register.
    // 3. Configure the resolution by writing to the Resolution Selection (RESSEL) bit field in the ADCn.CTRLA register.
    ADC0.CTRLA = ADC_RESSEL_12BIT_gc;
    // 4. Optional: Configure to left adjust by writing a ‘1’ to the Left Adjust Result (LEFTADJ) bit in the ADCn.CTRLA register.
    // 5. Optional: Select the Free-Running mode by writing a ‘1’ to the Free-Running (FREERUN) bit in the ADCn.CTRLA register.
    ADC0.CTRLA |= ADC_FREERUN_bm;
    // 6. Optional: Configure the number of samples to be accumulated per conversion by writing to the Sample Accumulation Number Select (SAMPNUM) bit field in the Control B (ADCn.CTRLB) register.
    // 7. Configure the ADC clock (CLK_ADC) by writing to the Prescaler (PRESC) bit field in the Control C (ADCn.CTRLC) register.
    ADC0.CTRLC = ADC_PRESC_DIV256_gc; // 24MHz/256=10.67us (>8us)
    // 8. Select the positive ADC input by writing to the MUXPOS bit field in the ADCn.MUXPOS register.
    ADC0.MUXPOS = ADC_MUXPOS_TEMPSENSE_gc;
    // 9. Optional: Select the negative ADC input by writing to the MUXNEG bit field in the ADCn.MUXNEG register.
    // 10. Optional: Enable Start Event input by writing a ‘1’ to the Start Event Input (STARTEI) bit in the Event Control (ADCn.EVCTRL) register, and configure the Event System accordingly.
    // 11. Enable the ADC by writing a ‘1’ to the ADC Enable (ENABLE) bit in the ADCn.CTRLA register.
    ADC0.CTRLA |= (1 << ADC_ENABLE_bp);

    // 463 us / conversion
    ADC0.CTRLD = ADC_INITDLY_DLY32_gc; // >=25
    ADC0.SAMPCTRL = 28; // >=28

    _delay_ms(1); // wait until ADC is ready (6us)

    ADC0.COMMAND = ADC_STCONV_bm;

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
        if (ADC0.INTFLAGS & ADC_RESRDY_bm)
        {
            ADC0.INTFLAGS = ADC_RESRDY_bm;
            PORTD.OUTTGL = PIN3_bm;

            const auto slope = SIGROW.TEMPSENSE0;
            const auto offset = SIGROW.TEMPSENSE1;
            const auto adc_raw = ADC0.RES;

            uint32_t temp = (offset - adc_raw);
            temp *= slope;
            temp += 4096/2;
            temp /= 4096;
            temperature = temp - 273;
        }
        spi_update(temperature);
    }
}
