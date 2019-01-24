#pragma once

#include <stdint.h>

namespace OPL3
{
  static const constexpr int8_t OP_OFF[36][2] = {
    { 0x00, 0x00 }, { 0x00, 0x01 }, { 0x00, 0x02 }, { 0x00, 0x03 }, { 0x00, 0x04 }, { 0x00, 0x05 },
	{ 0x00, 0x08 }, { 0x00, 0x09 }, { 0x00, 0x0A }, { 0x00, 0x0B }, { 0x00, 0x0C }, { 0x00, 0x0D },
    { 0x00, 0x10 }, { 0x00, 0x11 }, { 0x00, 0x12 }, { 0x00, 0x13 }, { 0x00, 0x14 }, { 0x00, 0x15 },
    { 0x01, 0x00 }, { 0x01, 0x01 }, { 0x01, 0x02 }, { 0x01, 0x03 }, { 0x01, 0x04 }, { 0x01, 0x05 },
    { 0x01, 0x08 }, { 0x01, 0x09 }, { 0x01, 0x0A }, { 0x01, 0x0B }, { 0x01, 0x0C }, { 0x01, 0x0D },
    { 0x01, 0x10 }, { 0x01, 0x11 }, { 0x01, 0x12 }, { 0x01, 0x13 }, { 0x01, 0x14 }, { 0x01, 0x15 },
  };

  static const constexpr int8_t MODE_2OP[2][18] = {  
	{  0,  1,  2,  6,  7,  8, 12, 13, 14, 18, 19, 20, 24, 25, 26, 30, 31, 32},
	{  3,  4,  5,  9, 10, 11, 15, 16, 17, 21, 22, 23, 27, 28, 29, 33, 34, 35},
  };

  static const constexpr int8_t MODE_2OP_PERC[2][5] = {
	{ 12, 16, 14, 17, 13 },
	{ 15, -1, -1, -1, -1 },
  };

  static const constexpr int8_t MODE_4OP[4][18] = {  
	{  0,  1,  2, -1, -1, -1, 12, 13, 14, 18, 19, 20, -1, -1, -1, 30, 31, 32},
	{  3,  4,  5, -1, -1, -1, 15, 16, 17, 21, 22, 23, -1, -1, -1, 33, 34, 35},
	{  6,  7,  8, -1, -1, -1, -1, -1, -1, 24, 25, 26, -1, -1, -1, -1, -1, -1},
	{  9, 10, 11, -1, -1, -1, -1, -1, -1, 27, 28, 29, -1, -1, -1, -1, -1, -1},
  };

  static const constexpr int8_t MODE_4OP_PERC[2][5] = {
	{ 12, 16, 14, 17, 13 },
	{ 15, -1, -1, -1, -1 },
  };

	struct Transport
	{
	  /**
	   * @param arr Register Array (0 or 1)
	   * @param addr Register Address.
	   * @param data Register Data.
	   */
	  void writeReg(uint8_t arr, uint8_t addr, uint8_t data);
	};

	#define REG(_reg, _bit, _bits) (uint16_t(_reg) | (uint16_t(_bit) << 8) | (uint16_t(_bits) << 12))

