#ifndef __AVR_H__
#define __AVR_H__

#include "global_state.h"

void avr_init();
void avr_update_updi();
void avr_update_adc(GlobalState* gs);

#endif // __AVR_H__