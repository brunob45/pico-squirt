#ifndef TRIGGER_H
#define TRIGGER_H

#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/sem.h"

struct Trigger
{
    int target_n, target_us, pw;
    bool running;
    semaphore_t sem;
    uint32_t pin_mask;

    void init(uint pin)
    {
        target_n = -1;
        running = false;
        pin_mask = (1 << pin);
        sem_init(&sem, 1, 1);
    }

    static int64_t callback(alarm_id_t, void *data)
    {
        if (!data)
            return 0;

        Trigger *t = (Trigger *)data;
        if (t->running)
        {
            gpio_clr_mask(t->pin_mask);
            t->running = false;
            return 0;
        }
        else
        {
            gpio_set_mask(t->pin_mask);
            t->running = true;
            const uint pw = t->pw;
            sem_release(&t->sem); // allow compute_target, alarm has fired
            return pw;
        }
    }
};

#endif