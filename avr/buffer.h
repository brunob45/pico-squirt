#include <avr/io.h>

class Buffer
{
    uint8_t buf[16];
    uint8_t head, tail, full;

public:
    bool put(uint8_t value)
    {
        bool ret = false;
        if (!full)
        {
            buf[head] = value;
            head += 1;
            if (head >= sizeof(buf))
                head = 0;
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
            if (tail >= sizeof(buf))
                tail = 0;
            full = 0;
        }
        return value;
    }
};