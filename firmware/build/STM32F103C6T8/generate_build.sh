#!/bin/bash
cmake ../.. -DCMAKE_TOOLCHAIN_FILE=../../cmake/arm-none-eabi.toolchain.cmake -DSTM32_FAMILY=F1 -DSTM32_CHIP=STM32F103C8T6
