/******************************************************************************
 *  This started out as a munging of Tymm Twillman's arduino Midi Library into the Libusb class,
 *  though by now very little of the original code is left, except for the class API and
 *  comments. Tymm Twillman kindly gave Alexander Pruss permission to relicense his code under the MIT
 *  license, which fixed a nasty licensing mess.
 *
 * The MIT License
 *
 * Copyright (c) 2010 Perry Hung.
 * Copyright (c) 2013 Magnus Lundin.
 * Copyright (c) 2013 Donald Delmar Davis, Suspect Devices.
 * (c) 2003-2008 Tymm Twillman <tymm@booyaka.com>
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 *
 *****************************************************************************/

/**
 * @brief USB MIDI device with a class compatible with maplemidi
 */

#include "USBMIDIEx.h" 

#include <string.h>
#include <stdint.h>
#include <libmaple/nvic.h>
#include <wirish.h>
#include "usb_midi_device.h"
#include <libmaple/usb.h>
#include "usb_generic.h"


/*
 * USBMIDIEx interface
 */

#define USB_TIMEOUT 50

void USBMIDIEx::setChannel(unsigned int channel) {
  channelIn_ = channel;

}

bool USBMIDIEx::init(USBMIDIEx* me) {
    usb_midi_setTXEPSize(me->txPacketSize);
    usb_midi_setRXEPSize(me->rxPacketSize);
  return true;
}

bool USBMIDIEx::registerComponent() {
    return USBComposite.add(&usbMIDIPart, this, (USBPartInitializer)&USBMIDIEx::init); 
}

void USBMIDIEx::begin(unsigned channel) {
  setChannel(channel);
  
  if (enabled)
    return;

  USBComposite.clear();
  registerComponent();
  USBComposite.begin();
  
  enabled = true; 
}

void USBMIDIEx::end(void) {
  if (enabled) {
    USBComposite.end();
    enabled = false;
  }
}

void USBMIDIEx::writePacket(uint32 p) {
    this->writePackets(&p, 1);
}

void USBMIDIEx::writePackets(const void *buf, uint32 len) {
    if (!this->isConnected() || !buf) {
        return;
    }

    uint32 txed = 0;
    uint32 old_txed = 0;
    uint32 start = millis();

    uint32 sent = 0;

    while (txed < len && (millis() - start < USB_TIMEOUT)) {
        sent = usb_midi_tx((const uint32*)buf + txed, len - txed);
        txed += sent;
        if (old_txed != txed) {
            start = millis();
        }
        old_txed = txed;
    }


    if (sent == usb_midi_txEPSize) {
        while (usb_midi_is_transmitting() != 0) {
        }
        /* flush out to avoid having the pc wait for more data */
        usb_midi_tx(NULL, 0);
    }
}

uint32 USBMIDIEx::available(void) {
    return usb_midi_data_available();
}

uint32 USBMIDIEx::readPackets(void *buf, uint32 len) {
    if (!buf) {
        return 0;
    }

    uint32 rxed = 0;
    while (rxed < len) {
        rxed += usb_midi_rx((uint32*)buf + rxed, len - rxed);
    }

    return rxed;
}

/* Blocks forever until 1 byte is received */
uint32 USBMIDIEx::readPacket(void) {
    uint32 p;
    this->readPackets(&p, 1);
    return p;
}

uint8 USBMIDIEx::pending(void) {
    return usb_midi_get_pending();
}

uint8 USBMIDIEx::isConnected(void) {
    return usb_is_connected(USBLIB) && usb_is_configured(USBLIB);
}




// These are midi status message types are defined in MidiSpec.h

union EVENT_t {
    uint32 i;
    uint8 b[4];
    MIDI_EVENT_PACKET_t p;
};

