
#include "pico/util/queue.h"

typedef struct {
    uint n_pulses;
    uint n_missing;
    queue_t* queue;
} decoder_t;

void decoder_enable(decoder_t* d);
void decoder_update(decoder_t *d);
