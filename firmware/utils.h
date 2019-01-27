#pragma once

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

// https://gist.github.com/XProger/433701300086245e0583
float powf_fast(float a, float b)
{
  union { float d; int32_t x; } u = { a };
  u.x = (int32_t)(b * (u.x - 1064866805) + 1064866805);
  return u.d;
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
