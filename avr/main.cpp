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

static volatile uint32_t _millis;
static volatile uint8_t adc_res[3], adc_idx = __UINT8_MAX__;

ISR(RTC_PIT_vect)
{
    // Clear interrupt flag
    RTC.PITINTFLAGS = RTC_PI_bm;

    // Increment millis counter
    _millis += 1;
}

ISR(SPI0_INT_vect)
{
    SPI0.INTFLAGS = SPI_IF_bm;
    uint8_t spi_data = SPI0.DATA;
    if ((spi_data > 0) && !(ADC0.COMMAND & ADC_STCONV_bm))
    {
        ADC0.MUXPOS = spi_data;
        ADC0.COMMAND = ADC_STCONV_bm;
    }

    spi_data = 0;
    if (adc_idx < sizeof(adc_res))
    {
        spi_data = adc_res[adc_idx];
        adc_idx += 1;
    }
    SPI0.DATA = spi_data;
}

ISR(ADC0_RESRDY_vect)
{
    ADC0.INTFLAGS = ADC_RESRDY_bm;

    const uint16_t res = ADC0.RES;

    adc_res[0] = ADC0.MUXPOS;
    adc_res[1] = res;
    adc_res[2] = res >> 8;
    adc_idx = 0;
}

static void CLK_init()
{
    // Select 24 MHz internal oscillator
    CCP = CCP_IOREG_gc;
    CLKCTRL.OSCHFCTRLA = CLKCTRL_FRQSEL_24M_gc;

    // Wait until oscillator is stable
    // while (!(CLKCTRL.OSCHFCTRLA & CLKCTRL_OSCHFS_bm))
    //     ;

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

    // Enable the ADC by writing a ‘1’ to the ADC Enable (ENABLE) bit in the ADCn.CTRLA register.
    ADC0.CTRLA = ADC_ENABLE_bm;

    // Wait until ADC is ready (>6us)
    _delay_us(100);

    // Enable interrupt
    ADC0.INTCTRL = ADC_RESRDY_bm;
}

static void SPI0_init()
{
    // PORTMUX = ALT5
    // PC0 => MOSI => GP3
    // PC1 => MISO => GP4
    // PC2 => SCK  => GP2
    // PC3 => CS   => GP5
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
    PORTA.DIRSET = PIN6_bm; // PA6 is the top right pin

    CLK_init();
    ADC0_init();
    SPI0_init();
    // wdt_enable(WDTO_250MS);

    sei();

    uint32_t last = millis();

    while (1)
    {
        // wdt_reset();
        const uint32_t now = millis();
        if (now - last > 500)
        {
            last = now;
            PORTA.OUTTGL = PIN6_bm;
        }
        if (PORTC.IN & PIN3_bm)
        {
            adc_idx = __UINT8_MAX__;
        }
    }
}
