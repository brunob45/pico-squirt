#ifndef __FLASH_H__
#define __FLASH_H__

#include <cstdint>

#include "pico/flash.h"
#include "hardware/flash.h"

// https://github.com/raspberrypi/pico-examples/blob/master/flash/program/flash_program.c
// https://forums.raspberrypi.com/viewtopic.php?f=145&t=304201&p=1820770&hilit=Hermannsw+systick#p1822677

// This function will be called when it's safe to call flash_range_erase
static int safe_flash_range_erase(size_t offset)
{
    void (*call_flash_range_erase)(void *) = [](void *args)
    {
        uint32_t offset = (uint32_t)args;
        flash_range_erase(offset, FLASH_SECTOR_SIZE);
    };
    return flash_safe_execute(call_flash_range_erase, &offset, UINT32_MAX);
}

// This function will be called when it's safe to call flash_range_program
static int safe_flash_range_program(size_t offset)
{
    void (*call_flash_range_program)(void *) = [](void *args)
    {
        uint32_t offset = ((uintptr_t *)args)[0];
        const uint8_t *data = (const uint8_t *)((uintptr_t *)args)[1];
        flash_range_program(offset, data, FLASH_PAGE_SIZE);
    };
    return flash_safe_execute(call_flash_range_program, &offset, UINT32_MAX);
}

#endif // __FLASH_H__