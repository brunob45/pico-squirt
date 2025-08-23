/*
 * main.cpp
 *
 * Created: 2025-08-22
 * Author : @brunob45
 */ 

#include <avr/io.h>
#include <util/delay.h>

void twi_init();

void set_out(bool out) {
    PORTC.DIRSET = (1<<0);
    if (out)
        PORTC.OUTSET = (1<<0);
    else
        PORTC.OUTCLR = (1<<0);
}

int main(void)
{
    ADC0.CTRLA = (1 << ADC_ENABLE_bp);
    twi_init();

    set_out(0);

    while (1) 
    {
        set_out(1);
        _delay_ms(500);
        set_out(0);
        _delay_ms(500);
    }
}
