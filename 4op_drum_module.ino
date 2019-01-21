#include <EEPROM.h>
#include <SPI.h>
#include <stdio.h>
#include <algorithm>
#include <cmath>
#include <cstdint>

#include "stm32f1/include/series/stm32.h"
#include "stm32f1/include/series/gpio.h"
#include "stm32f1/include/series/rcc.h"

#include "display.h"
#include "opl3.h"

#include "midi_instruments.h"
#include "factory_settings.h"

#include "analog_inputs.h"
#include "encoders.h"

#include "MCP23S17.h"

#define DEBUG_LOGGING (0)

Params params;

/**
 * Globals
 */
SPIClass SPI_2(2);

Display display(&SPI_2);

void toggleLED()
{
  static bool led = false;
  led = !led;
  //digitalWrite(PC13, led ? HIGH : LOW);
}

void flashLED(int i)
{
  for (; i > 0; i--)
  {
    toggleLED();
    delay(100);
    toggleLED();
    delay(100);
  }
}

#define USE_FAST_GPIO

namespace OPL3
{
struct ICTransportNull
{
  ICTransportNull()
  {
  }

  void reset()
  {
  }

  void softReset()
  {
  }

  void writeReg(uint8_t arr, uint8_t addr, uint8_t data)
  {
  }
};

struct ICTransportGPIO
{
  const uint8_t OPL3_CLK        = PB0;

  const uint8_t OPL3_A0         = PB1;
  const uint8_t OPL3_A1         = PB10;

  const uint8_t OPL3_RST        = PA8;
  const uint8_t OPL3_WR         = PA8;
  const uint8_t OPL3_CS         = PA8;

  const uint8_t OPL3_D0         = PA0;
  const uint8_t OPL3_D1         = PA1;
  const uint8_t OPL3_D2         = PA2;
  const uint8_t OPL3_D3         = PA3;
  const uint8_t OPL3_D4         = PA4;
  const uint8_t OPL3_D5         = PA5;
  const uint8_t OPL3_D6         = PA6;
  const uint8_t OPL3_D7         = PA7;

  ICTransportGPIO()
  {
  }

  void reset()
  {
    pinMode(OPL3_A0, OUTPUT);
    pinMode(OPL3_A1, OUTPUT);
    pinMode(OPL3_D0, OUTPUT);
    pinMode(OPL3_D1, OUTPUT);
    pinMode(OPL3_D2, OUTPUT);
    pinMode(OPL3_D3, OUTPUT);
    pinMode(OPL3_D4, OUTPUT);
    pinMode(OPL3_D5, OUTPUT);
    pinMode(OPL3_D6, OUTPUT);
    pinMode(OPL3_D7, OUTPUT);
    pinMode(OPL3_WR, OUTPUT);
    pinMode(OPL3_CS, OUTPUT);
    pinMode(OPL3_RST, OUTPUT);
    pinMode(OPL3_CLK, PWM);

    // Setup clock.
    const float target_clk = 14.318f;// / 8.0f;
    const float period_cyc = (float)CYCLES_PER_MICROSECOND / target_clk;
    const uint32_t max_reload = ((1 << 16) - 1);
    const uint16_t prescaler = (period_cyc / max_reload + 1);
    const float overflow = ((period_cyc + ((float)prescaler * 0.5f)) / (float)prescaler);

    Timer3.setMode(3, TIMER_PWM);
    Timer3.setPrescaleFactor((uint16_t)prescaler);
    Timer3.setOverflow((uint16_t)overflow);
    Timer3.setCompare(3, (uint16_t)(overflow * 0.5f));
    Timer3.resume();

    digitalWrite(OPL3_WR, HIGH);
    digitalWrite(OPL3_CS, HIGH);

    softReset();
  }

  void softReset()
  {
    digitalWrite(OPL3_RST, 0);
    delayMicroseconds(20);
    digitalWrite(OPL3_RST, 1);

    // Waveform select enable + OPL3 enable.
    //writeReg(0, 0x1, 0x20)
    //writeReg(1, 0x5, 1);
  }

