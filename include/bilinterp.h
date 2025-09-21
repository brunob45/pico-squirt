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
    const uint16_t *table,
    T x)
{
    // 514 ns (77 ops) per call
    // Clamp inside valid range
    x = MIN(MAX(x, x_axis[0]), x_axis[nx - 1] - 1);

    size_t ix = find_bin(x_axis, nx, x);

    T x0 = x_axis[ix];
    T x1 = x_axis[ix + 1];

    interp0->accum[1] = 256U * (x - x0) / (x1 - x0);
    interp0->base01 = *(uint32_t *)(table + ix);
    // printf("x:%d, y:%d\n", x, interp0->peek[1]);
    return interp0->peek[1];
}

template <typename T = int16_t>
static uint16_t bilinear_interp(
    const T *x_axis, size_t nx,
    const T *y_axis, size_t ny,
    const uint16_t *table,
    T x, T y)
{
    // 827 ns (124 ops) per call
    // Clamp inside valid range
    x = MIN(MAX(x, x_axis[0]), x_axis[nx - 1] - 1);
    y = MIN(MAX(y, y_axis[0]), y_axis[ny - 1] - 1);

    size_t ix = find_bin(x_axis, nx, x);
    size_t iy = find_bin(y_axis, ny, y);

    T x0 = x_axis[ix];
    T x1 = x_axis[ix + 1];
    T y0 = y_axis[iy];
    T y1 = y_axis[iy + 1];

    interp0->accum[1] = 256U * (x - x0) / (x1 - x0); // alpha on the x axis

    size_t offset = iy * nx + ix;
    interp0->base01 = *(uint32_t *)(table + offset); // blend on first row
    uint16_t a = interp0->peek[1];

    interp0->base01 = *(uint32_t *)(table + offset + nx); // blend on second row
    uint16_t b = interp0->peek[1];

    interp0->accum[1] = 256U * (y - y0) / (y1 - y0); // alpha on the y axis
    interp0->base[0] = a;                            // blend of the final value
    interp0->base[1] = b;
    return interp0->peek[1];
}

#endif // __BILINTERP_H__
