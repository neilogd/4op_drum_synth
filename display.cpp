#include "display.h"
#include "icons.h"

#define COLOR_DEFAULT   0b1000010000010000
#define COLOR_TITLE     0b1111111111111111
#define COLOR_SELECTED  0b0000011110000000

Display::Display(SPIClass* spi)
  : spi_(spi)
  , lcd_(spi, LCD_CS, LCD_DC, LCD_RST)
{
}

void Display::init()
{
	lcd_.initR(INITR_144GREENTAB);   // initialize a ST7735S chip, black tab
	lcd_.setRotation(1);
	lcd_.fillScreen(ST77XX_BLACK);
  
  pinMode(LCD_CS, OUTPUT);
  pinMode(LCD_RST, OUTPUT);
  pinMode(LCD_DC, OUTPUT);
}

void Display::drawIcon(int x, int y, int idx, uint16_t col)
{
	const uint8_t* data = &icons_data[32 * idx];
	lcd_.drawBitmap(x, y, data, 16, 16, col);
}

void Display::update(const struct DisplayParams& dispParams, const VoiceParams& voiceParams)
{
	static const int opOffX[] = { 4, 68, 4, 68 };
	static const int opOffY[] = { 24, 24, 78, 78 };
	static const char* ops[] = { "Op1 ", "Op2 ", "Op3 ", "Op4 " };
	static const char* mult[] = { " /2", " x1", " x2", " x3", " x4", " x5", " x6", " x7", " x8", " x9", "x10", "x10", "x12", "x12", "x12" };

  if(dispParams.updateFlags == UpdateFlags::ALL)
  {
    lcd_.fillScreen(ST77XX_BLACK);
  }

	lcd_.setTextColor(COLOR_DEFAULT);

  uint16_t col = COLOR_DEFAULT;

  lcd_.setTextColor(COLOR_TITLE);
  lcd_.setCursor(4, 0);
  lcd_.print(dispParams.titleText);

  col = dispParams.shouldSelect(UpdateFlags::CONN) ? COLOR_SELECTED : COLOR_DEFAULT;
  lcd_.setTextColor(col);

	if(dispParams.shouldUpdate(UpdateFlags::CONN))
	{
    col = dispParams.shouldSelect(UpdateFlags::CONN) ? COLOR_SELECTED : COLOR_DEFAULT;
    lcd_.setTextColor(col);

		drawIcon(24, 8, voiceParams.conn, col);
	}
 
	if(dispParams.shouldUpdate(UpdateFlags::FREQ))
	{
    col = dispParams.shouldSelect(UpdateFlags::FREQ) ? COLOR_SELECTED : COLOR_DEFAULT;
    lcd_.setTextColor(col);

		lcd_.setCursor(88, 12);
		lcd_.print((int)voiceParams.freq);
		lcd_.print("Hz");
	}

	if(dispParams.shouldUpdate(UpdateFlags::FEEDBACK))
	{
    col = dispParams.shouldSelect(UpdateFlags::FEEDBACK) ? COLOR_SELECTED : COLOR_DEFAULT;
    lcd_.setTextColor(col);

		drawIcon(50, 8, 14, col);
		lcd_.setCursor(66, 12);
		lcd_.print(voiceParams.feedback);
	}

  uint8_t numOps = voiceParams.conn < 2 ? 2 : 4;

	for (int i = 0; i < numOps; ++i)
	{
    uint16_t selectCol = COLOR_DEFAULT;

		if(dispParams.shouldSelect(UpdateFlags::OP1, i))
      selectCol = COLOR_SELECTED;

		const OperatorParams& op = voiceParams.ops[i];
		const int a = op.a * 2;
		const int d = op.d * 2;
		const int s = op.s * 2;
		const int r = op.r * 2;
		int x = opOffX[i];
		int y = opOffY[i];

		lcd_.setCursor(x, y);
   
		if(dispParams.shouldUpdate(UpdateFlags::ENV))
		{
      col = dispParams.shouldSelect(UpdateFlags::ENV) ? selectCol : COLOR_DEFAULT;
      lcd_.setTextColor(col);
    
			if(dispParams.env == EnvelopeMode::BARS)
			{
				lcd_.fillRect(x + 0, y + 32 - a, 7, a, col);
				lcd_.fillRect(x + 8, y + 32 - d, 7, d, col);
				lcd_.fillRect(x + 16, y + 32 - s, 7, s, col);
				lcd_.fillRect(x + 24, y + 32 - r, 7, r, col);
 			}
			else if(dispParams.env == EnvelopeMode::LINES)
			{
        float susLen = 16.0f;
				float adsrTotal = (a + d + susLen + r) / 32.0f;
				float aStart = 0.0f;
				float dStart = aStart + (a / adsrTotal);
				float sStart = dStart + (d / adsrTotal);
        float sEnd = sStart + (susLen / adsrTotal);
				float rStart = sEnd + (r / adsrTotal);
  
				lcd_.drawLine(x + aStart, y + 32, x + dStart, y, col);
				lcd_.drawLine(x + dStart, y,      x + sStart, y + s, col);
				lcd_.drawLine(x + sStart, y + s,  x + sEnd, y + s, col);
        lcd_.drawLine(x + sEnd,   y + s,  x + rStart, y + 32, col);
			}
		}
    
		if(dispParams.shouldUpdate(UpdateFlags::MULT))
		{
      col = dispParams.shouldSelect(UpdateFlags::MULT) ? selectCol : COLOR_DEFAULT;
      lcd_.setTextColor(col);

			lcd_.setCursor(x + 36, y);
			lcd_.print(mult[op.mult]);
		}

		if(dispParams.shouldUpdate(UpdateFlags::WAVE))
		{
      col = dispParams.shouldSelect(UpdateFlags::WAVE) ? selectCol : COLOR_DEFAULT;
      lcd_.setTextColor(col);

			drawIcon(x + 40, y + 8, op.wave + 6, col);
		}

	  y += 40;
    lcd_.setCursor(x, y);

    const float attn = op.attn * 0.75f;
    if(dispParams.shouldUpdate(UpdateFlags::ATTN))
    {
      col = dispParams.shouldSelect(UpdateFlags::ATTN) ? selectCol : COLOR_DEFAULT;
      lcd_.setTextColor(col);

      lcd_.print("-");
      lcd_.print(attn);
      lcd_.print("dB");
    }
  }

	lcd_.drawFastHLine(4, opOffY[2] - 4, 120, COLOR_DEFAULT);
	lcd_.drawFastVLine(opOffX[1] - 4, 24, 128 - 24, COLOR_DEFAULT);
}

void Display::clear()
{
  lcd_.fillScreen(ST77XX_BLACK);
  lcd_.setCursor(0, 0);
  lcd_.setTextColor(ST77XX_WHITE);
}

void Display::print(const char* msg)
{
  lcd_.print(msg);
}

void Display::error(const char* text, uint16_t color, int ms)
{
  lcd_.fillScreen(color);
  lcd_.setCursor(0, 0);
  lcd_.setTextColor(ST77XX_WHITE);
  lcd_.print(text);
  delay(ms);
  lcd_.fillScreen(ST77XX_BLACK);
}