  void writeReg(uint8_t arr, uint8_t addr, uint8_t data)
  {
    digitalWrite(OPL3_A0, LOW);
    digitalWrite(OPL3_A1, arr ? HIGH : LOW);

#if defined(USE_FAST_GPIO)
    GPIOA->regs->ODR = addr;
#else
    digitalWrite(OPL3_D0, (addr & 0b00000001) ? HIGH : LOW);
    digitalWrite(OPL3_D1, (addr & 0b00000010) ? HIGH : LOW);
    digitalWrite(OPL3_D2, (addr & 0b00000100) ? HIGH : LOW);
    digitalWrite(OPL3_D3, (addr & 0b00001000) ? HIGH : LOW);
    digitalWrite(OPL3_D4, (addr & 0b00010000) ? HIGH : LOW);
    digitalWrite(OPL3_D5, (addr & 0b00100000) ? HIGH : LOW);
    digitalWrite(OPL3_D6, (addr & 0b01000000) ? HIGH : LOW);
    digitalWrite(OPL3_D7, (addr & 0b10000000) ? HIGH : LOW);
#endif

    digitalWrite(OPL3_CS, LOW);
    digitalWrite(OPL3_WR, LOW);
    delayMicroseconds(1);
    digitalWrite(OPL3_CS, HIGH);
    digitalWrite(OPL3_WR, HIGH);
    delayMicroseconds(7);

    digitalWrite(OPL3_A0, HIGH);
#if defined(USE_FAST_GPIO)
    GPIOA->regs->ODR = data;
#else
    digitalWrite(OPL3_D0, (data & 0b00000001) ? HIGH : LOW);
    digitalWrite(OPL3_D1, (data & 0b00000010) ? HIGH : LOW);
    digitalWrite(OPL3_D2, (data & 0b00000100) ? HIGH : LOW);
    digitalWrite(OPL3_D3, (data & 0b00001000) ? HIGH : LOW);
    digitalWrite(OPL3_D4, (data & 0b00010000) ? HIGH : LOW);
    digitalWrite(OPL3_D5, (data & 0b00100000) ? HIGH : LOW);
    digitalWrite(OPL3_D6, (data & 0b01000000) ? HIGH : LOW);
    digitalWrite(OPL3_D7, (data & 0b10000000) ? HIGH : LOW);
#endif

    digitalWrite(OPL3_CS, LOW);
    digitalWrite(OPL3_WR, LOW);
    delayMicroseconds(1);
    digitalWrite(OPL3_CS, HIGH);
    digitalWrite(OPL3_WR, HIGH);
    delayMicroseconds(7);
  }
};

struct ICTransportExpander
{
  const uint8_t OPL3_CLK        = PB0;

  const uint8_t OPL3_CS         = 8;
  const uint8_t OPL3_A1         = 9;
  const uint8_t OPL3_A0         = 10;
  const uint8_t OPL3_RST        = 11;

  MCP23S17 io;

  ICTransportExpander()
    : io(SPI_2, 0, PB12)
  {
  }

  void reset()
  {
    pinMode(OPL3_CLK, PWM);

    io.begin();
    for(int i = 0; i < 16; ++i)
    {
      io.pinMode(i, 0);
      io.pullupMode(i, 0);
      io.inputInvert(i, 0);
    }

    // Setup clock.
    setClock(14.318f);

    io.digitalWrite(OPL3_CS, HIGH);

    softReset();
  }

  void setClock(float target_clk)
  {
    const float period_cyc = (float)CYCLES_PER_MICROSECOND / target_clk;
    const uint32_t max_reload = ((1 << 16) - 1);
    const uint16_t prescaler = (period_cyc / max_reload + 1);
    const float overflow = ((period_cyc + ((float)prescaler * 0.5f)) / (float)prescaler);

    Timer3.pause();
    Timer3.setMode(3, TIMER_PWM);
    Timer3.setPrescaleFactor((uint16_t)prescaler);
    Timer3.setOverflow((uint16_t)overflow);
    Timer3.setCompare(3, (uint16_t)(overflow * 0.5f));
    Timer3.resume();
  }

  void softReset()
  {
    io.begin();
    io.digitalWrite(OPL3_RST, 0);
    delayMicroseconds(20);
    io.digitalWrite(OPL3_RST, 1);
  }

