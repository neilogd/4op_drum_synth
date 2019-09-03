#pragma once

#include <stdint.h>

class AnalogInputs
{
public:
  static constexpr int MAX_INPUTS = 8;
  AnalogInputs();
  
  void setInput(int idx, int pin);
  int getInput(int idx) const;

  void scan();

private:
  int8_t pins_[MAX_INPUTS];
  int values_[MAX_INPUTS];

};
