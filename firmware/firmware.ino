#include <EEPROM.h>
#include <SPI.h>
#include <USBComposite.h>
#include <stdio.h>
#include <algorithm>
#include <cmath>
#include <cstdint>

#include "display.h"
#include "opl3.h"
#include "opl3_transport.h"

#include "analog_inputs.h"
#include "encoders.h"

#include "USBMIDIEx.h"
#include "utils.h"
#include "config.h"

#define DEBUG_LOGGING (0)

/**
 * Globals
 */
static Params params;
static SPIClass SPI_2(2);
static Display display(&SPI_2);
static OPL3::ICTransportExpander transport(&SPI_2);
static OPL3::Interface<OPL3::ICTransportExpander> opl3(transport);
static AnalogInputs analogInputs;
static Encoders encoders;
static int activeSensingUpdateRate = 0;
static int displayUpdateTimer = 0;

/**
 * Forward declarations;
 */
bool voice_update(VoiceParams& params, int idx, bool keyon, int vel, float freq);
void beginScan();
bool readSettings();
void writeSettings();

/**
 * MIDI handler (TODO: Move out of here)
 */
class USBMIDIHandler: public USBMIDIEx
{
public:
  enum SysExType
  {
    // If received, EEPROM data should be sent back. 
    EEPROM_REQUEST = 0x01,
    // If received, store to EEPROM 
    EEPROM_DATA = 0x02,
  };

  const byte idBytes[3] =
  {
    0x00000000, 0x00000000, 0x00000001
  };

  byte sysexBuffer[1024];

  USBMIDIHandler()
  {
    setSystemExclusiveBuffer(sysexBuffer, sizeof(sysexBuffer));
  }

  int activity = 0;
  bool hadActivity()
  {
    if(activity > 1000)
      activity = 1000;
    if(activity > 0)
    {
      --activity;
      return true;
    }
    return false;
  }

  
  void handleNoteOff(unsigned int channel, unsigned int note, unsigned int velocity) override
  {
    activity += 100;
  }
  
  void handleNoteOn(unsigned int channel, unsigned int note, unsigned int velocity) override
  {
    activity += 100;
  }

  void handleControlChange(unsigned int channel, unsigned int controller, unsigned int value) override
  {
    activity += 100;
  }

  void sendSystemExclusive(SysExType type, const void* data, unsigned int size)
  {
      activity += 100 + size * 2;
    
      sysexBuffer[0] = idBytes[0];
      sysexBuffer[1] = idBytes[1];
      sysexBuffer[2] = idBytes[2];
      sysexBuffer[3] = type;

      unsigned int length = 4;
      if(data != nullptr)
      {
        // TODO: CHECK SIZE FIRST
        length += SysEx::encode((const byte*)data, (byte*)&sysexBuffer[4], size);
      }

      USBMIDIEx::sendSystemExclusive(&sysexBuffer[0], length);        
  }

  void handleSystemExclusive(const byte * array, unsigned int size) override
  {
    char buf[128];
    activity += 100 + size * 2;

    if(array[0] == idBytes[0] && array[1] == idBytes[1] && array[2] == idBytes[2])
    {
      // Handle sysex.
      switch(array[3])
      {
      case EEPROM_REQUEST:
        sendSystemExclusive(EEPROM_DATA, &params, sizeof(params));
        return;

      case EEPROM_DATA:
        SysEx::decode(&array[4], (byte*)&params, size - 4);

        displayUpdateTimer = 0;
        return;

      default:
        break;
      }
    }
  }
    
};

USBMIDIHandler midi;

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
  if(!readSettings())
  {
    char errorMsg[64];
    sprintf(errorMsg, " EEPROM CORRUPT. Reset to default.");
    display.error(errorMsg, ST77XX_RED, 2000); 
  }

  // Setup USB MIDI.
  USBComposite.setProductId(0x0031);
  midi.begin();
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