// Handle decoding incoming MIDI traffic a word at a time -- remembers
//  what it needs to from one call to the next.
//
//  This is a private function & not meant to be called from outside this class.
//  It's used whenever data is available from the USB port.
//
void USBMIDIEx::dispatchPacket(uint32 p)
{
    union EVENT_t e;

    e.i=p;

    const byte a = 0x1;
    const byte b = 0x2;
    const byte c = 0x3;
    const byte d = 0xff;
    
    switch (e.p.cin) {
        case CIN_3BYTE_SYS_COMMON:
            switch (e.p.midi0) {
                case MIDIv1_SONG_POSITION_PTR:
                    handleSongPosition(((uint16)e.p.midi2)<<7|((uint16)e.p.midi1));
                    break;
            }
            break;

        case CIN_2BYTE_SYS_COMMON:
             switch (e.p.midi0) {
                 case MIDIv1_SONG_SELECT:
                     handleSongSelect(e.p.midi1);
                     break;
                 case MIDIv1_MTC_QUARTER_FRAME:
                     // reference library doesnt handle quarter frame.
                     break;
             }
            break;
        case CIN_NOTE_OFF:
            handleNoteOff(MIDIv1_VOICE_CHANNEL(e.p.midi0), e.p.midi1, e.p.midi2);
            break;
        case CIN_NOTE_ON:
            handleNoteOn(MIDIv1_VOICE_CHANNEL(e.p.midi0), e.p.midi1, e.p.midi2);
            break;
        case CIN_AFTER_TOUCH:
            handleVelocityChange(MIDIv1_VOICE_CHANNEL(e.p.midi0), e.p.midi1, e.p.midi2);
            break;
        case CIN_CONTROL_CHANGE:
            handleControlChange(MIDIv1_VOICE_CHANNEL(e.p.midi0), e.p.midi1, e.p.midi2);
            break;
        case CIN_PROGRAM_CHANGE:
            handleProgramChange(MIDIv1_VOICE_CHANNEL(e.p.midi0), e.p.midi1);
            break;
        case CIN_CHANNEL_PRESSURE:
            handleAfterTouch(MIDIv1_VOICE_CHANNEL(e.p.midi0), e.p.midi1);
            break;
                     
        case CIN_PITCH_WHEEL:
            handlePitchChange(((uint16)e.p.midi2)<<7|((uint16)e.p.midi1));
            break;
        case CIN_1BYTE:
            switch (e.p.midi0) {
                case MIDIv1_CLOCK:
                    handleSync();
                    break;
                case MIDIv1_TICK:
                    break;
                case MIDIv1_START:
                    handleStart();
                    break;
                case MIDIv1_CONTINUE:
                    handleContinue();
                    break;
                case MIDIv1_STOP:
                    handleStop();
                    break;
                case MIDIv1_ACTIVE_SENSE:
                    handleActiveSense();
                    break;
                case MIDIv1_RESET:
                    handleReset();
                    break;
                case MIDIv1_TUNE_REQUEST:
                    handleTuneRequest();
                    break;
                    
                default:
                    break;
            }
            break;
        case CIN_SYSEX:
        case CIN_SYSEX_ENDS_IN_1:
        case CIN_SYSEX_ENDS_IN_2:
        case CIN_SYSEX_ENDS_IN_3:
            {
              int endingIn = e.p.cin - CIN_SYSEX;
              int totalReads = endingIn ? endingIn : 3;
              const byte* baseValue = &e.p.midi0;
              if(e.p.midi0 == MIDIv1_SYSEX_START)
              {
                totalReads--;
                baseValue++;
                sysexParseLength = 0;
              }
                                          
              for(int i = 0; i < totalReads; ++i)
                if(sysexParseLength < sysexSize) sysexBuffer[sysexParseLength++] = *baseValue++;

              if(endingIn != 0)
              {
                handleSystemExclusive(sysexBuffer, sysexParseLength);
                sysexParseLength = 0;
              }
              break;
            }
        }
}


// Try to read data from USB port & pass anything read to processing function
void USBMIDIEx::poll(void)
{   while(available()) {
        dispatchPacket(readPacket());
    }
}

static union EVENT_t outPacket; // since we only use one at a time no point in reallocating it

// Send Midi NOTE OFF message to a given channel, with note 0-127 and velocity 0-127
void USBMIDIEx::sendNoteOff(unsigned int channel, unsigned int note, unsigned int velocity)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_NOTE_OFF;
    outPacket.p.midi0=MIDIv1_NOTE_OFF|(channel & 0x0f);
    outPacket.p.midi1=note;
    outPacket.p.midi2=velocity;
    writePacket(outPacket.i);
    
}


// Send Midi NOTE ON message to a given channel, with note 0-127 and velocity 0-127
void USBMIDIEx::sendNoteOn(unsigned int channel, unsigned int note, unsigned int velocity)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_NOTE_ON;
    outPacket.p.midi0=MIDIv1_NOTE_ON|(channel & 0x0f);
    outPacket.p.midi1=note;
    outPacket.p.midi2=velocity;
    writePacket(outPacket.i);
    
}

