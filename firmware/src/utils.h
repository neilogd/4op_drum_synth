#pragma once

#include <math.h>
#include <stdint.h>

template<typename V, typename D>
V adjustWrap(V v, D d, D min, D max, bool* changed = nullptr)
{
    D v2 = v;
    v2 += d;
    if(v2 > max)
        v2 = min;
    if(v2 < min)
        v2 = max;
    if(changed)
        *changed = v != v2;
    return (V)v2;
}

template<typename V, typename D>
V adjustClamp(V v, D d, D min, D max, bool* changed = nullptr)
{
    D v2 = v;
    v2 += d;
    if(v2 > max)
        v2 = max;
    if(v2 < min)
        v2 = min;
    if(changed)
        *changed = v != v2;
    return (V)v2;
}

inline void setBit(uint32_t bitset[], uint32_t bitIdx)
{
    bitset[bitIdx >> 6] |= 1 << (bitIdx & 0x1f);
}

inline void clearBit(uint32_t bitset[], uint32_t bitIdx)
{
    bitset[bitIdx >> 6] &= ~(1 << (bitIdx & 0x1f));
}

inline bool getBit(uint32_t bitset[], uint32_t bitIdx)
{
    return bitset[bitIdx >> 6] & (1 << (bitIdx & 0x1f));
}

// Lookup tables.
constexpr float POW2_19 = 524288.0f; //powf(2.0f, 19.0f);
constexpr float POW2_B_MINUS_1[8] = 
{
    0.5f,  //powf(2.0f, -1.0f),
    1.0f,  //powf(2.0f, 0.0f),
    2.0f,  //powf(2.0f, 1.0f),
    4.0f,  //powf(2.0f, 2.0f),
    8.0f,  //powf(2.0f, 3.0f),
    16.0f, //powf(2.0f, 4.0f),
    32.0f, //powf(2.0f, 5.0f),
    64.0f, //powf(2.0f, 6.0f),
};

template<typename T, size_t N>
constexpr size_t arraySize(T(&)[N])
{
    return N;
}
