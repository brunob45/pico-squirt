/*
 * main.cpp
 *
 * Created: 2025-08-22
 * Author : @brunob45
 */ 

#include <avr/io.h>
#include <util/delay.h>

#include "spi.h"

int main(void)
{
    ADC0.CTRLA = (1 << ADC_ENABLE_bp);
    spi_init();

    while (1)
    {
        spi_update();
    }
}
