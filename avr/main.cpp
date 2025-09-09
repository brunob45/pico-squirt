/*
 * main.cpp
 *
 * Created: 2025-08-22
 * Author : @brunob45
 */

#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

#include "buffer.h"

static Buffer buf;
volatile uint32_t _millis;

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
    uint8_t value = 0;
    buf.get(&value);

    // Send value
    SPI0.DATA = value;
}

ISR(ADC0_RESRDY_vect)
{
    const uint8_t channels[] = {1, 2, 3, 4, 5, 6, 7};
    static uint8_t index = 0;

    // 2.63 kHz (average)
    // Clear interrupt flag
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

static void clk_init()
{
    // Clock init - 24 MHz
    CCP = CCP_IOREG_gc;
    CLKCTRL.OSCHFCTRLA = CLKCTRL_FRQSEL_24M_gc;

    // RTC init - 1 kHz interrupt
    RTC.CLKSEL = RTC_CLKSEL_OSC32K_gc;
    RTC.PITINTCTRL = RTC_PI_bm;
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

static void adc_init()
{
    // ADC init
    // 1. Configure the ADC voltage reference in the Voltage Reference (VREF) peripheral.
    VREF.ADC0REF = VREF_REFSEL_VDD_gc; // VREF_REFSEL_2V048_gc;
    // 2. Optional: Select between Single-Ended or Differential mode by writing to the Conversion Mode (CONVMODE) bit in the Control A (ADCn.CTRLA) register.
    // 3. Configure the resolution by writing to the Resolution Selection (RESSEL) bit field in the ADCn.CTRLA register.
    ADC0.CTRLA = ADC_RESSEL_12BIT_gc;
    // 4. Optional: Configure to left adjust by writing a ‘1’ to the Left Adjust Result (LEFTADJ) bit in the ADCn.CTRLA register.
    // 5. Optional: Select the Free-Running mode by writing a ‘1’ to the Free-Running (FREERUN) bit in the ADCn.CTRLA register.
    ADC0.CTRLA &= ~ADC_FREERUN_bm;
    // 6. Optional: Configure the number of samples to be accumulated per conversion by writing to the Sample Accumulation Number Select (SAMPNUM) bit field in the Control B (ADCn.CTRLB) register.
    ADC0.CTRLB = ADC_SAMPNUM_ACC4_gc;
    // 7. Configure the ADC clock (CLK_ADC) by writing to the Prescaler (PRESC) bit field in the Control C (ADCn.CTRLC) register.
    ADC0.CTRLC = ADC_PRESC_DIV24_gc; // 24MHz/24=1us (0.5>x>8us)
    // 8. Select the positive ADC input by writing to the MUXPOS bit field in the ADCn.MUXPOS register.
    ADC0.MUXPOS = 1; // ADC_MUXPOS_TEMPSENSE_gc;
    // 9. Optional: Select the negative ADC input by writing to the MUXNEG bit field in the ADCn.MUXNEG register.
    // 10. Optional: Enable Start Event input by writing a ‘1’ to the Start Event Input (STARTEI) bit in the Event Control (ADCn.EVCTRL) register, and configure the Event System accordingly.
    // 11. Enable the ADC by writing a ‘1’ to the ADC Enable (ENABLE) bit in the ADCn.CTRLA register.
    ADC0.CTRLA |= (1 << ADC_ENABLE_bp);

    _delay_us(100); // wait until ADC is ready (>6us)

    // 1. In the Voltage Reference (VREF) peripheral, select the internal 2.048V reference as the ADC reference voltage.
    // 2. Select the temperature sensor as input in the ADCn.MUXPOS register.
    // 3. Configure the Initialization Delay by writing a configuration ≥ 25 × fCLK_ADC µs to the Initialization Delay (INITDLY) bit field in the Control D (ADCn.CTRLD) register.
    ADC0.CTRLD = ADC_INITDLY_DLY32_gc | ADC_SAMPDLY_DLY0_gc; // fCLK_ADC=1MHz=1us
    // 4. Configure the ADC Sample Length by writing a configuration ≥ 28 µs × fCLK_ADC to the Sample Length (SAMPLEN) bit field in the SAMPCTRL (ADCn.SAMPCTRL) register.
    ADC0.SAMPCTRL = 32; // fCLK_ADC=1MHz=1us
    // 5. Acquire the temperature sensor output voltage by running a 12-bit, right-adjusted, single-ended conversion.
    ADC0.COMMAND = ADC_STCONV_bm;
    // 6. Process the measurement result
}

static void spi_init()
{
    // PORTMUX = ALT5
    // PC0 => MOSI
    // PC1 => MISO
    // PC2 => SCK
    // PC3 => CS
    PORTMUX.SPIROUTEA = 0x05;

    // Initialize the SPI to a basic functional state by following these steps:
    // 1. Configure the SS pin in the port peripheral.
    PORTC.DIRSET = PIN1_bm; // Set MISO as OUTPUT
    // 2. Select the SPI host/client operation by writing the Host/Client Select (MASTER) bit in the Control A (SPIn.CTRLA) register.
    // 3. In Host mode, select the clock speed by writing the Prescaler (PRESC) bits and the Clock Double (CLK2X) bit in SPIn.CTRLA.
    // 4. Optional: Select the Data Transfer mode by writing to the MODE bits in the Control B (SPIn.CTRLB) register.
    // 5. Optional: Write the Data Order (DORD) bit in SPIn.CTRLA.
    // 6. Optional: Set up the Buffer mode by writing the BUFEN and BUFWR bits in the Control B (SPIn.CTRLB) register.
    // 7. Optional: To disable the multi-host support in Host mode, write ‘1’ to the Client Select Disable (SSD) bit in SPIn.CTRLB.
    // 8. Enable the SPI by writing a ‘1’ to the ENABLE bit in SPIn.CTRLA
    SPI0.CTRLA = SPI_ENABLE_bm;

    // Enable interrupt
    SPI0.INTCTRL = SPI_IE_bm;
}

int main(void)
{
    PORTA.DIRSET = (1 << 6); // PA6 is the top right pin

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
            PORTA.OUTTGL = (1 << 6);
        }
    }
}
