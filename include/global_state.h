#ifndef __GLOBAL_STATE_H__
#define __GLOBAL_STATE_H__

#include <cstdint>

struct GlobalState
{
    uint16_t adc[7];
    int16_t manifold_pressure;    // 0.1 kPa
    int16_t manifold_temperature; // 0.1 °C
    int16_t coolant_temperature;  // 0.1 °C
    int16_t throttle_position;    // 0.1 %
    int16_t air_fuel_ratio;       // 0.01:1
    int16_t battery_voltage;      // 0.01 V
    int16_t pico_temperature;     // 0.1 °C
    uint16_t engine_speed;        // 1 rpm
};

#endif // __GLOBAL_STATE_H__