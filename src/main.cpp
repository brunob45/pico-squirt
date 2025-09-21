#include <stdio.h>
#include <cstring>

#include "pico/stdlib.h"

#include "pico/multicore.h"

#include "hardware/watchdog.h"
#include "hardware/gpio.h"
#include "hardware/adc.h"

#include "avr.h"
#include "decoder.h"
#include "flash.h"
#include "global_state.h"
#include "linear_interp.h"

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

void core1_entry()
{
    auto last_trx = get_absolute_time();
    while (true)
    {
        if (get_absolute_time() - last_trx > 1'000'000) // 1s
        {
            last_trx = get_absolute_time();

            // Print ADC values
            printf("ADC0: %0.2f, %0.1f, ", 5.0f / 0x3fff * gs.adc[0], gs.manifold_pressure * 0.1f);
            printf("ADC1: %0.2f, %0.1f, ", 5.0f / 0x3fff * gs.adc[1], gs.manifold_temperature * 0.1f);
            printf("ADC2: %0.2f, %0.1f, ", 5.0f / 0x3fff * gs.adc[2], gs.coolant_temperature * 0.1f);
            printf("ADC3: %0.2f, %0.1f, ", 5.0f / 0x3fff * gs.adc[3], gs.throttle_position * 0.1f);
            printf("ADC4: %0.2f, %0.1f, ", 5.0f / 0x3fff * gs.adc[4], gs.battery_voltage * 0.01f);
            printf("ADC5: %0.2f, %0.1f, ", 5.0f / 0x3fff * gs.adc[5], gs.air_fuel_ratio * 0.01f);
            printf("ADC6: %0.2f, %0.1f, ", 5.0f / 0x3fff * gs.adc[6], 0.0f);
            printf("%0.1f°C, %d, %d\n", gs.pico_temperature * 0.1f, gs.loop_time_avg, gs.loop_time_max);
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
            printf("%ld\n", cpt);
        }

        // Compute loop time
        const uint32_t loop_time = time_us_32() - last_loop_time;
        last_loop_time = time_us_32();
        gs.loop_time_avg = (loop_time + gs.loop_time_avg * 99) / 100;
        if (loop_time > gs.loop_time_max)
            gs.loop_time_max = loop_time;
    }
}