  unsigned flipBits(unsigned v)
  {
    v = ((v & 0b11110000) >> 4) | ((v & 0b00001111) << 4);
    v = ((v & 0b11001100) >> 2) | ((v & 0b00110011) << 2);
    v = ((v & 0b10101010) >> 1) | ((v & 0b01010101) << 1);
    return v;
  }
  
  void writeReg(uint8_t arr, uint8_t addr, uint8_t data)
  {
    io.begin();

    unsigned aw = (1 << OPL3_RST) | (1 << OPL3_CS);
    aw |= !!arr << OPL3_A1;
    io.digitalWrite(aw);
    aw |= flipBits(addr);
    io.digitalWrite(aw);

    io.digitalWrite(OPL3_CS, LOW);
    delayMicroseconds(1);
    io.digitalWrite(OPL3_CS, HIGH);
    delayMicroseconds(7);

    unsigned dw = (1 << OPL3_RST) | (1 << OPL3_CS) | (1 << OPL3_A0);
    io.digitalWrite(dw);
    dw |= flipBits(data);
    io.digitalWrite(dw);

    io.digitalWrite(OPL3_CS, LOW);
    delayMicroseconds(1);
    io.digitalWrite(OPL3_CS, HIGH);
    delayMicroseconds(7);

    for(int i = 0; i < 16; ++i)
    {
      io.pinMode(i, 1);
      io.digitalRead(i);
      io.pinMode(i, 0);
    }
  }
};
}

OPL3::Interface<OPL3::ICTransportExpander> opl3;
AnalogInputs analogInputs;
Encoders encoders;

