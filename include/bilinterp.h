#ifndef __BILINTERP_H__
#define __BILINTERP_H__

#include <cstdint>
#include <stdio.h>

#include "hardware/interp.h"

// binary search on the axis
template <typename T = int16_t>
static size_t find_bin(const T *axis, size_t n, T v)
{
    size_t lo = 0, hi = n - 1;
    while (hi - lo > 1)
    {
        size_t mid = (lo + hi) / 2;
        if (v < axis[mid])
            hi = mid;
        else
            lo = mid;
    }
    return lo;
}

template <typename T = int16_t>
static uint16_t linear_interp(
    const T *x_axis, size_t nx,
    const uint8_t *table,
    T x)
{
    // Clamp inside valid range
    x = MIN(MAX(x, x_axis[0]), x_axis[nx - 1] - 1);

    size_t ix = find_bin(x_axis, nx, x);

    T x0 = x_axis[ix];
    T x1 = x_axis[ix + 1];

    uint16_t q11 = 256U * table[ix];
    uint16_t q21 = 256U * table[ix + 1];

    // 0..0xFF
    uint32_t tx = 256U * (x - x0) / (x1 - x0);

    uint16_t y = q11 + ((tx * (q21 - q11)) >> 8);

    printf("x: %d, tx:%d, x0:%d, x1:%d, y:%d\n", x, tx, q11, q21, y);

    return y;
}

template <typename T = int16_t>
static uint16_t bilinear_interp(
    const T *x_axis, size_t nx,
    const T *y_axis, size_t ny,
    const uint16_t *table,
    T x, T y)
{
    // Clamp inside valid range
    x = MIN(MAX(x, x_axis[0]), x_axis[nx - 1] - 1);
    y = MIN(MAX(y, y_axis[0]), y_axis[ny - 1] - 1);

    size_t ix = find_bin(x_axis, nx, x);
    size_t iy = find_bin(y_axis, ny, y);

    T x0 = x_axis[ix];
    T x1 = x_axis[ix + 1];
    T y0 = y_axis[iy];
    T y1 = y_axis[iy + 1];

    uint16_t q11 = table[iy * nx + ix] << 8;
    uint16_t q21 = table[iy * nx + ix + 1] << 8;
    uint16_t q12 = table[(iy + 1) * nx + ix] << 8;
    uint16_t q22 = table[(iy + 1) * nx + ix + 1] << 8;

    // 0..0xFF
    T tx = ((x - x0) << 8) / (x1 - x0);
    T ty = ((y - y0) << 8) / (y1 - y0);

    T a = q11 + (tx * (q21 - q11)) >> 8;
    T b = q12 + (tx * (q22 - q12)) >> 8;
    return a + (ty * (b - a)) >> 8;
}

#endif // __BILINTERP_H__
