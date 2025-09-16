#include <pico/flash.h>
#include <hardware/flash.h>

uint16_t map_update(uint16_t raw_adc)
{
    const uint32_t MAP_OFFSET = PICO_FLASH_SIZE_BYTES - FLASH_SECTOR_SIZE * 1;
    const uint32_t MAP_SIZE = FLASH_PAGE_SIZE * sizeof(int16_t);
    const uint16_t *MAP_CONTENTS = (const uint16_t *)XIP_BASE + MAP_OFFSET;

    if (raw_adc < MAP_SIZE)
        return MAP_CONTENTS[raw_adc];
    return MAP_CONTENTS[0];
}

uint16_t mat_update(uint16_t raw_adc)
{
    const uint32_t MAT_OFFSET = PICO_FLASH_SIZE_BYTES - FLASH_SECTOR_SIZE * 2;
    const uint32_t MAT_SIZE = FLASH_PAGE_SIZE * sizeof(int16_t);
    const uint16_t *MAT_CONTENTS = (const uint16_t *)XIP_BASE + MAT_OFFSET;

    if (raw_adc < MAT_SIZE)
        return MAT_CONTENTS[raw_adc];
    return MAT_CONTENTS[0];
}

uint16_t clt_update(uint16_t raw_adc)
{
    const uint32_t CLT_OFFSET = PICO_FLASH_SIZE_BYTES - FLASH_SECTOR_SIZE * 3;
    const uint32_t CLT_SIZE = FLASH_PAGE_SIZE * sizeof(int16_t);
    const uint16_t *CLT_CONTENTS = (const uint16_t *)XIP_BASE + CLT_OFFSET;

    if (raw_adc < CLT_SIZE)
        return CLT_CONTENTS[raw_adc];
    return CLT_CONTENTS[0];
}