bool voice_update(VoiceParams& params, int idx, bool keyon, int vel, float freq)
{
  static const int VOICE_CH[6] = { 0, 1, 2, 9, 10, 11 };
  const int ch = VOICE_CH[idx];
  const int numOps = params.conn < 2 ? 2 : 4;

  int op[4] = { OPL3::MODE_4OP[0][ch], OPL3::MODE_4OP[1][ch], OPL3::MODE_4OP[2][ch], OPL3::MODE_4OP[3][ch] };

  if (numOps == 2)
  {
    op[0] = OPL3::MODE_2OP[0][ch];
    op[1] = OPL3::MODE_2OP[1][ch];
    op[2] = -1;
    op[3] = -1;
  }

  int arr[4] = { -1, -1, -1, -1};
  int off[4] = { -1, -1, -1, -1};
  for (int i = 0; i < numOps; ++i)
  {
    arr[i] = OPL3::OP_OFF[op[i]][0];
    off[i] = OPL3::OP_OFF[op[i]][1];
  }

  if (keyon)
  {
    int mode4op = numOps == 4 ? 1 : 0;
    switch (ch)
    {
      case 0: opl3.setRegister(1, OPL3::Register::EN_4OP_03, 0, mode4op); break;
      case 1: opl3.setRegister(1, OPL3::Register::EN_4OP_14, 0, mode4op); break;
      case 2: opl3.setRegister(1, OPL3::Register::EN_4OP_25, 0, mode4op); break;
      case 9: opl3.setRegister(1, OPL3::Register::EN_4OP_9C, 0, mode4op); break;
      case 10: opl3.setRegister(1, OPL3::Register::EN_4OP_AD, 0, mode4op); break;
      case 11: opl3.setRegister(1, OPL3::Register::EN_4OP_BE, 0, mode4op); break;
      default: break;
    }

    // Per voice config.
    int attn[4] = { 0, 0, 0, 0 };
    {
      float f = freq < 0.0f ? params.freq : freq;
      int b = 0;
      if (f < 48.503f)
        b = 0;
      else if (f < 97.006f)
        b = 1;
      else if (f < 194.013f)
        b = 2;
      else if (f < 388.026f)
        b = 3;
      else if (f < 776.053f)
        b = 4;
      else if (f < 1552.107f)
        b = 5;
      else if (f < 3104.215f)
        b = 6;
      else if (f < 6208.431f)
        b = 7;

      uint16_t fnum = (uint16_t)(f * pow(2.0f, 19.0f) / (14318180.0 / 288.0) / pow(2.0f, b - 1));

      opl3.setRegister(arr[0], OPL3::Register::BLOCK_NUM, off[0], b);
      opl3.setRegister(arr[0], OPL3::Register::FREQ_MSB, off[0], fnum >> 8);
      opl3.setRegister(arr[0], OPL3::Register::FREQ_LSB, off[0], fnum & 0xff);
      opl3.setRegister(arr[0], OPL3::Register::FEEDBACK, off[0], params.feedback);

      if (vel == -1)
        vel = 127;
      uint32_t voiceAttn = (127 - vel) >> 2;
      switch (params.conn)
      {
        case 0:
          opl3.setRegister(arr[0], OPL3::Register::CONN, off[0], 0);
          attn[1] = voiceAttn;
          break;
        case 1:
          opl3.setRegister(arr[0], OPL3::Register::CONN, off[0], 1);
          attn[0] = voiceAttn;
          attn[1] = voiceAttn;
          break;
        case 2:
          opl3.setRegister(arr[0], OPL3::Register::CONN, off[0], 0);
          opl3.setRegister(arr[1], OPL3::Register::CONN, off[1], 0);
          attn[3] = voiceAttn;
          break;
        case 3:
          opl3.setRegister(arr[0], OPL3::Register::CONN, off[0], 0);
          opl3.setRegister(arr[1], OPL3::Register::CONN, off[1], 1);

          attn[0] = voiceAttn;
          attn[3] = voiceAttn;
          break;
        case 4:
          opl3.setRegister(arr[0], OPL3::Register::CONN, off[0], 1);
          opl3.setRegister(arr[1], OPL3::Register::CONN, off[1], 0);

          attn[1] = voiceAttn;
          attn[3] = voiceAttn;

          break;
        case 5:
          opl3.setRegister(arr[0], OPL3::Register::CONN, off[0], 1);
          opl3.setRegister(arr[1], OPL3::Register::CONN, off[1], 1);

          attn[0] = voiceAttn;
          attn[2] = voiceAttn;
          attn[3] = voiceAttn;
          break;
      }
    }

    for (int i = 0; i < numOps; ++i)
    {
      // 0x20
      opl3.setRegister(arr[i], OPL3::Register::EN_SUS, off[i], params.ops[i].en_sus);
#if ENABLE_VIBRATO
      opl3.setRegister(arr[i], OPL3::Register::EN_TRE, off[i], params.ops[i].en_tre);
#else
      opl3.setRegister(arr[i], OPL3::Register::EN_TRE, off[i], 0);
#endif
#if ENABLE_VIBRATO
      opl3.setRegister(arr[i], OPL3::Register::EN_VIB, off[i], params.ops[i].en_vib);
#else
      opl3.setRegister(arr[i], OPL3::Register::EN_VIB, off[i], 0);
#endif
      opl3.setRegister(arr[i], OPL3::Register::KSR, off[i], 0);
      opl3.setRegister(arr[i], OPL3::Register::MULT, off[i], params.ops[i].mult);

      // 0x40
      opl3.setRegister(arr[i], OPL3::Register::KSL, off[i], 0);
      opl3.setRegister(arr[i], OPL3::Register::ATTN, off[i], std::min((long int)63, (long int)params.ops[i].attn + attn[i]));

      // 0x60
      opl3.setRegister(arr[i], OPL3::Register::ATTACK, off[i], params.ops[i].a);
      opl3.setRegister(arr[i], OPL3::Register::DECAY, off[i], params.ops[i].d);

      // 0x80
      opl3.setRegister(arr[i], OPL3::Register::SUSTAIN, off[i], params.ops[i].s);
      opl3.setRegister(arr[i], OPL3::Register::RELEASE, off[i], params.ops[i].r);

      // 0xC0
      opl3.setRegister(arr[i], OPL3::Register::CHAN_A, off[i], 1);
      opl3.setRegister(arr[i], OPL3::Register::CHAN_B, off[i], 1);
      opl3.setRegister(arr[i], OPL3::Register::CHAN_C, off[i], 1);
      opl3.setRegister(arr[i], OPL3::Register::CHAN_D, off[i], 1);

      // 0xE0
      opl3.setRegister(arr[i], OPL3::Register::WAVE_SEL, off[i], params.ops[i].wave);
    }
  }

  if (keyon)
  {
    opl3.setRegister(arr[0], OPL3::Register::KEY_ON, off[0], 1);
  }
  else
  {
    opl3.setRegister(arr[0], OPL3::Register::KEY_ON, off[0], 0);
  }

  opl3.flush();

  return keyon;
}

