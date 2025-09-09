#include <avr/io.h>
#include <util/atomic.h>

class Buffer
{
    uint8_t buf[8];
    uint8_t head, tail, full;

public:
    bool put(uint8_t value)
    {
        bool ret = false;
        ATOMIC_BLOCK(ATOMIC_RESTORESTATE)
        {
            if (!full)
            {
                buf[head] = value;
                head += 1;
                full = (head == tail);
                ret = true;
            }
        }
        return ret;
    }

    bool get(uint8_t *value)
    {
        bool ret = false;
        if (value == 0)
            return ret; // null pointer

        ATOMIC_BLOCK(ATOMIC_RESTORESTATE)
        {
            if ((head != tail) || full)
            {
                *value = buf[tail];
                tail += 1;
                full = 0;
                ret = true;
            }
        }
        return ret;
    }
};