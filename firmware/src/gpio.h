#pragma once

#include <stdint.h>

#if PLATFORM_STM32
#include <stm32f1xx_hal.h>

using ptrsize = uint32_t;
#else

// Pull in some types directly to build on non-STM32 targets for testing.
typedef uint32_t GPIO_TypeDef;

using ptrsize = uint64_t;

#define GPIOA_BASE ((ptrsize)0x40000000U)
#define GPIOB_BASE ((ptrsize)0x40001000U) 
#define GPIOC_BASE ((ptrsize)0x40002000U) 
#define GPIOD_BASE ((ptrsize)0x40003000U) 

#define  GPIO_SPEED_FREQ_LOW      (0x00000000U)
#define  GPIO_SPEED_FREQ_MEDIUM   (0x00000001U)
#define  GPIO_SPEED_FREQ_HIGH     (0x00000003U)

#define  GPIO_NOPULL        (0x00000000U)
#define  GPIO_PULLUP        (0x00000001U)
#define  GPIO_PULLDOWN      (0x00000002U)

#define  GPIO_MODE_INPUT                        0x00000000U
#define  GPIO_MODE_OUTPUT_PP                    0x00000001U
#define  GPIO_MODE_OUTPUT_OD                    0x00000011U
#define  GPIO_MODE_AF_PP                        0x00000002U
#define  GPIO_MODE_AF_OD                        0x00000012U
#define  GPIO_MODE_AF_INPUT                     GPIO_MODE_INPUT
#define  GPIO_MODE_ANALOG                       0x00000003U
#define  GPIO_MODE_IT_RISING                    0x10110000U
#define  GPIO_MODE_IT_FALLING                   0x10210000U
#define  GPIO_MODE_IT_RISING_FALLING            0x10310000U
#define  GPIO_MODE_EVT_RISING                   0x10120000U
#define  GPIO_MODE_EVT_FALLING                  0x10220000U
#define  GPIO_MODE_EVT_RISING_FALLING           0x10320000U

#endif

namespace GPIO
{
    // Pack bank and pin into a uint8_t for convenience.
    #define MAKE_GPIO_PIN(bank, pin) (uint8_t)(((bank - 'A') << 4) | (pin))
    enum Pin : uint8_t
    {
        A0     = MAKE_GPIO_PIN('A', 0),
        A1     = MAKE_GPIO_PIN('A', 1),
        A2     = MAKE_GPIO_PIN('A', 2),
        A3     = MAKE_GPIO_PIN('A', 3),
        A4     = MAKE_GPIO_PIN('A', 4),
        A5     = MAKE_GPIO_PIN('A', 5),
        A6     = MAKE_GPIO_PIN('A', 6),
        A7     = MAKE_GPIO_PIN('A', 7),
        A8     = MAKE_GPIO_PIN('A', 8),
        A9     = MAKE_GPIO_PIN('A', 9),
        A10    = MAKE_GPIO_PIN('A', 10),
        A11    = MAKE_GPIO_PIN('A', 11),
        A12    = MAKE_GPIO_PIN('A', 12),
        A13    = MAKE_GPIO_PIN('A', 13),
        A14    = MAKE_GPIO_PIN('A', 14),
        A15    = MAKE_GPIO_PIN('A', 15),
        B0     = MAKE_GPIO_PIN('B', 0),
        B1     = MAKE_GPIO_PIN('B', 1),
        B2     = MAKE_GPIO_PIN('B', 2),
        B3     = MAKE_GPIO_PIN('B', 3),
        B4     = MAKE_GPIO_PIN('B', 4),
        B5     = MAKE_GPIO_PIN('B', 5),
        B6     = MAKE_GPIO_PIN('B', 6),
        B7     = MAKE_GPIO_PIN('B', 7),
        B8     = MAKE_GPIO_PIN('B', 8),
        B9     = MAKE_GPIO_PIN('B', 9),
        B10    = MAKE_GPIO_PIN('B', 10),
        B11    = MAKE_GPIO_PIN('B', 11),
        B12    = MAKE_GPIO_PIN('B', 12),
        B13    = MAKE_GPIO_PIN('B', 13),
        B14    = MAKE_GPIO_PIN('B', 14),
        B15    = MAKE_GPIO_PIN('B', 15),
        C0     = MAKE_GPIO_PIN('C', 0),
        C1     = MAKE_GPIO_PIN('C', 1),
        C2     = MAKE_GPIO_PIN('C', 2),
        C3     = MAKE_GPIO_PIN('C', 3),
        C4     = MAKE_GPIO_PIN('C', 4),
        C5     = MAKE_GPIO_PIN('C', 5),
        C6     = MAKE_GPIO_PIN('C', 6),
        C7     = MAKE_GPIO_PIN('C', 7),
        C8     = MAKE_GPIO_PIN('C', 8),
        C9     = MAKE_GPIO_PIN('C', 9),
        C10    = MAKE_GPIO_PIN('C', 10),
        C11    = MAKE_GPIO_PIN('C', 11),
        C12    = MAKE_GPIO_PIN('C', 12),
        C13    = MAKE_GPIO_PIN('C', 13),
        C14    = MAKE_GPIO_PIN('C', 14),
        C15    = MAKE_GPIO_PIN('C', 15),
    };

    // Rather than a lookup, verify the GPIO offsets.
    constexpr ptrsize GPIO_INCR_AB = GPIOB_BASE - GPIOA_BASE;
    constexpr ptrsize GPIO_INCR_BC = GPIOC_BASE - GPIOB_BASE;
    static_assert(GPIO_INCR_AB == GPIO_INCR_BC, "GPIO bank offsets don't match. Need to use lookup table.");

    constexpr GPIO_TypeDef* GetPinBank(Pin pin)
    {
        return (GPIO_TypeDef*)(GPIOA_BASE + (pin >> 4) * GPIO_INCR_AB);
    }

    constexpr uint16_t GetPinMask(Pin pin)
    {
        return 1 << (uint16_t)((uint8_t)pin & 0xf);
    }

    inline void Write(Pin pin, bool state)
    {
#if PLATFORM_STM32
        HAL_GPIO_WritePin(GetPinBank(pin), GetPinMask(pin), state ? GPIO_PIN_SET : GPIO_PIN_RESET);
#endif
    }

    inline bool Read(Pin pin)
    {
#if PLATFORM_STM32
        return !!HAL_GPIO_ReadPin(GetPinBank(pin), GetPinMask(pin));
#else
        return false;
#endif
    }

    inline void SetMode(Pin pin, uint32_t mode, uint32_t pull = GPIO_NOPULL, uint32_t speed = GPIO_SPEED_FREQ_LOW)
    {
#if PLATFORM_STM32
        GPIO_InitTypeDef GPIO_InitStruct = {};
        GPIO_InitStruct.Mode = mode;
        GPIO_InitStruct.Pull = pull;
        GPIO_InitStruct.Speed = speed;
        GPIO_InitStruct.Pin = GPIO::GetPinMask(pin);
        HAL_GPIO_Init(GetPinBank(pin), &GPIO_InitStruct);
#endif
    }
}

