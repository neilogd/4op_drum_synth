// create a type that takes the irqn as a template parameter. 
// Then we can create specialisations for specific irqns
 
 
// create a type for the table that takes a list of template parameters and unpacks them
// it instantiates a template for each of the pack members which is a specialization of the irq handler template
//could ask the table type to take a range based on the values in the enum class
#pragma once
 
#include <functional>
#include <stdint.h>
extern uint32_t _estack;
__attribute__((section (".StackPointer"),used))
const auto StackPointer = &_estack;
 
//probably needs to be renamed and the values altered for clarity - doesn't necessarily have to be the index here
//because we're setting the indexes manually in the declaration of VectorTableTest
enum class VectorTableEntry
{
    Empty,
    Reset,
    Nmi,
    Hardfault,
    Svc,
    PendSV,
    Systick,
    Watchdog,
    Pvd,
    Tamper,
    Rtc,
    Flash,
    Rcc,
    ExtI0,
    ExtI1,
    ExtI2,
    ExtI3,
    ExtI4,
    Dma1Channel1,
    Dma1Channel2,
    Dma1Channel3,
    Dma1Channel4,
    Dma1Channel5,
    Dma1Channel6,
    Dma1Channel7,
    Adc1_2,
    Can1_TX,
    Can1_RX0,
    Can1_RX1,
    Can1_SCE,
    ExtI9_5,
    Tim1_BRK,
    Tim1_UP,
    Tim1_TRG_COM,
    Tim1_CC,
    Tim2,
    Tim3,
    Tim4,
    I2c1_EV,
    I2c1_ER,
    I2c2_EV,
    I2c2_ER,
    Spi1,
    Spi2,
    Usart1,
    Usart2,
    Usart3,
    ExtI15_10,
    RtcAlarm,
    Otg_FS_WKUP,
    Tim5,
    Spi3,
    Uart4,
    Uart5,
    Tim6,
    Tim7,
    Dma2Channel1,
    Dma2Channel2,
    Dma2Channel3,
    Dma2Channel4,
    Dma2Channel5,
    Eth,
    Eth_WKUP,
    Can2_TX,
    Can2_RX0,
    Can2_RX1,
    Can2_SCE,
    Otg_FS,
};
 
//possibly should change this to take a normal integer and do a cast?
//default specialization, should use an infinite loop as an empty handler rather than the nullptr default for now
  
template<VectorTableEntry Index>
struct IRQHandler
{
    static constexpr VectorTableEntry HANDLER = Index;
    static constexpr auto LambdaHandler = []()
    {
        VectorTableEntry handleIndex = Index;
        while(true)
        {
            // Unhandled interrupt.
            (*(int*)&handleIndex)++;
            (*(int*)&handleIndex)--;
        }
    };

    //static constexpr auto Value =nullptr;
    using constant_t = std::integral_constant<void(*)(), +LambdaHandler>;
};
 
template<>
struct IRQHandler<VectorTableEntry::Empty>
{
    using constant_t = std::integral_constant<void(*)(), nullptr>;
};
 
//all these specializations can be written in other source files
//perhaps these can actually inherit from std::integral constant.. hrm
 
// //specialization via a free function
// template<>
// struct IRQHandler<VectorTableEntry::ResetHandler_IRQn>
// {
//     using constant_t = std::integral_constant<void(*)(), ResetHandler_Impl>;
// };
 
// template<>
// struct IRQHandler<VectorTableEntry::SVC_IRQn>
// {
//     static constexpr auto Value = SVCHandler_Impl;
// };
 
//specialization via lambda
// template<>
// struct IRQHandler<VectorTableEntry::NMI_IRQn>
// {
//     //triggers implicit conversion to pointer
//     static constexpr auto Value = [](){};
//     using constant_t = std::integral_constant<void(*)(), +Value>;
// };
 
template <class... T> struct typelist 
{
     
};
 
 
template<VectorTableEntry ...T>
struct VectorTable 
{
    static constexpr std::array<void(*)(), sizeof...(T)> data{{IRQHandler<T>::constant_t::value...}};
};
 
//should be possible to write a handler as 
//a) static member function 
//b) normal member function with 'this' captured via lambda
//c) free function
//c) lambda
//none of these should require C linkage