void beginScan()
{
    Timer2.pause();
    Timer2.setPeriod(200);
    Timer2.setMode(1, TIMER_OUTPUT_COMPARE);
    Timer2.setMode(2, TIMER_DISABLED);
    Timer2.setMode(3, TIMER_DISABLED);
    Timer2.setMode(4, TIMER_DISABLED);
    Timer2.setCompare(TIMER_CH1, 1); 
    Timer2.attachCompare1Interrupt([](){ 
      encoders.scan();
    });
    Timer2.refresh();
    Timer2.resume();
}

bool readSettings()
{
  int addr = 0;
  int count = sizeof(params) / 2;
  uint16_t* data = reinterpret_cast<uint16_t*>(&params);
  EEPROM.read(addr++, data++);
  EEPROM.read(addr++, data++);

  if(params.magicId == PARAMS_MAGIC_ID)
  {
    for(int i = 2; i < count; ++i)
      EEPROM.read(addr++, data++);

    return true;
  }
  else
  {
    EEPROM.format();
  }
  return false;
}

void writeSettings()
{
  int addr = 0;
  int count = sizeof(params) / 2;
  params.magicId = PARAMS_MAGIC_ID;
  uint16_t* data = reinterpret_cast<uint16_t*>(&params);
  EEPROM.update(addr++, *data++);
  EEPROM.update(addr++, *data++);
  for(int i = 2; i < count; ++i)
  {
    uint16_t ret = EEPROM.update(addr++, *data++);
    if(!(ret == EEPROM_OK || ret == EEPROM_SAME_VALUE))
    {
      display.lcd().fillScreen(ST77XX_RED);
      display.lcd().setCursor(0, 0);
      display.lcd().setTextColor(ST77XX_WHITE);
      display.lcd().print("EEPROM ERROR WRITING ");
      display.lcd().print(addr);
      display.lcd().print("\n(");
      display.lcd().print(count - addr);
      display.lcd().print(" REMAINING)");
      display.lcd().print("\nCODE: ");
      display.lcd().print(ret);
      delay(2000);
      display.lcd().fillScreen(ST77XX_BLACK);
      return;
    }
  }
  
}

void setup()
{
  // Free up PA15, PB3, and PB4 pins.
  RCC_BASE->APB2ENR |= RCC_APB2ENR_AFIOEN | RCC_APB2ENR_IOPAEN;
  AFIO_BASE->MAPR |= AFIO_MAPR_SWJ_CFG_NO_JTAG_SW;

  // Clear display asap.
  display.init();

  // Setup input handling.  
  encoders.setRowPin(0, PB6);
  encoders.setRowPin(1, PB7);
  encoders.setRowPin(2, PB8);
  encoders.setRowPin(3, PB9);
  encoders.setColPin(0, PA8);
  encoders.setColPin(1, PA15);
  encoders.setColPin(2, PB3);
  encoders.setColPin(3, PB4);
  encoders.setColPin(4, PB5);

  analogInputs.setInput(0, PA5);
  analogInputs.setInput(1, PA4);
  analogInputs.setInput(2, PA3);
  analogInputs.setInput(3, PA2);
  analogInputs.setInput(4, PA1);
  analogInputs.setInput(5, PA0);

  beginScan();

  // Setup OPL3.
  opl3.getTransport().reset();

  opl3.setRegister(0, OPL3::Register::WS_ENABLE, 0, 1);
  opl3.setRegister(0, OPL3::Register::TEST_REG, 0, 0);
  opl3.setRegister(1, OPL3::Register::OPL3, 0, 1);
  opl3.flush();

  // Load settings.
  //0x801F000, 0x801F800, 0x400
  //0x8000000
  EEPROM.init();
  if(readSettings())
    display.lcd().fillScreen(ST77XX_GREEN);
  else
    display.lcd().fillScreen(ST77XX_RED);

  uint16_t counts = 0;
  //EEPROM.count(&count);
  uint16_t maxCount = EEPROM.maxcount();
      display.lcd().setCursor(0, 0);
      display.lcd().setTextColor(ST77XX_WHITE);
      display.lcd().print("EEPROM COUNT ");
      display.lcd().print(counts);
      display.lcd().print("EEPROM MAX ");
      display.lcd().print(maxCount);
  delay(1000);
  display.lcd().fillScreen(ST77XX_BLACK);
}


