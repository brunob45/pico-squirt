#include <avr/io.h>
#include <avr/interrupt.h>

#include "spi.h"

// Pin position = ALT5
// PC0 => MOSI
// PC1 => MISO
// PC2 => SCK
// PC3 => CS

void spi_init()
{
    // Select correct PORTMUX
    PORTMUX.SPIROUTEA = 0x05;

    // Initialize the SPI to a basic functional state by following these steps:
    // 1. Configure the SS pin in the port peripheral.
    PORTC.DIRSET = PIN1_bm; // Set MISO as OUTPUT
    // 2. Select the SPI host/client operation by writing the Host/Client Select (MASTER) bit in the Control A (SPIn.CTRLA) register.
    // 3. In Host mode, select the clock speed by writing the Prescaler (PRESC) bits and the Clock Double (CLK2X) bit in SPIn.CTRLA.
    // 4. Optional: Select the Data Transfer mode by writing to the MODE bits in the Control B (SPIn.CTRLB) register.
    // 5. Optional: Write the Data Order (DORD) bit in SPIn.CTRLA.
    // 6. Optional: Set up the Buffer mode by writing the BUFEN and BUFWR bits in the Control B (SPIn.CTRLB) register.
    // 7. Optional: To disable the multi-host support in Host mode, write ‘1’ to the Client Select Disable (SSD) bit in SPIn.CTRLB.
    // 8. Enable the SPI by writing a ‘1’ to the ENABLE bit in SPIn.CTRLA
    SPI0.CTRLA = SPI_ENABLE_bm;

    // Enable interrupt
    SPI0.INTCTRL = SPI_IE_bm;
}
