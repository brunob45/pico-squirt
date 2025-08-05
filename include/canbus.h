#ifndef __CANBUS_H__
#define __CANBUS_H__

namespace CANbus
{
    void setup(void);
    int transmit(uint32_t id, uint8_t dlc,
                 uint8_t d0, uint8_t d1, uint8_t d2, uint8_t d3,
                 uint8_t d4, uint8_t d5, uint8_t d6, uint8_t d7);
}

#endif // __CANBUS_H__