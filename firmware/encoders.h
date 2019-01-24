#pragma once

class Encoders
{
public:
	static constexpr int NUM_ENCODERS = 10;

  // Button rows & cols.
  // Each rotary encoder is 2 rows.
  static constexpr int NUM_ROWS = 4;
  static constexpr int NUM_COLS = 5;
  
	Encoders();

  void setRowPin(int row, int pin);
  void setColPin(int col, int pin);
	
  int getValue(int idx)
  { 
    int v = values_[idx];
    values_[idx] = 0;
    return v;
  }

  void logState();
  
	void scan();

private:
	int8_t colScanIdx_ = -1;

  int8_t rowPins_[NUM_ROWS];
  int8_t colPins_[NUM_COLS];

  int8_t state_[NUM_COLS][NUM_ROWS];
  
	int8_t scanPins_[NUM_ENCODERS];
	int8_t buttonPins_[NUM_ENCODERS];

	int8_t values_[NUM_ENCODERS];
};
