#pragma once

#include "enum.h"
#include "params.h"

#include <Adafruit_GFX.h>    // Core graphics library
#include <Adafruit_ST7735.h> // Hardware-specific library for ST7735
#include <Adafruit_ST7789.h> // Hardware-specific library for ST7789

#include <cstdint>

enum class EnvelopeMode : uint8_t
{
	BARS,
	LINES,
};

enum class UpdateFlags : uint32_t
{
	NONE            = 0x0000,
	ALL             = 0xffff,

	// Params.
	FREQ            = 0x0001,
	FEEDBACK        = 0x0002,
	CONN            = 0x0004,
	MULT            = 0x0008,
	ENV             = 0x0010,
	ATTN            = 0x0020,
	WAVE            = 0x0040,
  
	// Ops.
	OP1             = 0x1000,
	OP2             = 0x2000,
	OP3             = 0x4000,
	OP4             = 0x8000,
};

static constexpr UpdateFlags OperatorFlags[4] = 
{
	UpdateFlags::OP1,
	UpdateFlags::OP2,
	UpdateFlags::OP3,
	UpdateFlags::OP4,
};

DEFINE_ENUM_CLASS_FLAG_OPERATOR(UpdateFlags, |);
DEFINE_ENUM_CLASS_FLAG_OPERATOR(UpdateFlags, &);

struct DisplayParams
{
	UpdateFlags updateFlags = UpdateFlags::ALL;
	UpdateFlags selectFlags = UpdateFlags::NONE;

	EnvelopeMode env = EnvelopeMode::BARS;

  char titleText[20] = {};
  int selectedVoice = 0;

	bool shouldUpdate(UpdateFlags flags, int idx = 0) const
	{
		return containsAnyFlags(updateFlags, (UpdateFlags)((uint32_t)flags << idx));
	}

  bool shouldSelect(UpdateFlags flags, int idx = 0) const
  {
    return containsAnyFlags(selectFlags, (UpdateFlags)((uint32_t)flags << idx));
  }
};

class Display
{
public:
  Display(SPIClass* spi);

  void init();
	void drawIcon(int x, int y, int idx, uint16_t col);
	void update(const struct DisplayParams& dispParams, const VoiceParams& voiceParams);

  Adafruit_ST7735& lcd() { return lcd_; }

private:
	static const int LCD_CS = PC13;
	static const int LCD_RST = PC14;
	static const int LCD_DC = PC15;

  SPIClass* spi_ = nullptr;
	Adafruit_ST7735 lcd_;
};
