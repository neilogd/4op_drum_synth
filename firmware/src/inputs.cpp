#include "inputs.h"

namespace
{
    Inputs* encoder_ = nullptr;
} // 

Inputs::Inputs()
{
    for(int i = 0; i < NUM_ENCODERS; ++i)
    {
        values_[i] = 0;
        button_[i] = 1;
    }

    for(int i = 0; i < NUM_ROWS; ++i)
        for(int j = 0; j < NUM_COLS; ++j)
            state_[j][i] = 0;
    
    encoder_ = this;
}

void Inputs::setRowPin(int row, GPIO::Pin pin)
{
    rowPins_[row] = pin;

    GPIO::SetMode(pin, GPIO_MODE_INPUT, GPIO_PULLUP);
}

void Inputs::setColPin(int col, GPIO::Pin pin)
{
    colPins_[col] = pin;

    GPIO::SetMode(pin, GPIO_MODE_OUTPUT_OD, GPIO_NOPULL);
    GPIO::Write(pin, true);
}

void Inputs::emulate(uint16_t id, uint16_t val)
{
    switch(id)
    {
    case 'a':
        if(val)
            values_[0]--;
        break;
    case 'd':
        if(val)
        values_[0]++;
        break;
    case 's':
        button_[0] = val;
        break;
    case 'j':
        if(val)
            values_[1]--;
        break;
    case 'l':
        if(val)
            values_[1]++;
        break;
    case 'k':
        button_[1] = val;
        break;
    };
}

void Inputs::scan()
{
    if(NUM_ENCODERS > 1 && colScanIdx_ != -1)
    {
        GPIO::Write(colPins_[colScanIdx_], true);
    }

    colScanIdx_++;
    if(colScanIdx_ >= NUM_COLS)
        colScanIdx_ = 0;

    GPIO::Write(colPins_[colScanIdx_], false);
        
    // Read rows.
    bool currRowState[NUM_ROWS];
    for(int i = 0; i < NUM_ROWS; ++i)
    {
        currRowState[i] = GPIO::Read(rowPins_[i]);
    }

    for(int i = 0; i < NUM_ROWS; i+=3)
    {
        int enc = ((i / 3) * NUM_COLS) + colScanIdx_;
        int value = values_[enc];

        int rot0 = state_[colScanIdx_][i] && !currRowState[i];
        int rot1 = state_[colScanIdx_][i+1] && !currRowState[i+1];
        int btn = !currRowState[i+2];

        if(rot1 && currRowState[i])
        {
            value--;
        }

        if(rot0 && currRowState[i+1])
        {
            value++;
        }

        values_[enc] = value;
        button_[enc] = btn;
    }

    for(int i = 0; i < NUM_ROWS; ++i)
    {
        state_[colScanIdx_][i] = currRowState[i];
    }
}