// Send a Midi VELOCITY CHANGE message to a given channel, with given note 0-127,
// and new velocity 0-127
// Note velocity change == polyphonic aftertouch.
// Note aftertouch == channel pressure.
void USBMIDIEx::sendVelocityChange(unsigned int channel, unsigned int note, unsigned int velocity)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_AFTER_TOUCH;
    outPacket.p.midi0=MIDIv1_AFTER_TOUCH |(channel & 0x0f);
    outPacket.p.midi1=note;
    outPacket.p.midi2=velocity;
    writePacket(outPacket.i);
    
}


// Send a Midi CC message to a given channel, as a given controller 0-127, with given
//  value 0-127
void USBMIDIEx::sendControlChange(unsigned int channel, unsigned int controller, unsigned int value)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_CONTROL_CHANGE;
    outPacket.p.midi0=MIDIv1_CONTROL_CHANGE |(channel & 0x0f);
    outPacket.p.midi1=controller;
    outPacket.p.midi2=value;
    writePacket(outPacket.i);
    
}

// Send a Midi PROGRAM CHANGE message to given channel, with program ID 0-127
void USBMIDIEx::sendProgramChange(unsigned int channel, unsigned int program)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_PROGRAM_CHANGE;
    outPacket.p.midi0=MIDIv1_PROGRAM_CHANGE |(channel & 0x0f);
    outPacket.p.midi1=program;
    writePacket(outPacket.i);
    
}

// Send a Midi AFTER TOUCH message to given channel, with velocity 0-127
void USBMIDIEx::sendAfterTouch(unsigned int channel, unsigned int velocity)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_CHANNEL_PRESSURE;
    outPacket.p.midi0=MIDIv1_CHANNEL_PRESSURE |(channel & 0x0f);
    outPacket.p.midi1=velocity;
    writePacket(outPacket.i);
    
}

// Send a Midi PITCH CHANGE message, with a 14-bit pitch (always for all channels)
void USBMIDIEx::sendPitchChange(unsigned int pitch)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_PITCH_WHEEL;
    outPacket.p.midi0=MIDIv1_PITCH_WHEEL;
    outPacket.p.midi1= (uint8) pitch & 0x07F;
    outPacket.p.midi2= (uint8)  (pitch>>7) & 0x7f;
    writePacket(outPacket.i);
    
}

// Send a Midi SONG POSITION message, with a 14-bit position (always for all channels)
void USBMIDIEx::sendSongPosition(unsigned int position)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_3BYTE_SYS_COMMON;
    outPacket.p.midi0=MIDIv1_SONG_POSITION_PTR;
    outPacket.p.midi1= (uint8) position & 0x07F;
    outPacket.p.midi2= (uint8)  (position>>7) & 0x7f;
    writePacket(outPacket.i);
    
}

// Send a Midi SONG SELECT message, with a song ID of 0-127 (always for all channels)
void USBMIDIEx::sendSongSelect(unsigned int song)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_2BYTE_SYS_COMMON;
    outPacket.p.midi0=MIDIv1_SONG_SELECT;
    outPacket.p.midi1= (uint8) song & 0x07F;
    writePacket(outPacket.i);
    
}

// Send a Midi TUNE REQUEST message (TUNE REQUEST is always for all channels)
void USBMIDIEx::sendTuneRequest(void)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_1BYTE;
    outPacket.p.midi0=MIDIv1_TUNE_REQUEST;
    writePacket(outPacket.i);
}


// Send a Midi SYNC message (SYNC is always for all channels)
void USBMIDIEx::sendSync(void)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_1BYTE;
    outPacket.p.midi0=MIDIv1_CLOCK;
    writePacket(outPacket.i);
}

// Send a Midi START message (START is always for all channels)
void USBMIDIEx::sendStart(void)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_1BYTE;
    outPacket.p.midi0=MIDIv1_START ;
    writePacket(outPacket.i);
}


// Send a Midi CONTINUE message (CONTINUE is always for all channels)
void USBMIDIEx::sendContinue(void)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_1BYTE;
    outPacket.p.midi0=MIDIv1_CONTINUE ;
    writePacket(outPacket.i);
}


// Send a Midi STOP message (STOP is always for all channels)
void USBMIDIEx::sendStop(void)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_1BYTE;
    outPacket.p.midi0=MIDIv1_STOP ;
    writePacket(outPacket.i);
}

// Send a Midi ACTIVE SENSE message (ACTIVE SENSE is always for all channels)
void USBMIDIEx::sendActiveSense(void)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_1BYTE;
    outPacket.p.midi0=MIDIv1_ACTIVE_SENSE ;
    writePacket(outPacket.i);
}

// Send a Midi RESET message (RESET is always for all channels)
void USBMIDIEx::sendReset(void)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_1BYTE;
    outPacket.p.midi0=MIDIv1_RESET ;
    writePacket(outPacket.i);
}

