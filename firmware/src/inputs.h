#pragma once

#include "config.h"
#include "gpio.h"

class Inputs
{
public:
	static constexpr int NUM_ENCODERS = 5;

    // Button rows & cols.
    // Each rotary encoder is 3 rows.
    static constexpr int NUM_ROWS = 3;
    static constexpr int NUM_COLS = 5;
    
    Inputs();

    void setRowPin(int row, GPIO::Pin pin);
    void setColPin(int col, GPIO::Pin pin);
	
    int getEncoderValue(int idx)
    { 
        int v = values_[idx];
        values_[idx] = 0;
        return v;
    }

    int getEncoderButton(int idx) const
    {
        return button_[idx];
    }

    void emulate(uint16_t id, uint16_t val);

    void logState();
    void scan();

private:
    int8_t colScanIdx_ = -1;

    GPIO::Pin rowPins_[NUM_ROWS];
    GPIO::Pin colPins_[NUM_COLS];

    int8_t state_[NUM_COLS][NUM_ROWS];
    
    int8_t values_[NUM_ENCODERS];
    int8_t button_[NUM_ENCODERS];
};
