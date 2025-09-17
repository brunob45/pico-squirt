#ifndef __ADC_CONV_H__
#define __ADC_CONV_H__

#include <cstdint>

#include "global_state.h"

typedef void (*adc_update_fn)(GlobalState*, uint16_t);

void mat_update(GlobalState* gs, uint16_t raw_adc);
void clt_update(GlobalState* gs, uint16_t raw_adc);
void map_update(GlobalState* gs, uint16_t raw_adc);
void bat_update(GlobalState* gs, uint16_t raw_adc);
void ego_update(GlobalState* gs, uint16_t raw_adc);
void tps_update(GlobalState* gs, uint16_t raw_adc);

#endif // __ADC_CONV_H__