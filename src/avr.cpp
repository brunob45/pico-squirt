#include "hardware/gpio.h"
#include "hardware/uart.h"
#include "tusb.h"

// UART defines
// By default the stdout UART is `uart0`, so we will use the second one
#define UART_ID uart1
#define BAUD_RATE 115200
#define DATA_BITS 8
#define STOP_BITS 2
#define PARITY UART_PARITY_EVEN

// Use pins 4 and 5 for UART1
// Pins can be changed, see the GPIO function select table in the datasheet for information on GPIO assignments
#define UART_TX_PIN 8
#define UART_RX_PIN 9

void avr_init()
{
    // Set up our UART
    uart_init(UART_ID, BAUD_RATE);
    // Set the TX and RX pins by using the function select on the GPIO
    // Set datasheet for more information on function select
    gpio_set_function(UART_TX_PIN, GPIO_FUNC_UART);
    gpio_set_function(UART_RX_PIN, GPIO_FUNC_UART);

    // Set our data format
    uart_set_format(UART_ID, DATA_BITS, STOP_BITS, PARITY);

    // Use some the various UART functions to send out data
    // In a default system, printf will also output via the default UART

    // Send out a string, with CR/LF conversions
    // uart_puts(UART_ID, " Hello, UART!\n");

    // For more examples of UART use see https://github.com/raspberrypi/pico-examples/tree/master/uart
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
        gpio_xor_mask(1 << 25);
        const auto ch = uart_getc(UART_ID);
        tud_cdc_write_char(ch); // send on USB
        tud_cdc_write_flush();
    }
}