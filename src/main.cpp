#include <stdio.h>
#include <cstring>

#include "pico/stdlib.h"

#include "pico/multicore.h"

#include "hardware/watchdog.h"
#include "hardware/gpio.h"
#include "hardware/adc.h"

#include "tusb.h"

#include "avr.h"
#include "decoder.h"
#include "flash.h"
#include "global_state.h"
#include "linear_interp.h"
#include "crc32.h"

static GlobalState gs;

static uint8_t *page1_offset = (uint8_t *)XIP_BASE + PICO_FLASH_SIZE_BYTES - FLASH_SECTOR_SIZE;

static struct
{
    uint32_t page_flags;
    uint32_t page_crc;

    uint16_t ve_table[16 * 16];
    uint16_t afr_table[16 * 16];
    uint16_t adv_table[16 * 16];

    int16_t ve_x_axis[16];
    int16_t ve_y_axis[16];
} page1;

void transmit_response(const uint8_t *buffer, size_t n)
{
    // compute crc on payload (exclude size)
    const uint32_t crc = Crc32_ComputeBuf(0, buffer, n);
    // final packet size
    const uint16_t packet_size = n + 6;

    if (true)
    {
        // transmit size first
        tud_cdc_write_char(packet_size >> 8);
        tud_cdc_write_char(packet_size);
        // then the actual payload
        tud_cdc_write(buffer, n);
        // and finally the crc
        tud_cdc_write_char(crc >> 24);
        tud_cdc_write_char(crc >> 16);
        tud_cdc_write_char(crc >> 8);
        tud_cdc_write_char(crc >> 0);
    }
    else
    {
        // debug
        printf("%d:", packet_size);
        for (size_t i = 0; i < n; i++)
        {
            printf("%x,", buffer[i]);
        }
        printf("%x\n", crc);
    }
}

void core1_entry()
{
    static uint8_t buffer[4096];
    static uint16_t buffer_size = 0;

    while (true)
    {
        buffer_size += tud_cdc_read(buffer + buffer_size, sizeof(buffer) - buffer_size);
        if (buffer_size >= 7) // minimum size for valid packet
        {
            uint16_t packet_size = buffer[1] + 0x100 * buffer[0]; // big-endian
            printf("%d\n", packet_size);
            if (buffer_size >= packet_size) // full packet received
            {
                gpio_xor_mask(1 << 25);
                uint32_t crc_rx = buffer[buffer_size - 1] +
                                  (0x100 * buffer[buffer_size - 2]) +
                                  (0x10000 * buffer[buffer_size - 3]) +
                                  (0x1000000 * buffer[buffer_size - 4]);
                uint32_t crc = Crc32_ComputeBuf(0, buffer + 2, buffer_size - 6); // exclude size and crc

                // printf("%x==%x\n", crc_rx, crc);

                switch (buffer[2])
                {
                case 'c':
                {
                    uint16_t seconds = time_us_64() / 1'000'000;
                    uint8_t res[] = {
                        0, // OK flag
                        (uint8_t)(seconds >> 8),
                        (uint8_t)(seconds),
                    };
                    transmit_response(res, sizeof(res));
                    break;
                }
                case 'F':
                {
                    uint8_t res[] = " 002";
                    res[0] = 0;                              // OK flag
                    transmit_response(res, sizeof(res) - 1); // ignore last null char
                    break;
                }
                case 'Q':
                {
                    uint8_t res[] = " MS2Extra comms342h2";
                    res[0] = 0;                              // OK flag
                    transmit_response(res, sizeof(res));
                    break;
                }
                case 'S':
                {
                    uint8_t res[] = " Picosquirt 2025-09";
                    res[0] = 0;                              // OK flag
                    transmit_response(res, sizeof(res));
                    break;
                }
                }
                buffer_size = 0;
            }
        }
    }
}

static int16_t axis[] = {100, 200, 300, 400};
static uint16_t table[] = {
    10, 20, 30, 40,
    20, 30, 40, 50,
    30, 40, 50, 60,
    40, 50, 60, 70};

volatile uint16_t test;

int main()
{
    Decoder dec;

    stdio_init_all();

    // Watchdog example code
    if (watchdog_caused_reboot())
    {
        printf("Rebooted by Watchdog!\n");
        // Whatever action you may take if a watchdog caused a reboot
    }

    // Enable the watchdog, requiring the watchdog to be updated every 100ms or the chip will reboot
    watchdog_enable(100, true);

    // Init onboard LED
    gpio_init(PICO_DEFAULT_LED_PIN);
    gpio_set_dir(PICO_DEFAULT_LED_PIN, 1);
    gpio_put(PICO_DEFAULT_LED_PIN, 1);

    // Initialize the ADC
    adc_init();
    adc_set_temp_sensor_enabled(true);
    adc_select_input(ADC_TEMPERATURE_CHANNEL_NUM);
    hw_set_bits(&adc_hw->cs, ADC_CS_START_ONCE_BITS); // Start conversions

    // Initialize the hardware interp
    linear_interp_init();

    // Read flash
    memcpy(&page1, page1_offset, sizeof(page1));

    avr_init(); // SPI & UPDI

    dec.enable(0);

    multicore_launch_core1(core1_entry);

    uint32_t last_loop_time = time_us_32();
    gs.loop_time_avg = 0;

    while (true)
    {
        watchdog_update();
        dec.update(&gs);
        // avr_update_updi();
        avr_update_adc(&gs);

        if (adc_hw->cs & ADC_CS_READY_BITS)
        {
            auto adc_value = adc_hw->result;
            float volt = 3.3f * adc_value / 4095;
            float temperature = 27 - (volt - 0.706f) / 0.001721f;
            gs.pico_temperature = (int16_t)(temperature * 10);
            hw_set_bits(&adc_hw->cs, ADC_CS_START_ONCE_BITS);
        }
        {
            // Print ADC values
            // for (int i = 0; i < 7; i++)
            //     printf("%d %d, ", i, avr_get_adc(i));
            // printf("%0.2f\n", temperature);
            uint32_t cpt = 0;
            absolute_time_t end = get_absolute_time() + 1000;
            while (get_absolute_time() < end)
            {
                int16_t x = 150, y = 150, z;
                test = bilinear_interp(axis, 4, axis, 4, table, x, y);
                // printf("x:%d y:%d z:%d\n", x, y, z);
                // y = 250;
                // z = bilinear_interp(axis, 4, axis, 4, table, x, y);
                // printf("x:%d y:%d z:%d\n", x, y, z);
                // y = 350;
                // z = bilinear_interp(axis, 4, axis, 4, table, x, y);
                // printf("x:%d y:%d z:%d\n", x, y, z);
                cpt++;
            }
            // printf("%ld\n", cpt);
        }

        // Compute loop time
        const uint32_t loop_time = time_us_32() - last_loop_time;
        last_loop_time = time_us_32();
        gs.loop_time_avg = (loop_time + gs.loop_time_avg * 99) / 100;
        if (loop_time > gs.loop_time_max)
            gs.loop_time_max = loop_time;
    }
}
