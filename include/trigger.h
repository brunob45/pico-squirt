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
    uint pw;
    absolute_time_t current_pulse_end;

public:
    void init(uint pin)
    {
        pin_mask = (1<<pin);
        gpio_init(pin);
        gpio_set_dir(pin, GPIO_OUT);

        sem_init(&sem, 1, 1);
    }
    bool update(absolute_time_t next_event, uint next_pw)
    {
        if (next_event < current_pulse_end)
        {
            // prevent creating new alarm before end of current pulse
            return false;
        }
        if (!sem_try_acquire(&sem))
        {
            // block update() while alarm is pending
            return false;
        }

        current_pulse_end = next_event + next_pw;
        pw = next_pw;
        add_alarm_at(next_event, Trigger::callback, this, true);
        return true;
    }
    void print_debug()
    {
        printf("trigger:%d+%d;", current_pulse_end, pw);
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
            sem_release(&t->sem); // allow update(), alarm has fired
            return -(int64_t)(pw);
        }
    }
};

#endif // TRIGGER_H