	enum class Register : uint16_t
	{
	  WS_ENABLE = REG(0x01, 5, 1),
	  TEST_REG  = REG(0x01, 0, 5),
	  T1        = REG(0x02, 0, 8),
	  T2        = REG(0x03, 0, 8),
	  IRQ_RESET = REG(0x04, 7, 1),
	  T1_MASK   = REG(0x04, 6, 1),
	  T2_MASK   = REG(0x04, 5, 1),
	  T1_START  = REG(0x04, 1, 1),
	  T2_START  = REG(0x04, 1, 1),
	  EN_4OP_BE = REG(0x04, 5, 1),
	  EN_4OP_AD = REG(0x04, 4, 1),
	  EN_4OP_9C = REG(0x04, 3, 1),
	  EN_4OP_25 = REG(0x04, 2, 1),
	  EN_4OP_14 = REG(0x04, 1, 1),
	  EN_4OP_03 = REG(0x04, 0, 1),
	  OPL3      = REG(0x05, 0, 1),
	  CSW       = REG(0x08, 7, 1),
	  NOTE_SEL  = REG(0x08, 6, 1),
	  EN_TRE    = REG(0x20, 7, 1),
	  EN_VIB    = REG(0x20, 6, 1),
	  EN_SUS    = REG(0x20, 5, 1),
	  KSR       = REG(0x20, 4, 1),
	  MULT      = REG(0x20, 0, 4),
	  KSL       = REG(0x40, 6, 2),
	  ATTN      = REG(0x40, 0, 6),
	  ATTACK    = REG(0x60, 4, 4),
	  DECAY     = REG(0x60, 0, 4),
	  SUSTAIN   = REG(0x80, 4, 4),
	  RELEASE   = REG(0x80, 0, 4),
	  FREQ_LSB  = REG(0xA0, 0, 8),
	  KEY_ON    = REG(0xB0, 5, 1),
	  BLOCK_NUM = REG(0xB0, 2, 3),
	  FREQ_MSB  = REG(0xB0, 0, 2),
	  TREM_DEP  = REG(0xBD, 7, 1),
	  VIBR_DEP  = REG(0xBD, 6, 1),
	  PERC_MODE = REG(0xBD, 5, 1),
	  BC_ON     = REG(0xBD, 4, 1),
	  SD_ON     = REG(0xBD, 3, 1),
	  TD_ON     = REG(0xBD, 2, 1),
	  CY_ON     = REG(0xBD, 1, 1),
	  HH_ON     = REG(0xBD, 0, 1),
	  CONN		  = REG(0xC0, 0, 1),
	  FEEDBACK	= REG(0xC0, 1, 3),
	  CHAN_A	  = REG(0xC0, 4, 1),
	  CHAN_B	  = REG(0xC0, 5, 1),
	  CHAN_C	  = REG(0xC0, 6, 1),
	  CHAN_D	  = REG(0xC0, 7, 1),
	  WAVE_SEL  = REG(0xE0, 0, 3),
	};

	template<class TRANS>
	class Interface
	{
	public:
	  Interface(TRANS& trans)
      : trans_(trans)
    {
		  memset(regs_, 0, sizeof(regs_));
	  	memset(dirty_, 0xff, sizeof(dirty_));
	  }
  
	  void setRegister(uint8_t arr, uint8_t reg, uint8_t val)
	  {
  		//if(val != regs_[arr][reg])
  		{
  			regs_[arr][reg] = val;
  			setDirty(arr, reg);
  		}
	  }

	  void clearRegisters()
	  {
  		for(int i = 0; i < 2; ++i)
  		  for(int j = 0; j < 256; ++j)
		  {
			  regs_[i][j] = 0;
			  setDirty(i, j);
		  }
	  }

	  void setRegister(uint8_t arr, Register reg, uint8_t off, uint8_t val)
	  {
  		const uint8_t addr = uint8_t(reg) + off;
  		const uint16_t bit = (uint16_t(reg) >> 8) & 0xf;
  		const uint16_t bits = (uint16_t(reg) >> 12) & 0xf;
  		const uint16_t mask = ~(((1 << bits) - 1) << bit);
  		const auto old = regs_[arr][addr];
  		regs_[arr][addr] &= mask;
  		regs_[arr][addr] |= (val << bit); 
  		//if(old != regs_[arr][addr] || reg == OPL3::Register::KEY_ON)
  			setDirty(arr, addr);
	  }

	  void flush()
	  {
  		for(int i = 0; i < 2; ++i)
  		  for(int j = 0; j < 256; ++j)
  			  if(getDirty(i, j))
  			    trans_.writeReg(i, j, regs_[i][j]);      
  		memset(dirty_, 0, sizeof(dirty_));
	  }

	  TRANS& getTransport()
	  {
		  return trans_;
	  }
  
	private:
	  TRANS& trans_;
	  uint8_t regs_[2][256] = {};
	  uint64_t dirty_[2][4] = {};

	  bool getDirty(uint8_t arr, uint8_t reg)
	  {
  		return dirty_[arr][reg >> 6] & (1ULL << (reg & 0x3f));
	  }

	  void setDirty(uint8_t arr, uint8_t reg)
	  {
  		dirty_[arr][reg >> 6] |= (1ULL << (reg & 0x3f));    
	  } 
	};
} // end namespace
