#pragma once

#include <stdio.h>
#include <math.h>
#include <stdint.h>

struct OperatorParams
{
	int8_t attn = 0;
	int8_t wave = 0;
	int8_t mult = 0;
	int8_t a = 7;
	int8_t d = 7;
	int8_t s = 7;
	int8_t r = 7;
	uint8_t en_sus = 0;
	uint8_t en_tre = 0;
	uint8_t en_vib = 0;

	void randomize();
	void tweak();
	void log();
};

struct VoiceParams
{
	uint8_t on = false;
	uint8_t on_latch = false;
	int8_t conn = 0;
	int8_t feedback = 0;
  float freq = 440.0f;
	OperatorParams ops[4] = {};

	void randomize();
	void tweak();
	void log();
};

#define PARAMS_MAGIC_ID (0x1234fe03)

struct Params
{
  uint32_t magicId = 0;
	VoiceParams voices[6];

#if defined(WIN32)
	void saveFactorySettings(const char* filename);
#endif

};
