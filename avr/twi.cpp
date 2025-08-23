#include <avr/io.h>
#include <avr/interrupt.h>

const uint8_t ADC_CHAN[] = {
    0x01,
    0x02,
    0x03,
    0x04,
    0x05,
    0x06,
    0x07,
    0x10,
    0x11,
    0x12,
    0x13,
    0x14,
    0x15,
    0x16,
    0x17,
    0x18,
    0x19,
    0x1a,
    0x1b,
    0x1c,
    0x1d,
    0x1e,
    0x1f,
    0x40,
    0x42,
    0x44,
    0x45,
    0x48,
    0x49,
};

void data_read()
{
    static uint16_t adc_result;

    while (ADC0.COMMAND & ADC_STCONV_bm)
        ; // wait until conversion is complete

    if (ADC0.INTFLAGS & ADC_RESRDY_bm)
    {
        // a measurement is complete and a new result is ready.
        adc_result = ADC0.RES;
        PORTC.OUTCLR = (1<<1);
    }
    TWI0.SDATA = adc_result;
    adc_result <<= 8;
}

void data_write()
{
    const uint8_t sdata = TWI0.SDATA;
    bool valid_addr = false;
    for (uint8_t i = 0; i < sizeof(ADC_CHAN); i++)
    {
        if (sdata == ADC_CHAN[i])
        {
            valid_addr = true;
            break;
        }
    }
    if (valid_addr)
    {
        PORTC.OUTSET = (1<<1);
        ADC0.MUXPOS = sdata;
        ADC0.COMMAND = (1 << ADC_STCONV_bp);
    }
}

ISR(TWI0_TWIS_vect)
{
    static bool valid_addr = 0;

    const uint8_t sstatus = TWI0.SSTATUS;
    if (sstatus & TWI_DIF_bm)
    {
        // Data Interrupt Flag
        if (sstatus & TWI_DIR_bm)
        {
            // host read
            data_read();
        }
        else
        {
            // host write
            data_write();
        }
    }
    if (sstatus & TWI_APIF_bm)
    {
        // Address or Stop Interrupt Flag
    }
}

void twi_init()
{
    PORTC.DIRSET = (1<<1);

    // controls the pin positions for TWI 0 signals.
    PORTMUX.TWIROUTEA = PORTMUX_TWI0_ALT2_gc; // SDA=PC2, SCL=PC3

    // enable pull-up resistors
    PORTC.PINCONFIG = (1 << PORT_PULLUPEN_bp);
    PORTC.PINCTRLUPD = (1 << 2) | (1 << 3);

    // Follow these steps to initialize the client:
    // 1. Before enabling the TWI client, configure the SDA Setup Time (SDASETUP) bit in the Control A (TWIn.CTRLA) register.
    TWI0.CTRLA = (TWI_SDASETUP_4CYC_gc);
    // 2. Write the client address to the Client Address (TWIn.SADDR) register.
    TWI0.SADDR = 0x45 << 1;
    // 3. Write a ‘1’ to the Enable TWI Client (ENABLE) bit in the Client Control A (TWIn.SCTRLA) register to enable the TWI client.
    TWI0.SCTRLA =
        (1 << TWI_DIEN_bp) |  // enables an interrupt on the Data Interrupt Flag (DIF)
        (1 << TWI_APIEN_bp) | // enables an interrupt on the Address or Stop Interrupt Flag (APIF)
        (0 << TWI_PIEN_bp) |  // allows the Address or Stop Interrupt Flag (APIF) in the Client Status (TWIn.SSTATUS) register to be set when a Stop condition occurs
        (0 << TWI_PMEN_bp) |  // the address match logic uses the Client Address
        (1 << TWI_ENABLE_bp); // enables the TWI client.
    // The TWI client will now wait for a host device to issue a Start condition and the matching client address.
}