void USBMIDIEx::sendSystemExclusive(const byte * array, unsigned size)
{
    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_1BYTE;
    outPacket.p.midi0=MIDIv1_SYSEX_START;
    writePacket(outPacket.i);

    unsigned remaining = (int)size;
    while(remaining > 0)
    {
      switch(remaining)
      {
      case 1:
        outPacket.p.cin = CIN_SYSEX_ENDS_IN_1; 
        outPacket.p.midi0 = *array; 
        outPacket.p.midi1 = 0; 
        outPacket.p.midi2 = 0; 
        remaining = 0;
        break;
      case 2:
        outPacket.p.cin = CIN_SYSEX_ENDS_IN_2; 
        outPacket.p.midi0 = *array++; 
        outPacket.p.midi1 = *array;
        outPacket.p.midi2 = 0; 
        remaining = 0;
        break;
      case 3:
        outPacket.p.cin = CIN_SYSEX_ENDS_IN_3;
        outPacket.p.midi0 = *array++; 
        outPacket.p.midi1 = *array++; 
        outPacket.p.midi2 = *array; 
        remaining = 0;
        break;
      default:
        outPacket.p.cin = CIN_SYSEX; 
        outPacket.p.midi0 = *array++; 
        outPacket.p.midi1 = *array++; 
        outPacket.p.midi2 = *array++; 
        remaining -= 3;
        break;
      }
      writePacket(outPacket.i);
   }

    outPacket.p.cable=DEFAULT_MIDI_CABLE;
    outPacket.p.cin=CIN_1BYTE;
    outPacket.p.midi0=MIDIv1_SYSEX_END;
    writePacket(outPacket.i);
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
// Placeholders.  You should subclass the Midi base class and define these to have your
//  version called.
void USBMIDIEx::handleNoteOff(unsigned int channel, unsigned int note, unsigned int velocity) {}
void USBMIDIEx::handleNoteOn(unsigned int channel, unsigned int note, unsigned int velocity) {}
void USBMIDIEx::handleVelocityChange(unsigned int channel, unsigned int note, unsigned int velocity) {}
void USBMIDIEx::handleControlChange(unsigned int channel, unsigned int controller, unsigned int value) {}
void USBMIDIEx::handleProgramChange(unsigned int channel, unsigned int program) {}
void USBMIDIEx::handleAfterTouch(unsigned int channel, unsigned int velocity) {}
void USBMIDIEx::handlePitchChange(unsigned int pitch) {}
void USBMIDIEx::handleSongPosition(unsigned int position) {}
void USBMIDIEx::handleSongSelect(unsigned int song) {}
void USBMIDIEx::handleTuneRequest(void) {}
void USBMIDIEx::handleSync(void) {}
void USBMIDIEx::handleStart(void) {}
void USBMIDIEx::handleContinue(void) {}
void USBMIDIEx::handleStop(void) {}
void USBMIDIEx::handleActiveSense(void) {}
void USBMIDIEx::handleReset(void) {}
void USBMIDIEx::handleSystemExclusive(const byte *, unsigned int) {}
#pragma GCC diagnostic pop

////////////////////////////////////////////////
// FROM Arduino MIDI library
namespace SysEx
{
unsigned encode(const byte* inData, byte* outSysEx, unsigned inLength)
{
    unsigned outLength  = 0;     // Num bytes in output array.
    byte count          = 0;     // Num 7bytes in a block.
    outSysEx[0]         = 0;

    for (unsigned i = 0; i < inLength; ++i)
    {
        const byte data = inData[i];
        const byte msb  = data >> 7;
        const byte body = data & 0x7f;

        outSysEx[0] |= (msb << (6 - count));
        outSysEx[1 + count] = body;

        if (count++ == 6)
        {
            outSysEx   += 8;
            outLength  += 8;
            outSysEx[0] = 0;
            count       = 0;
        }
    }
    return outLength + count + (count != 0 ? 1 : 0);
}

unsigned decode(const byte* inSysEx, byte* outData, unsigned inLength)
{
    unsigned count  = 0;
    byte msbStorage = 0;
    byte byteIndex  = 0;

    for (unsigned i = 0; i < inLength; ++i)
    {
        if ((i % 8) == 0)
        {
            msbStorage = inSysEx[i];
            byteIndex  = 6;
        }
        else
        {
            const byte body = inSysEx[i];
            const byte msb  = ((msbStorage >> byteIndex--) & 1) << 7;
            outData[count++] = msb | body;
        }
    }
    return count;
}

} // end namespace SysEx
