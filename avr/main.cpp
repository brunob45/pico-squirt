/*
 * main.cpp
 *
 * Created: 2025-08-22
 * Author : @brunob45
 */ 

#include <avr/io.h>
#include <util/delay.h>


int main(void)
{
    PORTA.DIR = 1;

    while (1) 
    {
        PORTA.OUT = 1;
        _delay_ms(500);
        PORTA.OUT = 0;
        _delay_ms(500);
    }
}
