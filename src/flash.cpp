#include <stdio.h>
#include "pico/flash.h"
#include "hardware/flash.h"

// https://github.com/raspberrypi/pico-examples/blob/master/flash/program/flash_program.c
// https://forums.raspberrypi.com/viewtopic.php?f=145&t=304201&p=1820770&hilit=Hermannsw+systick#p1822677

// We're going to erase and reprogram a region 256k from the start of flash.
// Once done, we can access this at XIP_BASE + 256k.
#define FLASH_TARGET_OFFSET (256 * 1024)

const uint8_t *flash_target_contents = (const uint8_t *)(XIP_BASE + FLASH_TARGET_OFFSET);

void print_buf(const uint8_t *buf, size_t len)
{
    for (size_t i = 0; i < len; ++i)
    {
        printf("%02x", buf[i]);
        if (i % 16 == 15)
            printf("\n");
        else
            printf(" ");
    }
}

// This function will be called when it's safe to call flash_range_erase
static void call_flash_range_erase(void *param)
{
    uint32_t offset = (uint32_t)param;
    flash_range_erase(offset, FLASH_SECTOR_SIZE);
}

// This function will be called when it's safe to call flash_range_program
static void call_flash_range_program(void *param)
{
    uint32_t offset = ((uintptr_t *)param)[0];
    const uint8_t *data = (const uint8_t *)((uintptr_t *)param)[1];
    flash_range_program(offset, data, FLASH_PAGE_SIZE);
}