struct UIState
{
  uint8_t selectedVoice = 0;
  uint8_t selectedOp = 0;

  enum UIMode
  {
    EDIT_VOICE_PARAMS,
    EDIT_OP_ADSR,
    EDIT_OP_ATTN_WAVE_MULT,

    MAX_MODES
  };

  uint8_t mode = EDIT_VOICE_PARAMS;
};

template<typename V, typename D>
void adjustWrap(V& v, D d, D min, D max)
{
  D v2 = v;
  v2 += d;
  if(v2 > max)
    v2 = min;
  if(v2 < min)
    v2 = max;
  v = v2;
}

template<typename V, typename D>
void adjustClamp(V& v, D d, D min, D max)
{
  D v2 = v;
  v2 += d;
  if(v2 > max)
    v2 = max;
  if(v2 < min)
    v2 = min;
  v = v2;
}


void loop()
{
  static constexpr int DISPLAY_UPDATE_RATE = 100000;
  static constexpr int GATE_UPDATE_RATE = 1;
  static constexpr int OPL3_UPDATE_RATE = 1;
  static constexpr int GATE_TRIGGER_VALUE = 3000;

  static constexpr int SAVE_TIMER = 100000;
  
  static int displayUpdateTimer = 0;
  static int gateUpdateTimer = 0;
  static int opl3UpdateTimer = 0;
  static int saveTimer = SAVE_TIMER;

  static UIState uiState;
  
  {
    // Handle inputs.
    static constexpr int ENCODER_MODE_SELECT = 0;
    static constexpr int ENCODER_A = 1;
    static constexpr int ENCODER_B = 2;
    static constexpr int ENCODER_C = 3;
    static constexpr int ENCODER_D = 4;
    const int encVals[5] = {
      encoders.getValue(0),
      encoders.getValue(1),
      encoders.getValue(2),
      encoders.getValue(3),
      encoders.getValue(4),
    };

    for(int i = 0; i < 5; ++i)
      if(encVals[i] != 0)
        displayUpdateTimer = 0;

    static constexpr int BUTTON_MODE_SELECT = 0;
    const int btnVals[1] = 
    {
      encoders.getValue(5) != 0,
    };

    static int prevBtnVals[1] = { 0 };

    for(int i = 0; i < 1; ++i)
      if(btnVals[i] != 0)
        displayUpdateTimer = 0;


    if(displayUpdateTimer == 0 || saveTimer < SAVE_TIMER)
    {
      // Delay saving 
      if(displayUpdateTimer == 0)
      {
        saveTimer = SAVE_TIMER;
      }
      
      saveTimer--;

      if(saveTimer == 0)
      {
        writeSettings();
        displayUpdateTimer = 0;
      }
    }

    // Toggle edit modes.
    if(btnVals[BUTTON_MODE_SELECT] && !prevBtnVals[BUTTON_MODE_SELECT])
    {
      uiState.mode++;
      if(uiState.mode >= UIState::MAX_MODES)
        uiState.mode = 0;
    }

    VoiceParams& voice = params.voices[uiState.selectedVoice];
    OperatorParams& op = voice.ops[uiState.selectedOp];

    static DisplayParams dispParams;

    switch(uiState.mode)
    {
    case UIState::EDIT_VOICE_PARAMS:
      {
        adjustWrap(uiState.selectedVoice, encVals[ENCODER_MODE_SELECT], 0, 5);
        adjustWrap(voice.conn, encVals[ENCODER_A], 0, 5);
        adjustClamp(voice.feedback, encVals[ENCODER_B], 0, 7);

        float freqMod = encVals[ENCODER_C];
        if(encVals[ENCODER_D] > 0)
          freqMod += (voice.freq * (1.0f + (encVals[ENCODER_D] * (1.0f / 24.0f)))) - voice.freq;
        else if(encVals[ENCODER_D] < 0)
          freqMod += (voice.freq / (1.0f + (-encVals[ENCODER_D] * (1.0f / 24.0f)))) - voice.freq;
        adjustClamp(voice.freq, freqMod, 30.0f, 4000.0f);

        dispParams.selectFlags = UpdateFlags::FREQ | UpdateFlags::FEEDBACK | UpdateFlags::CONN;

        sprintf(dispParams.titleText, "V%u:   Voice Params", uiState.selectedVoice + 1, uiState.selectedOp + 1);
      }
      break;
    case UIState::EDIT_OP_ADSR:
      {
        adjustWrap(uiState.selectedOp, encVals[ENCODER_MODE_SELECT], 0, voice.conn < 2 ? 1 : 3);
        adjustClamp(op.a, encVals[ENCODER_A], 0, 15);
        adjustClamp(op.d, encVals[ENCODER_B], 0, 15);
        adjustClamp(op.s, encVals[ENCODER_C], 0, 15);
        adjustClamp(op.r, encVals[ENCODER_D], 0, 15);

        dispParams.selectFlags = UpdateFlags::ENV | OperatorFlags[uiState.selectedOp];

        sprintf(dispParams.titleText, "V%u O%u:ADSR Env.", uiState.selectedVoice + 1, uiState.selectedOp + 1);
      }
      break;
    case UIState::EDIT_OP_ATTN_WAVE_MULT:
      {
        adjustWrap(uiState.selectedOp, encVals[ENCODER_MODE_SELECT], 0, voice.conn < 2 ? 1 : 3);
        adjustClamp(op.attn, -encVals[ENCODER_A], 0, 63);
        adjustClamp(op.wave, encVals[ENCODER_B], 0, 7);
        adjustClamp(op.mult, encVals[ENCODER_C], 0, 11);

        dispParams.selectFlags = UpdateFlags::ATTN | UpdateFlags::WAVE | UpdateFlags::MULT | OperatorFlags[uiState.selectedOp];

        sprintf(dispParams.titleText, "V%u O%u:Attn,Wave,Mult", uiState.selectedVoice + 1, uiState.selectedOp + 1);
      }
      break;
    }



    // Button thing.
    prevBtnVals[0] = btnVals[1];
    
    if(displayUpdateTimer <= 0)
    {
      displayUpdateTimer += DISPLAY_UPDATE_RATE;
      dispParams.selectedVoice = uiState.selectedVoice;
      dispParams.updateFlags = UpdateFlags::ALL;
      dispParams.env = EnvelopeMode::BARS;
      display.update(dispParams, params.voices[uiState.selectedVoice]);
    }

    static int prevGates[6] = { false, false, false, false, false, false };
    static int nextGates[6] = { false, false, false, false, false, false };
  
    if(gateUpdateTimer <= 0)
    {
      for(int i = 0; i < 6; ++i)
        prevGates[i] = nextGates[i];

      gateUpdateTimer += GATE_UPDATE_RATE;
      analogInputs.scan();
  
      for(int i = 0; i < 6; ++i)
      {
        if(analogInputs.getInput(i) > GATE_TRIGGER_VALUE)
        {
          nextGates[i] = true;
        }
        else
        {
          nextGates[i] = false;
        }
      }    
    }
  
    if(opl3UpdateTimer <= 0)
    {
      opl3UpdateTimer += OPL3_UPDATE_RATE;
      for(int i = 0; i < 6; ++i)
      {
        bool keyOn = !prevGates[i] && nextGates[i];
        bool keyOff = prevGates[i] && !nextGates[i];
  
        if(keyOn)
        {
          voice_update(params.voices[i], i, true, -1, -1.0f);
        }
        if(keyOff)
        {
          voice_update(params.voices[i], i, false, -1, -1.0f);
        }
      }
    }
  
    //displayUpdateTimer--;
    gateUpdateTimer--;
    opl3UpdateTimer--;
  }
}
