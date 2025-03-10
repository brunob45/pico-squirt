
#ifndef DECODER_H
#define DECODER_H

#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/util/queue.h"
#include "pico/sem.h"

#include "trigger.h"

struct Decoder
{
    absolute_time_t ts_prev;
    uint32_t delta_prev;
    uint sync_step = 0, sync_count = 0;
    volatile alarm_id_t timeout_alarm_id = 0;
    queue_t queue;
    uint pulse_angles[60];

    const uint FULL_CYCLE = 7200UL;
    const uint N_PULSES = 24;
    const uint N_MISSING = 1;

    void enable(uint pin);
    bool update();
    void compute_target(Trigger *target, uint end_deg, uint pw);

private:
    uint find_pulse(uint angle)
    {
        uint result;
        for (uint i = 0; i < (N_PULSES - N_MISSING); i++)
        {
            if (pulse_angles[i] < angle)
            {
                result = i;
            }
        }
        return result;
    }
    static int64_t sync_loss_cb(alarm_id_t, void *data)
    {
        if (data)
            *(uint *)data = 0;
        return 0;
    }
    void update_output_alarm(uint32_t us, uint *step)
    {
        const alarm_id_t id = timeout_alarm_id;
        if (id > 0)
        {
            cancel_alarm(id);
        }
        timeout_alarm_id = add_alarm_in_us(us, sync_loss_cb, step, true);
    }
};

#endif // DECODER_H