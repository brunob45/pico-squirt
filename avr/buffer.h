#include <avr/io.h>

class Buffer
{
    uint8_t buf[8];
    uint8_t head, tail, full;

public:
    bool put(uint8_t value)
    {
        bool ret = false;
        if (!full)
        {
            buf[head] = value;
            head += 1;
            full = (head == tail);
            ret = true;
        }
        return ret;
    }

    uint8_t get()
    {
        uint8_t value = 0;
        if ((head != tail) || full)
        {
            value = buf[tail];
            tail += 1;
            full = 0;
        }
        return value;
    }
};