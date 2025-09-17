
#ifndef DECODER_H
#define DECODER_H

#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/util/queue.h"
#include "pico/sem.h"

#include "libdivide.h"

#include "trigger.h"
#include "global_state.h"

struct Decoder
{
    absolute_time_t ts_prev, next_timeout;
    uint delta_prev;
    uint sync_step = 0;
    uint sync_count = 0;
    volatile alarm_id_t timeout_alarm_id = 0;
    queue_t queue;
    uint pulse_angles[60];

    uint full_cycle_us;
    libdivide::divider<uint> fast_d;

    const uint N_PULSES = 24;
    const uint N_MISSING = 1;

    void enable(uint pin);
    bool update(GlobalState* gs);
    bool compute_target(Trigger *target, uint end_deg, uint pw);

private:
    uint find_pulse(uint angle)
    {
        // find last pulse lower than angle
        uint result = (N_PULSES - N_MISSING - 1);
        if (angle > 0)
        {
            while (angle <= pulse_angles[result])
            {
                result -= 1;
            }
        }
        return result;
    }
    uint get_rpm()
    {
        return 0x8000U / fast_d;
    }
};

#endif // DECODER_H