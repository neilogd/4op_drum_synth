#include "analog_inputs.h"

AnalogInputs::AnalogInputs()
{
  for(int i = 0; i < MAX_INPUTS; ++i)
  {
    pins_[i] = -1;
    values_[i] = 0;
  }
}

void AnalogInputs::setInput(int idx, int pin)
{
  pins_[idx] = pin;
  pinMode(pin, INPUT_ANALOG); 
}

int AnalogInputs::getInput(int idx) const
{
  return values_[idx];
}

void AnalogInputs::scan()
{
  // TODO: Use ADC isr.
  for(int i = 0; i < MAX_INPUTS; ++i)
  {
    if(pins_[i] != -1)
      values_[i] = analogRead(pins_[i]);
  }
}
