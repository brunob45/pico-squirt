#include <pico/flash.h>
#include <hardware/flash.h>

int16_t mat_update(uint16_t raw_adc)
{
    // Outputs 0.1 °C / bit
    const uint32_t MAT_OFFSET = PICO_FLASH_SIZE_BYTES - FLASH_SECTOR_SIZE * 1;
    const uint32_t MAT_SIZE = FLASH_PAGE_SIZE * sizeof(int16_t);
    const int16_t *MAT_CONTENTS = (const int16_t *)XIP_BASE + MAT_OFFSET;

    if (raw_adc < MAT_SIZE)
        return MAT_CONTENTS[raw_adc];
    return MAT_CONTENTS[0];
}

int16_t clt_update(uint16_t raw_adc)
{
    // Outputs 0.1 °C / bit
    const uint32_t CLT_OFFSET = PICO_FLASH_SIZE_BYTES - FLASH_SECTOR_SIZE * 2;
    const uint32_t CLT_SIZE = FLASH_PAGE_SIZE * sizeof(int16_t);
    const int16_t *CLT_CONTENTS = (const int16_t *)XIP_BASE + CLT_OFFSET;

    if (raw_adc < CLT_SIZE)
        return CLT_CONTENTS[raw_adc];
    return CLT_CONTENTS[0];
}

int16_t afr_update(uint16_t raw_adc)
{
    // Outputs 0.01:1 / bit
    // 0V =  7.35:1 = 0x0000 ADC
    // 5V = 22.39:1 = 0x3FFF ADC
    return raw_adc * (2239 - 735) / 0x3FFF + 735;
}

int16_t bat_update(uint16_t raw_adc)
{
    // Outputs 0.01 V / bit
    // 0V =  0.7V = 0x0000 ADC
    // 5V = 30.7V = 0x3FFF ADC
    return raw_adc * 3000 / 0x3FFF + 70;
}

int16_t map_update(uint16_t raw_adc)
{
    // Outputs 0.1 kPa / bit
    // 0.25V =  20 kPa = 0x0333 ADC
    // 4.75V = 250 kPa = 0x3CCC ADC
    return raw_adc * 2500 / 0x3FFF + 100;
}

int16_t tps_update(uint16_t raw_adc)
{
    // Outputs 0.1 % / bit
    // 0.5V =   0 % = 0x0666 ADC
    // 4.5V = 100 % = 0x3999 ADC
    if (raw_adc < 0x0666)
        return 0;
    else if (raw_adc > 0x3999)
        return 1000;
    else
        return (raw_adc - 0x0666) * 1000 / (0x3999 - 0x0666);
}