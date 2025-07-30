#ifndef TRIGGER_H
#define TRIGGER_H

#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/sem.h"

class Trigger
{
    bool running;
    semaphore_t sem;
    uint32_t pin_mask;

public:
    int target_n, target_us, pw;
    void init(uint pin)
    {
        gpio_init(pin);
        gpio_set_dir(pin, GPIO_OUT);
        pin_mask = (1 << pin);

        target_n = -1;
        running = false;
        sem_init(&sem, 1, 1);
    }
    bool update(uint pulse, absolute_time_t last_pulse)
    {
        if (pulse == target_n)
        {
            sem_try_acquire(&sem); // block compute_target while alarm is pending
            add_alarm_at(last_pulse + target_us, Trigger::callback, this, true);
            return true;
        }
        return false;
    }
    void print_debug()
    {
        printf("trigger:%d+%d;", target_n, target_us);
    }
    bool set_target(uint pulse_n, uint pulse_us, uint pw)
    {
        if (!sem_try_acquire(&sem))
        {
            return false;
        }
        this->target_n = pulse_n;
        this->target_us = pulse_us;
        this->pw = pw;
        sem_release(&sem);
        return true;
    }

private:
    static int64_t __not_in_flash_func(callback)(alarm_id_t, void *data)
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
            return -(int64_t)(pw);
        }
    }
};

#endif // TRIGGER_H