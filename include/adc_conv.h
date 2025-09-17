#ifndef __ADC_CONV_H__
#define __ADC_CONV_H__

#include <cstdint>

#include "global_state.h"

typedef void (*adc_update_fn)(GlobalState*, uint16_t);

void mat_update(GlobalState* gs, uint16_t adc_value);
void clt_update(GlobalState* gs, uint16_t adc_value);
void map_update(GlobalState* gs, uint16_t adc_value);
void bat_update(GlobalState* gs, uint16_t adc_value);
void ego_update(GlobalState* gs, uint16_t adc_value);
void tps_update(GlobalState* gs, uint16_t adc_value);
void adc6_update(GlobalState* gs, uint16_t adc_value);

#endif // __ADC_CONV_H__