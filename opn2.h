#pragma once

#include <cstdint>
#include <memory>

#pragma warning(disable : 4334) // result of 32-bit shift implicitly converted to 64 bits (was 64-bit shift intended?)

namespace OPN2
{
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
		LFO_ENABLE		= REG(0x22, 3, 1),
		LFO_FREQ		= REG(0x22, 0, 3),
		TIMER_A_MSB		= REG(0x24, 0, 8),
		TIMER_A_LSB		= REG(0x25, 0, 2),
		TIMER_B			= REG(0x26, 0, 8),
		CH3_MODE		= REG(0x27, 7, 2),
		RESET_B			= REG(0x27, 5, 1),
		RESET_A			= REG(0x27, 4, 1),
		ENABLE_B		= REG(0x27, 3, 1),
		ENABLE_A		= REG(0x27, 2, 1),
		LOAD_B			= REG(0x27, 1, 1),
		LOAD_A			= REG(0x27, 0, 1),
		OPERATOR		= REG(0x28, 4, 4),
		CHANNEL			= REG(0x28, 0, 3),
		DAC				= REG(0x2A, 0, 8),
		DAC_ENABLE		= REG(0x2B, 7, 1),


		DT1				= REG(0x30, 4, 3),
		MUL				= REG(0x30, 0, 4),
		TL				= REG(0x40, 0, 7),
		RS				= REG(0x50, 6, 2),
		AR				= REG(0x50, 5, 0),
		AM				= REG(0x60, 7, 1),
		D1R				= REG(0x60, 1, 5),
		D2R				= REG(0x70, 1, 5),
		D1L				= REG(0x80, 4, 4),
		RR				= REG(0x80, 0, 4),
		SSG_EG			= REG(0x90, 0, 4),

		FREQ_LSB		= REG(0xA0, 0, 8),
		BLOCK			= REG(0xA4, 3, 3),
		FREQ_MSB		= REG(0xA4, 0, 3),

		CH3_FREQ_LSB	= REG(0xA8, 0, 8),
		CH3_BLOCK		= REG(0xAC, 3, 3),
		CH3_FREQ_MSB	= REG(0xAC, 0, 3),

		FEEDBACK		= REG(0xB0, 3, 3),
		ALGORITHM		= REG(0xB0, 0, 3),
		L				= REG(0xB4, 7, 1),
		R				= REG(0xB4, 6, 1),
		AMS				= REG(0xB4, 4, 2),
		FMS				= REG(0xB4, 0, 4),
	};

	template<class TRANS>
	class Interface
	{
	public:
	  Interface(TRANS&& trans = TRANS())
	  {
		memset(regs_, 0, sizeof(regs_));
		memset(dirty_, 0x0, sizeof(dirty_));
	  }
  
	  void setRegister(uint8_t arr, uint8_t reg, uint8_t val)
	  {
		regs_[arr][reg] = val;
		setDirty(arr, reg);
		flush();
	  }

	  void setRegister(uint8_t arr, Register reg, uint8_t off, uint8_t val)
	  {
		const uint8_t addr = uint8_t(reg) + off;
		const uint16_t bit = (uint16_t(reg) >> 8) & 0xf;
		const uint16_t bits = (uint16_t(reg) >> 12) & 0xf;
		const uint16_t mask = ~(((1 << bits) - 1) << bit);
		regs_[arr][addr] &= mask;
		regs_[arr][addr] |= (val << bit); 
		setDirty(arr, addr);
		flush();
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
	  TRANS trans_;
	  uint8_t regs_[2][256] = {};
	  uint64_t dirty_[2][4] = {};

	  bool getDirty(uint8_t arr, uint8_t reg)
	  {
		return dirty_[arr][reg >> 6] & (1 << (reg & 0x3f));
	  }

	  void setDirty(uint8_t arr, uint8_t reg)
	  {
		dirty_[arr][reg >> 6] |= (1 << (reg & 0x3f));    
	  }
  
	};
} // end namespace
