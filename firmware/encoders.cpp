#if !defined(WIN32)

#include <Arduino.h>
#include "encoders.h"

#include <algorithm>

namespace
{
	Encoders* encoder_ = nullptr;
} // 

Encoders::Encoders()
{
	for(int i = 0; i < NUM_ENCODERS; ++i)
	{
		scanPins_[i] = -1;
		buttonPins_[i] = -1;
		values_[i] = 0;
	}

  for(int i = 0; i < NUM_ROWS; ++i)
    for(int j = 0; j < NUM_COLS; ++j)
      state_[j][i] = 0;
  
	encoder_ = this;
}

void Encoders::setRowPin(int row, int pin)
{
  rowPins_[row] = pin;
  pinMode(pin, INPUT_PULLUP);
}

void Encoders::setColPin(int col, int pin)
{
  colPins_[col] = pin;
  pinMode(pin, OUTPUT_OPEN_DRAIN);
  digitalWrite(pin, HIGH);
}

void Encoders::scan()
{
  if(NUM_ENCODERS > 1 && colScanIdx_ != -1)
  {
		digitalWrite(colPins_[colScanIdx_], HIGH);
   }

  colScanIdx_++;
  if(colScanIdx_ >= NUM_COLS)
    colScanIdx_ = 0;

	digitalWrite(colPins_[colScanIdx_], LOW);
  
  // Read rows.
  int currRowState[NUM_ROWS];
  for(int i = 0; i < NUM_ROWS; ++i)
  {
    currRowState[i] = digitalRead(rowPins_[i]);
  }

  for(int i = 0; i < NUM_ROWS; i+=2)
  {
    int enc = ((i / 2) * NUM_COLS) + colScanIdx_;
    int value = values_[enc];

    int rot0 = state_[colScanIdx_][i] && !currRowState[i];
    int rot1 = state_[colScanIdx_][i+1] && !currRowState[i+1];

    if(rot1 && currRowState[i])
    {
      value--;
    }

    if(rot0 && currRowState[i+1])
    {
      value++;
    }

    values_[enc] = value;
  }

  for(int i = 0; i < NUM_ROWS; ++i)
  {
    state_[colScanIdx_][i] = currRowState[i];
  }
}

#endif // !defined(WIN32)
