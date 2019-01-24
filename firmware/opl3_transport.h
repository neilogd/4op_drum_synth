#pragma once

#include <SPI.h>

#include "stm32f1/include/series/stm32.h"
#include "stm32f1/include/series/gpio.h"
#include "stm32f1/include/series/rcc.h"
#include "MCP23S17.h"

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

  ICTransportExpander(SPIClass* spi)
    : io(*spi, 0, PB12)
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
