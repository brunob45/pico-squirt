#ifndef __AVR_H__
#define __AVR_H__

void avr_init();
void avr_update();
uint16_t avr_get_adc(uint8_t idx);

#endif // __AVR_H__