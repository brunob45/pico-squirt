#include <avr/io.h>
#include <util/delay.h>

void adc_init()
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
    // 6. Process the measurement result as described below
}
