#pragma once

#include <stdio.h>
#include <math.h>
#include <stdint.h>

struct OperatorParams_V1_0
{
  OperatorParams_V1_0()
    : a(7)
    , d(7)
    , s(7)
    , r(7)
    , attn(0)
    , mult(0)
    , wave(0)
    , en_sus(0)
    , en_tre(0)
    , en_vib(0)
  {}
  
  uint32_t a : 4;
  uint32_t d : 4;
  uint32_t s : 4;
  uint32_t r : 4;
  uint32_t attn : 6;
  uint32_t mult : 4;
  uint32_t wave : 3;
  uint32_t en_sus : 1;
  uint32_t en_tre : 1;
  uint32_t en_vib : 1;
};

struct VoiceParams_V1_0
{
  VoiceParams_V1_0()
    : conn(0)
    , feedback(0)
    , ops({})
  {}
  
  OperatorParams_V1_0 ops[4] = {};
  float freq = 440.0f;
	int8_t conn : 4;
	int8_t feedback : 4;
};

template<uint32_t _VERSION>
struct ParamsBase
{
  static const uint32_t MAGIC_ID = 0x1234fe04;
  static const uint32_t VERSION = _VERSION;

  uint32_t magicId = 0;
  uint32_t version = 0;
};

struct Params_V1_0 : ParamsBase<0x00010000>
{
	VoiceParams_V1_0 voices[6];
};

// Setup which version to use.
typedef OperatorParams_V1_0 OperatorParams;
typedef VoiceParams_V1_0 VoiceParams;
typedef Params_V1_0 Params;

// Verify sizes.
static_assert(sizeof(OperatorParams) == 4, "OperatorParams must be 4b!");
static_assert(sizeof(VoiceParams) == 24, "VoiceParams must be 24b!");
static_assert(sizeof(Params) <= 256, "Params must be <= 256!");
