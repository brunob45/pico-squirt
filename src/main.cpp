#include <stdio.h>
#include <stdlib.h>
#include <tusb.h>

#include "pico/stdlib.h"
#include "pico/flash.h"
#include "hardware/flash.h"
#include "hardware/structs/systick.h"

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

int main()
{
    stdio_init_all();
    systick_hw->csr = 0x5;
    systick_hw->rvr = 0x00FFFFFF;

    uint32_t begin, old, t0, t1;

    while (!tud_cdc_connected())
    {
        sleep_ms(100);
    }
    printf("tud_cdc_connected()\n");

    // t0 = time_us_32();
    // old = systick_hw->cvr;

    // sleep_us(50000);
    // begin = systick_hw->cvr;
    // t1 = time_us_32();

    // uint32_t d = (old - begin) & 0x00FFFFFF;

    // printf("\n          old-new=%ld\n", d);
    // printf("            t1-t0=%ld\n", t1 - t0);
    // printf("(old-new)/(t1-t0)=%.1f\n", (d) / (t1 - t0 * 1.0));

    uint8_t random_data[FLASH_PAGE_SIZE];
    for (uint i = 0; i < FLASH_PAGE_SIZE; ++i)
        random_data[i] = rand() >> 16;

    printf("Generated random data:\n");
    print_buf(random_data, FLASH_PAGE_SIZE);

    // Note that a whole number of sectors must be erased at a time.
    printf("\nErasing target region...\n");

    // Flash is "execute in place" and so will be in use when any code that is stored in flash runs, e.g. an interrupt handler
    // or code running on a different core.
    // Calling flash_range_erase or flash_range_program at the same time as flash is running code would cause a crash.
    // flash_safe_execute disables interrupts and tries to cooperate with the other core to ensure flash is not in use
    // See the documentation for flash_safe_execute and its assumptions and limitations
    old = time_us_32(); // systick_hw->cvr;
    int rc = flash_safe_execute(call_flash_range_erase, (void *)FLASH_TARGET_OFFSET, UINT32_MAX);
    begin = time_us_32(); // systick_hw->cvr;
    hard_assert(rc == PICO_OK);

    uint32_t d = (begin-old) & 0x00FFFFFF;
    printf("Done in %ld. Read back target region:\n", d);
    print_buf(flash_target_contents, FLASH_PAGE_SIZE);

    printf("\nProgramming target region...\n");
    uintptr_t params[] = {FLASH_TARGET_OFFSET, (uintptr_t)random_data};
    old = time_us_32(); // systick_hw->cvr;
    rc = flash_safe_execute(call_flash_range_program, params, UINT32_MAX);
    begin = time_us_32(); // systick_hw->cvr;
    hard_assert(rc == PICO_OK);
    d = (begin-old) & 0x00FFFFFF;
    printf("Done in %ld. Read back target region:\n", d);
    print_buf(flash_target_contents, FLASH_PAGE_SIZE);

    bool mismatch = false;
    for (uint i = 0; i < FLASH_PAGE_SIZE; ++i)
    {
        if (random_data[i] != flash_target_contents[i])
            mismatch = true;
    }
    if (mismatch)
        printf("Programming failed!\n");
    else
        printf("Programming successful!\n");

    while (1)
        tight_loop_contents();

    return 0;
}