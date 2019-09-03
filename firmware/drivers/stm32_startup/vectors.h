#pragma once
 
#include "isr.h"
 
extern "C" void ResetHandler();
 
template<>
struct IRQHandler<VectorTableEntry::Reset>
{
    using constant_t =  std::integral_constant<void(*)(), ResetHandler>;
};

template<>
struct IRQHandler<VectorTableEntry::Hardfault>
{
    static constexpr auto LambdaHandler = [](){ 
        while(true);
    };
    using constant_t =  std::integral_constant<void(*)(), +LambdaHandler>;
};

// concrete implementation of vector table for this chip
//eventually split off into separate files or whatever per chip
__attribute__((section (".VectorTable"),used))
 constexpr auto static Table = VectorTable<
    // Cortex-M Core Handlers.
    VectorTableEntry::Reset,
    VectorTableEntry::Nmi,
    VectorTableEntry::Hardfault,
    VectorTableEntry::Empty,
    VectorTableEntry::Empty,
    VectorTableEntry::Empty,
    VectorTableEntry::Empty,
    VectorTableEntry::Empty,
    VectorTableEntry::Empty,
    VectorTableEntry::Empty,
    VectorTableEntry::Svc,
    VectorTableEntry::Empty,
    VectorTableEntry::Empty,
    VectorTableEntry::PendSV,
    VectorTableEntry::Systick,

    // External interrupts.
    VectorTableEntry::Watchdog,
    VectorTableEntry::Pvd,
    VectorTableEntry::Tamper,
    VectorTableEntry::Rtc,
    VectorTableEntry::Flash,
    VectorTableEntry::Rcc,
    VectorTableEntry::ExtI0,
    VectorTableEntry::ExtI1,
    VectorTableEntry::ExtI2,
    VectorTableEntry::ExtI3,
    VectorTableEntry::ExtI4,
    VectorTableEntry::Dma1Channel1,
    VectorTableEntry::Dma1Channel2,
    VectorTableEntry::Dma1Channel3,
    VectorTableEntry::Dma1Channel4,
    VectorTableEntry::Dma1Channel5,
    VectorTableEntry::Dma1Channel6,
    VectorTableEntry::Dma1Channel7,
    VectorTableEntry::Adc1_2,
    VectorTableEntry::Can1_TX,
    VectorTableEntry::Can1_RX0,
    VectorTableEntry::Can1_RX1,
    VectorTableEntry::Can1_SCE,
    VectorTableEntry::ExtI9_5,
    VectorTableEntry::Tim1_BRK,
    VectorTableEntry::Tim1_UP,
    VectorTableEntry::Tim1_TRG_COM,
    VectorTableEntry::Tim1_CC,
    VectorTableEntry::Tim2,
    VectorTableEntry::Tim3,
    VectorTableEntry::Tim4,
    VectorTableEntry::I2c1_EV,
    VectorTableEntry::I2c1_ER,
    VectorTableEntry::I2c2_EV,
    VectorTableEntry::I2c2_ER,
    VectorTableEntry::Spi1,
    VectorTableEntry::Spi2,
    VectorTableEntry::Usart1,
    VectorTableEntry::Usart2,
    VectorTableEntry::Usart3,
    VectorTableEntry::ExtI15_10,
    VectorTableEntry::RtcAlarm,
    VectorTableEntry::Otg_FS_WKUP,
    VectorTableEntry::Empty,
    VectorTableEntry::Tim5,
    VectorTableEntry::Spi3,
    VectorTableEntry::Uart4,
    VectorTableEntry::Uart5,
    VectorTableEntry::Tim6,
    VectorTableEntry::Tim7,
    VectorTableEntry::Dma2Channel1,
    VectorTableEntry::Dma2Channel2,
    VectorTableEntry::Dma2Channel3,
    VectorTableEntry::Dma2Channel4,
    VectorTableEntry::Dma2Channel5
    >().data;