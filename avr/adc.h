#ifndef __ADC_H__
#define __ADC_H__

#include <avr/io.h>

void adc_init();
int16_t adc_update();

#endif // __ADC_H__