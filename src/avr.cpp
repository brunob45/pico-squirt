#include "hardware/gpio.h"
#include "hardware/uart.h"
#include "hardware/spi.h"
#include "tusb.h"

// UART defines
#define UART_ID uart1
#define UART_TX_PIN 8
#define UART_RX_PIN 9

// SPI defines
#define SPI_ID spi0

#define SPI_SCK_PIN 2
#define SPI_MOSI_PIN 3
#define SPI_MISO_PIN 4
#define SPI_CS_PIN 5

const uint8_t adc_mux[] = {1, 2, 3, 4, 5, 6, 7};
static uint16_t adc_values[7] = {0};
static uint8_t adc_idx = 0, spi_step = 0, adc_resl;

void avr_init()
{
    // Init UART
    uart_init(UART_ID, 115200);

    gpio_set_function(UART_TX_PIN, GPIO_FUNC_UART);
    gpio_set_function(UART_RX_PIN, GPIO_FUNC_UART);

    // Set our data format
    uart_set_format(UART_ID, 8, 2, UART_PARITY_EVEN);

    // Init SPI
    spi_init(SPI_ID, 1'000'000);
    gpio_set_function(SPI_SCK_PIN, GPIO_FUNC_SPI);
    gpio_set_function(SPI_MOSI_PIN, GPIO_FUNC_SPI);
    gpio_set_function(SPI_MISO_PIN, GPIO_FUNC_SPI);

    gpio_init(SPI_CS_PIN);
    gpio_set_dir(SPI_CS_PIN, 1);
    gpio_put(SPI_CS_PIN, 1);
}

void avr_update()
{
    const auto len = tud_cdc_available();
    if (len && uart_is_writable(UART_ID))
    {
        const auto ch = tud_cdc_read_char();
        if (ch >= 0 && ch <= 0xFF)
            uart_putc_raw(UART_ID, ch);
    }
    if (uart_is_readable(UART_ID))
    {
        const auto ch = uart_getc(UART_ID);
        tud_cdc_write_char(ch); // send on USB
        tud_cdc_write_flush();
    }

    switch (spi_step)
    {
    case 0: // Send channel
        // Clear buffer
        while (spi_is_readable(SPI_ID))
            (void)spi_get_hw(SPI_ID)->dr; // Should never happen

        // Assert CS line
        gpio_put(SPI_CS_PIN, 0);

        // Send ADC MUX index
        spi_get_hw(SPI_ID)->dr = adc_mux[adc_idx];

        spi_step += 1;
        break;

    case 1: // Receive ready flag
        if (spi_is_readable(SPI_ID))
        {
            const uint8_t spi_data = spi_get_hw(SPI_ID)->dr;
            spi_get_hw(SPI_ID)->dr = 0;

            if (spi_data == adc_mux[adc_idx])
            {
                spi_step += 1;
                // Prepare a second byte
                spi_get_hw(SPI_ID)->dr = 0;
            }
        }
        break;

    case 2: // Receive LSB
        if (spi_is_readable(SPI_ID))
        {
            // Receive RESL
            adc_resl = spi_get_hw(SPI_ID)->dr;
            spi_step += 1;
        }
        break;

    case 3: // Receive MSB and print
        if (spi_is_readable(SPI_ID))
        {
            // Receive RESH
            const uint8_t adc_resh = spi_get_hw(SPI_ID)->dr;

            // Clear CS line
            gpio_put(SPI_CS_PIN, 1);

            // Compute ADC value
            adc_values[adc_idx] = adc_resl + 256 * adc_resh;

            // Increment index for next transfer
            adc_idx += 1;
            if (adc_idx >= sizeof(adc_mux))
                adc_idx = 0;

            spi_step = 0;
        }
        break;
    }
}

uint16_t avr_get_adc(uint8_t idx)
{
    if (idx < sizeof(adc_mux))
        return adc_values[idx];

    return 0;
}