void loop()
{
  static int gateUpdateTimer = 0;
  static int opl3UpdateTimer = 0;
  static int saveTimer = SAVE_TIMER;

  static UIState uiState;
  
  {
    // MIDI.
    midi.poll();
    
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

    const int btnVals[1] = 
    {
      encoders.getValue(5) != 0,
    };

    static int prevBtnVals[1] = { 0 };

    for(int i = 0; i < 1; ++i)
      if(btnVals[i] != 0)
        displayUpdateTimer = 0;

    if(activeSensingUpdateRate == 0)
    {
      midi.sendActiveSense();
      activeSensingUpdateRate = ACTIVE_SENSING_UPDATE_RATE;
    }

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
        uiState.selectedVoice = adjustWrap(uiState.selectedVoice, encVals[ENCODER_MODE_SELECT], 0, 5);
        voice.conn = adjustWrap(voice.conn, encVals[ENCODER_VOICE_OP], 0, 5);
        voice.feedback = adjustClamp(voice.feedback, encVals[ENCODER_VOICE_FEEDBACK], 0, 7);

        float freqMod = encVals[ENCODER_VOICE_PITCH_FINE];
        if(encVals[ENCODER_VOICE_PITCH_COARSE] > 0)
          freqMod += (voice.freq * (1.0f + (encVals[ENCODER_D] * (1.0f / 24.0f)))) - voice.freq;
        else if(encVals[ENCODER_D] < 0)
          freqMod += (voice.freq / (1.0f + (-encVals[ENCODER_D] * (1.0f / 24.0f)))) - voice.freq;
        voice.freq = adjustClamp(voice.freq, freqMod, 30.0f, 4000.0f);

        dispParams.selectFlags = UpdateFlags::FREQ | UpdateFlags::FEEDBACK | UpdateFlags::CONN;

        sprintf(dispParams.titleText, "V%u:   Voice Params", uiState.selectedVoice + 1, uiState.selectedOp + 1);
      }
      break;
    case UIState::EDIT_OP_ADSR:
      {
        adjustWrap(uiState.selectedOp, encVals[ENCODER_MODE_SELECT], 0, voice.conn < 2 ? 1 : 3);
        op.a = adjustClamp(op.a, encVals[ENCODER_ENV_A], 0, 15);
        op.d = adjustClamp(op.d, encVals[ENCODER_ENV_D], 0, 15);
        op.s = adjustClamp(op.s, encVals[ENCODER_ENV_S], 0, 15);
        op.r = adjustClamp(op.r, encVals[ENCODER_ENV_R], 0, 15);

        dispParams.selectFlags = UpdateFlags::ENV | OperatorFlags[uiState.selectedOp];

        sprintf(dispParams.titleText, "V%u O%u:ADSR Env.", uiState.selectedVoice + 1, uiState.selectedOp + 1);
      }
      break;
    case UIState::EDIT_OP_ATTN_WAVE_MULT:
      {
        uiState.selectedOp = adjustWrap(uiState.selectedOp, encVals[ENCODER_MODE_SELECT], 0, voice.conn < 2 ? 1 : 3);
        op.attn = adjustClamp(op.attn, -encVals[ENCODER_OP_ATTN], 0, 63);
        op.wave = adjustWrap(op.wave, encVals[ENCODER_OP_WAVE], 0, 7);
        op.mult = adjustClamp(op.mult, encVals[ENCODER_OP_MULT], 0, 11);

        dispParams.selectFlags = UpdateFlags::ATTN | UpdateFlags::WAVE | UpdateFlags::MULT | OperatorFlags[uiState.selectedOp];

        sprintf(dispParams.titleText, "V%u O%u:Misc.", uiState.selectedVoice + 1, uiState.selectedOp + 1);
      }
      break;
    }

    static bool isMIDIConnected = false;
    if(isMIDIConnected != midi.isConnected())
    {
      isMIDIConnected = midi.isConnected();
    }

    if(isMIDIConnected)
    {
      if(midi.hadActivity())
      {
        display.drawIcon(2, 10, 15, COLOR_MIDI_ACTIVITY);
      }
      else
      {
        display.drawIcon(2, 10, 15, COLOR_MIDI_IDLE);
      }
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
  
    activeSensingUpdateRate--;
    //displayUpdateTimer--;
    gateUpdateTimer--;
    opl3UpdateTimer--;
  }
}

/**
 * Functions.
 */
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

  if(params.magicId == Params::MAGIC_ID)
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
  params.magicId = Params::MAGIC_ID;
  params.versionId = Params::VERSION;
  uint16_t* data = reinterpret_cast<uint16_t*>(&params);
  EEPROM.update(addr++, *data++);
  EEPROM.update(addr++, *data++);
  for(int i = 2; i < count; ++i)
  {
    uint16_t ret = EEPROM.update(addr++, *data++);
    if(!(ret == EEPROM_OK || ret == EEPROM_SAME_VALUE))
    {
      char errorMsg[64];
      sprintf(errorMsg, " EEPROM ERROR WRITING %i\n (%i REMAINING)\n CODE: %x", addr, count - addr, ret);
      display.error(errorMsg, ST77XX_RED, 2000); 
      return;
    }
  }
}
