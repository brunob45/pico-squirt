#include "adc_conv.h"

#include <pico/flash.h>
#include <hardware/flash.h>

void mat_update(GlobalState *gs, uint16_t adc_value)
{
    // Outputs 0.1 °C / bit
    const uint32_t MAT_OFFSET = PICO_FLASH_SIZE_BYTES - FLASH_SECTOR_SIZE * 1;
    const uint32_t MAT_SIZE = FLASH_PAGE_SIZE * sizeof(int16_t);
    const int16_t *MAT_CONTENTS = (const int16_t *)XIP_BASE + MAT_OFFSET;

    uint16_t idx = adc_value / 32;

    if (idx >= MAT_SIZE)
        idx = MAT_SIZE - 1;

    gs->manifold_temperature = MAT_CONTENTS[idx];
}

void clt_update(GlobalState *gs, uint16_t adc_value)
{
    // Outputs 0.1 °C / bit
    const uint32_t CLT_OFFSET = PICO_FLASH_SIZE_BYTES - FLASH_SECTOR_SIZE * 2;
    const uint32_t CLT_SIZE = FLASH_PAGE_SIZE * sizeof(int16_t);
    const int16_t *CLT_CONTENTS = (const int16_t *)XIP_BASE + CLT_OFFSET;

    uint16_t idx = adc_value / 32;

    if (idx >= CLT_SIZE)
        idx = CLT_SIZE - 1;

    gs->coolant_temperature = CLT_CONTENTS[idx];
}

void ego_update(GlobalState *gs, uint16_t adc_value)
{
    // Outputs 0.01:1 / bit
    // 0V =  7.35:1 = 0x0000 ADC
    // 5V = 22.39:1 = 0x3FFF ADC
    gs->air_fuel_ratio = adc_value * (2239 - 735) / 0x3FFF + 735;
}

void bat_update(GlobalState *gs, uint16_t adc_value)
{
    // Outputs 0.01 V / bit
    // 0V =  0.7V = 0x0000 ADC
    // 5V = 30.7V = 0x3FFF ADC
    gs->battery_voltage = adc_value * 3000 / 0x3FFF + 70;
}

void map_update(GlobalState *gs, uint16_t adc_value)
{
    static uint32_t map_accum, map_count, last_rev;

    // Outputs 0.1 kPa / bit
    // 0.25V =  20 kPa = 0x0333 ADC
    // 4.75V = 250 kPa = 0x3CCC ADC
    map_accum += adc_value * 2500 / 0x3FFF + 100;
    map_count += 1;
    if ((gs->rev_count != last_rev) || (gs->engine_speed < 600)) // 600 rpm = 33.3 ms / engine cycle
    {
        last_rev = gs->rev_count;
        gs->manifold_pressure = (map_accum + map_count / 2) / map_count;
        map_accum = map_count = 0;
    }
}

void tps_update(GlobalState *gs, uint16_t adc_value)
{
    // Outputs 0.1 % / bit
    // 0.5V =   0 % = 0x0666 ADC
    // 4.5V = 100 % = 0x3999 ADC
    if (adc_value < 0x0666)
        gs->throttle_position = 0;
    else if (adc_value > 0x3999)
        gs->throttle_position = 1000;
    else
        gs->throttle_position = (adc_value - 0x0666) * 1000 / (0x3999 - 0x0666);
}

void adc6_update(GlobalState *gs, uint16_t adc_value)
{
}