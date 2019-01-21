#pragma once

#include <cstdint>

/**
 * Utils
 */
#define DEFINE_ENUM_CLASS_FLAG_OPERATOR(_Type, _Operator)                                                              \
  inline _Type operator _Operator##=(_Type& A, _Type B)                                                              \
  {                                                                                                                  \
    A = (_Type)((uint32_t)A _Operator(uint32_t) B);                                                                          \
    return A;                                                                                                      \
  }                                                                                                                  \
  inline _Type operator _Operator(_Type A, _Type B) { return (_Type)((uint32_t)A _Operator(uint32_t) B); }

#define DEFINE_ENUM_CLASS_UNARY_FLAG_OPERATOR(_Type, _Operator)                                                        \
  inline _Type operator _Operator(_Type A) { return (_Type)(_Operator(uint32_t) A); }


template<typename ENUM>
inline bool containsAllFlags(ENUM value, ENUM Flags)
{
  static_assert(sizeof(ENUM) <= sizeof(uint32_t), "Enum size too large.");
  return ((uint32_t)value & (uint32_t)Flags) == (uint32_t)Flags;
}

inline bool containsAllFlags(uint32_t value, uint32_t Flags) { return ((uint32_t)value & (uint32_t)Flags) == (uint32_t)Flags; }

template<typename ENUM>
inline bool containsAnyFlags(ENUM value, ENUM Flags)
{
  static_assert(sizeof(ENUM) <= sizeof(uint32_t), "Enum size too large.");
  return ((uint32_t)value & (uint32_t)Flags) != 0;
}

inline bool containsAnyFlags(uint32_t value, uint32_t Flags) { return ((uint32_t)value & (uint32_t)Flags) != 0; }
