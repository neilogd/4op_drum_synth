#include "canvas.h"
#include "tile_canvas.h"
#include "profiling.h"

#include "ui.h"
#include "utils.h"

#include "opl3.h"
#include "display_st7735.h"
#include "printf.h"

#define PROGMEM
#include "fonts/Picopixel.h"


const char* ExampleName = "OPL3";

Params params;

static Inputs inputs;
static UI ui(inputs);

static uint8_t cmdListBuffer[1024];
static CommandList cmdList(cmdListBuffer, sizeof(cmdListBuffer));

constexpr int16_t TILE_W = 64;
constexpr int16_t TILE_H = 32;
constexpr int16_t CANVAS_W = 128;
constexpr int16_t CANVAS_H = 128;

static TileCanvas<TILE_W, TILE_H, CANVAS_W, CANVAS_H> tileCanvas;

#if defined(PLATFORM_STM32)
DMA_HandleTypeDef s_hdma15;
SPI_HandleTypeDef s_hspi2;
TIM_HandleTypeDef s_htim2;
TIM_HandleTypeDef s_htim3;
#endif

static int64_t s_precisionTimerBaseHz = 1000000; // 1MHz
static int64_t s_precisionTimerHz = 10000; // 10KHz
static int64_t s_precisionTimer = 0;

void Timer_SleepUS(int64_t us)
{
#if defined(PLATFORM_STM32)
    int64_t wait =  us / (1000000 / s_precisionTimerHz);
    int64_t end = s_precisionTimer + wait;
    while(s_precisionTimer < end)
        __NOP();
#endif
}

#if defined(PLATFORM_PC)
#define assert_param(expr) ((expr) ? (void)0U : assert_failed((const char*)__FILE__, __LINE__))

void assert_failed(const char* file, int line)
{
    printf("Assert failed: %s:%i\n", file, line);
    __builtin_trap();
}
#endif
    
namespace OPL3
{
#if defined(PLATFORM_STM32)
    struct ICTransportSPI
    {
        static const auto OPL3_A0   = GPIO::Pin::A6;
        static const auto OPL3_A1   = GPIO::Pin::A7;
        static const auto OPL3_CLK  = GPIO::Pin::B0;
        static const auto OPL3_CS   = GPIO::Pin::B1;
        static const auto OPL3_RST  = GPIO::Pin::B10;
        static const auto SPI_NSS   = GPIO::Pin::B12;
        
        SPI_HandleTypeDef* hspi_;

        float actual_clk;
        uint32_t ticks_per_ns = 0;

        static volatile uint32_t s_clockTicks;
        uint32_t nextWriteClock = 0;
        
        ICTransportSPI(SPI_HandleTypeDef* hspi)
            : hspi_(hspi)
        {
        }

        void reset()
        {
            // Setup output pins.
            GPIO::SetMode(OPL3_CLK, GPIO_MODE_AF_PP, GPIO_NOPULL, GPIO_SPEED_FREQ_HIGH);
            GPIO::SetMode(OPL3_A0, GPIO_MODE_OUTPUT_PP);
            GPIO::SetMode(OPL3_A1, GPIO_MODE_OUTPUT_PP);
            GPIO::SetMode(OPL3_CS, GPIO_MODE_OUTPUT_PP);
            GPIO::SetMode(OPL3_RST, GPIO_MODE_OUTPUT_PP);
            GPIO::SetMode(SPI_NSS, GPIO_MODE_OUTPUT_PP);

            GPIO::Write(OPL3_CS, true);
            GPIO::Write(OPL3_A0, false);
            GPIO::Write(OPL3_A1, false);
            GPIO::Write(OPL3_RST, true);
            GPIO::Write(SPI_NSS, false);

            setClock(CLOCK_SPEED_MHZ);

            softReset();
        }

        void setClock(float target_clk)
        {
            HAL_StatusTypeDef status;

            s_clockTicks = 0;
            
            // Get clock configuration.
            RCC_ClkInitTypeDef clkConfig;
            uint32_t flashLatency;
            HAL_RCC_GetClockConfig(&clkConfig, &flashLatency);

            // TODO: Calculate actual clock.
            actual_clk = target_clk;
            ticks_per_ns = (uint32_t)(1000.0f / actual_clk);

            const uint32_t timClock = ((clkConfig.APB1CLKDivider == RCC_HCLK_DIV1) ? 1 : 2) * HAL_RCC_GetPCLK1Freq();
            const float period_cyc = (float)(timClock / 1000000) / target_clk;
            const uint32_t max_reload = ((1 << 16) - 1);
            const uint16_t prescaler = (period_cyc / max_reload + 1);
            const float overflow = ((period_cyc + ((float)prescaler * 0.5f)) / (float)prescaler);

            TIM_Base_InitTypeDef timInit = {};
            timInit.Period = overflow;
            timInit.Prescaler = prescaler - 1;

            timInit.CounterMode = TIM_COUNTERMODE_UP;
            timInit.ClockDivision = TIM_CLOCKDIVISION_DIV1;
            timInit.RepetitionCounter = 1;
            timInit.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_ENABLE;

            TIM_OC_InitTypeDef ocInit = {};
            ocInit.OCMode = TIM_OCMODE_PWM1;
            ocInit.Pulse = timInit.Period / 2;
            ocInit.OCPolarity = TIM_OCPOLARITY_HIGH;
            ocInit.OCFastMode = TIM_OCFAST_DISABLE;

            s_htim3.Init = timInit;
            s_htim3.Instance = TIM3;

            __HAL_RCC_TIM3_CLK_ENABLE();
            HAL_NVIC_SetPriority(TIM3_IRQn, 3, 0);
            HAL_NVIC_EnableIRQ(TIM3_IRQn);

            status = HAL_TIM_PWM_Init(&s_htim3);
            assert_param(status == HAL_OK);

            TIM_MasterConfigTypeDef sMasterConfig = {};
            sMasterConfig.MasterOutputTrigger = TIM_TRGO_RESET;
            sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
            HAL_TIMEx_MasterConfigSynchronization(&s_htim3, &sMasterConfig); 

            status = HAL_TIM_PWM_ConfigChannel(&s_htim3, &ocInit, TIM_CHANNEL_3);
            assert_param(status == HAL_OK);

            status = HAL_TIM_PWM_Start(&s_htim3, TIM_CHANNEL_3);
            assert_param(status == HAL_OK);
        }

        inline void delayNanoseconds(uint32_t ns)
        {
            Timer_SleepUS(ns / 1000);
        }

        void softReset()
        {
            GPIO::Write(OPL3_RST, false);
            HAL_Delay(1);
            GPIO::Write(OPL3_RST, true);
        }

        void spiWrite(uint8_t data)
        {
            data = reversebit8(data);

            GPIO::Write(SPI_NSS, false);
            HAL_SPI_Transmit(hspi_, &data, 1, 100);
            GPIO::Write(SPI_NSS, true);

            delayNanoseconds(1);
        }
        
        void writeReg(uint8_t arr, uint8_t addr, uint8_t data)
        {
            GPIO::Write(OPL3_A0, false);
            GPIO::Write(OPL3_A1, false);

            // Write addr.
            GPIO::Write(OPL3_A1, !!arr);
            spiWrite(addr);

            GPIO::Write(OPL3_CS, false);
            delayNanoseconds(1);
            GPIO::Write(OPL3_CS, true);
            delayNanoseconds(7);

            // Write data.
            GPIO::Write(OPL3_A0, true);
            spiWrite(data);

            GPIO::Write(OPL3_CS, false);
            delayNanoseconds(1);
            GPIO::Write(OPL3_CS, true);
            delayNanoseconds(7);
        }
    };
    volatile uint32_t ICTransportSPI::s_clockTicks = 0;
#endif //defined(PLATFORM_STM32)

struct ICTransportNull
{
    ICTransportNull()
    {
    }

    void reset()
    {
    }

    void softReset()
    {
    }

    void writeReg(uint8_t arr, uint8_t addr, uint8_t data)
    {
    }
};


} // end namespace

#if defined(PLATFORM_STM32)
static OPL3::ICTransportSPI transport(&s_hspi2);
static OPL3::Interface<OPL3::ICTransportSPI> opl3(transport);
#else
static OPL3::ICTransportNull transport;
static OPL3::Interface<OPL3::ICTransportNull> opl3(transport);
#endif

struct OPL3RegisterMapping
{
    int arr[4];
    int off[4];
};

OPL3RegisterMapping GetRegisterMapping(int voiceIdx, int numOps)
{
    static const int VOICE_CH[6] = { 0, 1, 2, 9, 10, 11 };
    assert_param(voiceIdx < arraySize(VOICE_CH));
    int ch = VOICE_CH[voiceIdx];
    OPL3RegisterMapping reg;
    int op[4] = {0, 0, 0, 0};
    assert_param(numOps == 2 || numOps == 4);
    if (numOps == 2)
    {
        op[0] = OPL3::MODE_2OP[0][ch];
        op[1] = OPL3::MODE_2OP[1][ch];
        op[2] = -1;
        op[3] = -1;

        assert_param(op[0] != -1);
        assert_param(op[1] != -1);
    }
    else
    {
        op[0] = OPL3::MODE_4OP[0][ch];
        op[1] = OPL3::MODE_4OP[1][ch];
        op[2] = OPL3::MODE_4OP[2][ch];
        op[3] = OPL3::MODE_4OP[3][ch];

        assert_param(op[0] != -1);
        assert_param(op[1] != -1);
        assert_param(op[2] != -1);
        assert_param(op[3] != -1);
    }

    for (int i = 0; i < numOps; ++i)
    {
        const int8_t opIdx = op[i];
        assert_param(opIdx >= 0 && opIdx < 36);
        reg.arr[i] = OPL3::OP_OFF[opIdx][0];
        reg.off[i] = OPL3::OP_OFF[opIdx][1];
    }
    return reg;
} 

bool VoiceUpdate(VoiceParams& params, int idx, int vel, uint16_t freq)
{
    const int numOps = params.conn < 2 ? 2 : 4;
    const OPL3RegisterMapping reg = GetRegisterMapping(idx, numOps);

    int mode4op = numOps == 4 ? 1 : 0;
    switch (idx)
    {
        case 0: opl3.setRegister(1, OPL3::Register::EN_4OP_03, 0, mode4op); break;
        case 1: opl3.setRegister(1, OPL3::Register::EN_4OP_14, 0, mode4op); break;
        case 2: opl3.setRegister(1, OPL3::Register::EN_4OP_25, 0, mode4op); break;
        case 3: opl3.setRegister(1, OPL3::Register::EN_4OP_9C, 0, mode4op); break;
        case 4: opl3.setRegister(1, OPL3::Register::EN_4OP_AD, 0, mode4op); break;
        case 5: opl3.setRegister(1, OPL3::Register::EN_4OP_BE, 0, mode4op); break;
        default: break;
    }

    // Per voice config.
    int attn[4] = { 0, 0, 0, 0 };
    {
        float f = freq < 0.0f ? params.freq : freq;
        int b = 0;

        if (f < 48.503f)
            b = 0;
        else if (f < 97.006f)
            b = 1;
        else if (f < 194.013f)
            b = 2;
        else if (f < 388.026f)
            b = 3;
        else if (f < 776.053f)
            b = 4;
        else if (f < 1552.107f)
            b = 5;
        else if (f < 3104.215f)
            b = 6;
        else if (f < 6208.431f)
            b = 7;

        uint16_t fnum = (uint16_t)(f * POW2_19 / ((CLOCK_SPEED_MHZ * 1000000.0f) / 288.0f) / POW2_B_MINUS_1[b]);

        opl3.setRegister(reg.arr[0], OPL3::Register::BLOCK_NUM, reg.off[0], b);
        opl3.setRegister(reg.arr[0], OPL3::Register::FREQ_MSB, reg.off[0], fnum >> 8);
        opl3.setRegister(reg.arr[0], OPL3::Register::FREQ_LSB, reg.off[0], fnum & 0xff);
        opl3.setRegister(reg.arr[0], OPL3::Register::FEEDBACK, reg.off[0], params.feedback);

        if (vel == -1)
        vel = 127;
        uint32_t voiceAttn = (127 - vel) >> 2;
        switch (params.conn)
        {
        case 0:
            opl3.setRegister(reg.arr[0], OPL3::Register::CONN, reg.off[0], 0);
            attn[1] = voiceAttn;
            break;
        case 1:
            opl3.setRegister(reg.arr[0], OPL3::Register::CONN, reg.off[0], 1);
            attn[0] = voiceAttn;
            attn[1] = voiceAttn;
            break;
        case 2:
            opl3.setRegister(reg.arr[0], OPL3::Register::CONN, reg.off[0], 0);
            opl3.setRegister(reg.arr[1], OPL3::Register::CONN, reg.off[1], 0);
            attn[3] = voiceAttn;
            break;
        case 3:
            opl3.setRegister(reg.arr[0], OPL3::Register::CONN, reg.off[0], 0);
            opl3.setRegister(reg.arr[1], OPL3::Register::CONN, reg.off[1], 1);

            attn[0] = voiceAttn;
            attn[3] = voiceAttn;
            break;
        case 4:
            opl3.setRegister(reg.arr[0], OPL3::Register::CONN, reg.off[0], 1);
            opl3.setRegister(reg.arr[1], OPL3::Register::CONN, reg.off[1], 0);

            attn[1] = voiceAttn;
            attn[3] = voiceAttn;

            break;
        case 5:
            opl3.setRegister(reg.arr[0], OPL3::Register::CONN, reg.off[0], 1);
            opl3.setRegister(reg.arr[1], OPL3::Register::CONN, reg.off[1], 1);

            attn[0] = voiceAttn;
            attn[2] = voiceAttn;
            attn[3] = voiceAttn;
            break;
        }
    }

    for(int i = 0; i < 2; ++i)
    {
        // 0x20
        opl3.setRegister(reg.arr[i], OPL3::Register::EN_SUS, reg.off[i], 1 /*params.ops[i].en_sus*/);
#if ENABLE_VIBRATO
        opl3.setRegister(reg.arr[i], OPL3::Register::EN_TRE, reg.off[i], params.ops[i].en_tre);
#else
        opl3.setRegister(reg.arr[i], OPL3::Register::EN_TRE, reg.off[i], 0);
#endif
#if ENABLE_VIBRATO
        opl3.setRegister(reg.arr[i], OPL3::Register::EN_VIB, reg.off[i], params.ops[i].en_vib);
#else
        opl3.setRegister(reg.arr[i], OPL3::Register::EN_VIB, reg.off[i], 0);
#endif
        opl3.setRegister(reg.arr[i], OPL3::Register::KSR, reg.off[i], 0);
        opl3.setRegister(reg.arr[i], OPL3::Register::MULT, reg.off[i], params.ops[i].mult);

        // 0x40
        opl3.setRegister(reg.arr[i], OPL3::Register::KSL, reg.off[i], 0);


        int attnSum = params.ops[i].attn + attn[i];
        opl3.setRegister(reg.arr[i], OPL3::Register::ATTN, reg.off[i], attnSum > 63 ? 63 : attnSum);

        // 0x60
        opl3.setRegister(reg.arr[i], OPL3::Register::ATTACK, reg.off[i], params.ops[i].a);
        opl3.setRegister(reg.arr[i], OPL3::Register::DECAY, reg.off[i], params.ops[i].d);

        // 0x80
        opl3.setRegister(reg.arr[i], OPL3::Register::SUSTAIN, reg.off[i], params.ops[i].s);
        opl3.setRegister(reg.arr[i], OPL3::Register::RELEASE, reg.off[i], params.ops[i].r);

        // 0xC0
        opl3.setRegister(reg.arr[i], OPL3::Register::CHAN_A, reg.off[i], !!(params.channels & 0b0001));
        opl3.setRegister(reg.arr[i], OPL3::Register::CHAN_B, reg.off[i], !!(params.channels & 0b0010));
        opl3.setRegister(reg.arr[i], OPL3::Register::CHAN_C, reg.off[i], !!(params.channels & 0b0100));
        opl3.setRegister(reg.arr[i], OPL3::Register::CHAN_D, reg.off[i], !!(params.channels & 0b1000));

        // 0xE0
        opl3.setRegister(reg.arr[i], OPL3::Register::WAVE_SEL, reg.off[i], params.ops[i].wave);
    }
 
    return true;
}

void VoiceKey(VoiceParams& params, int idx, bool keyon)
{
    const int numOps = params.conn < 2 ? 2 : 4;
    const OPL3RegisterMapping reg = GetRegisterMapping(idx, numOps);

    if (keyon)
    {
        opl3.setRegister(reg.arr[0], OPL3::Register::KEY_ON, reg.off[0], 1);
    }
    else
    {
        opl3.setRegister(reg.arr[0], OPL3::Register::KEY_ON, reg.off[0], 0);
    }
}

void ExampleInit()
{
    printf("CommandDrawHLine: %u\n", sizeof(CommandDrawHLine));
    printf("CommandDrawVLine: %u\n", sizeof(CommandDrawVLine));
    printf("CommandDrawLine: %u\n", sizeof(CommandDrawLine));
    printf("CommandDrawBox: %u\n", sizeof(CommandDrawBox));
    printf("CommandDrawFilledBox: %u\n", sizeof(CommandDrawFilledBox));
    printf("CommandDrawBitmap: %u\n", sizeof(CommandDrawBitmap));
    printf("CommandDrawPixels: %u\n", sizeof(CommandDrawPixels));
    printf("CommandDrawText: %u\n", sizeof(CommandDrawText));
    printf("CommandSetColors: %u\n", sizeof(CommandSetColors));
    printf("CommandSetFont: %u\n", sizeof(CommandSetFont));

    for(int i = 0; i < Params::MAX_STORED_VOICES; ++i)
    {
        sprintf(params.storedVoiceInfo[i].name, "Slot %i:", i);
    }

    opl3.getTransport().reset();
    opl3.clearRegisters();
    opl3.setRegister(0, OPL3::Register::WS_ENABLE, 0, 1);
    opl3.setRegister(0, OPL3::Register::TEST_REG, 0, 0);
    opl3.setRegister(1, OPL3::Register::OPL3, 0, 1);
    opl3.flush();
    
    ui.init();
}

void ExampleInput(uint16_t id, uint16_t val)
{
    inputs.emulate(id, val);
}

void ExampleTick(Canvas& canvas, DisplayST7735& display)
{  
    VoiceParams& voice = *params.getMappedVoiceParams(0);

    ui.update();
    cmdList.clear();
    
    ui.draw(cmdList);

#if 0
    int64_t size = (int64_t)cmdList.end() - (int64_t)cmdList.begin();
    printf("Command list size: %i\n", (int)size);
#endif 

    display.begin();
    tileCanvas.draw(canvas, true,
        []()
        {
            tileCanvas.executeCommandList(cmdList);
        });
    display.end();

    static VoiceParams oldVoice;
    VoiceUpdate(voice, 0, 16, -1);

    static bool lastBtn = false;
    if(inputs.getEncoderButton(1) && !lastBtn)
    {   
        VoiceKey(voice, 0, true);
        opl3.flush();
    }
    else if(!inputs.getEncoderButton(1) && lastBtn)
    {
        VoiceKey(voice, 0, false);
        opl3.flush();
    }

    lastBtn = inputs.getEncoderButton(1);
}

extern "C" void _putchar(char ch)
{

}

#if defined(PLATFORM_PC)
#include <SDL2/SDL.h>

#include <sys/time.h>
#include <vector>

class SDL2_Canvas : public Canvas
{
public:
    SDL2_Canvas(SDL_Renderer* renderer)
        : Canvas(128,128)
    {
        texture_ = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGB565, SDL_TEXTUREACCESS_STREAMING, 128, 128);
    }

    ~SDL2_Canvas()
    {
        SDL_DestroyTexture(texture_);
    }

    void writePixels(int16_t x, int16_t y, int16_t w, int16_t h, const uint16_t* data) override
    {
        for(int j = 0; j < h; ++j)
        {
            for(int i = 0; i < w; ++i)
            {
                SDL_Rect rect = { x + i, y + j, 1, 1 };
                SDL_UpdateTexture(texture_, &rect, data++, 2);
            }
        }
    }

    void writePixels(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t c) override
    {
        for(int j = 0; j < h; ++j)
        {
            for(int i = 0; i < w; ++i)
            {
                SDL_Rect rect = { x + i, y + j, 1, 1 };
                SDL_UpdateTexture(texture_, &rect, &c, 2);
            }
        }
    }

    SDL_Texture* texture_;
    DisplayST7735 display;
};


int main()
{
    SDL_Init(SDL_INIT_VIDEO);

    char windowTitle[256];
    sprintf(windowTitle, "GFX Library Example: %s", ExampleName);

    SDL_Window* window = SDL_CreateWindow(
        windowTitle,
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        512, 512,
        0
    );

    SDL_Renderer* renderer = SDL_CreateRenderer(
        window, 0, SDL_RENDERER_ACCELERATED
    );

    SDL2_Canvas canvas(renderer);

    ExampleInit();

    SDL_Event ev;
    for(;;)
    {
        while(SDL_PollEvent(&ev))
        {
            switch(ev.type)
            {
            case SDL_QUIT:
                return 0;
            case SDL_KEYDOWN:
                ExampleInput(ev.key.keysym.sym, true);
                break;
            case SDL_KEYUP:
                ExampleInput(ev.key.keysym.sym, false);
            default:
                break;
            }
        }

        ExampleTick(canvas, canvas.display);

        SDL_Rect srcRect = { 0, 0, 128, 128 };
        SDL_Rect dstRect = { 0, 0, 512, 512 };

        SDL_SetRenderTarget(renderer, nullptr);
        SDL_RenderCopy(renderer, canvas.texture_, &srcRect, &dstRect);
        SDL_RenderPresent(renderer);
    }

    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();

    return 0;
}
#else

#include "stm32f1xx_hal.h"
#include "isr.h"

template<>
struct IRQHandler<VectorTableEntry::Systick>
{
    static constexpr auto LambdaHandler = [](){ 
        HAL_IncTick();
        HAL_SYSTICK_IRQHandler();
    };
    using constant_t = std::integral_constant<void(*)(), +LambdaHandler>;
};

template<>
struct IRQHandler<VectorTableEntry::Dma1Channel5>
{
    static constexpr auto LambdaHandler = [](){ 
        HAL_DMA_IRQHandler(&s_hdma15);
    };
    using constant_t = std::integral_constant<void(*)(), +LambdaHandler>;
};

extern "C" void HAL_TIM_IRQHandler(TIM_HandleTypeDef *htim);

template<>
struct IRQHandler<VectorTableEntry::Tim2>
{
    static constexpr auto LambdaHandler = [](){ 
        inputs.scan();

        HAL_TIM_IRQHandler(&s_htim2);
    };
    using constant_t = std::integral_constant<void(*)(), +LambdaHandler>;
};

template<>
struct IRQHandler<VectorTableEntry::Tim3>
{
    static constexpr auto LambdaHandler = [](){ 
        OPL3::ICTransportSPI::s_clockTicks++;

        HAL_TIM_IRQHandler(&s_htim3);
    };
    using constant_t = std::integral_constant<void(*)(), +LambdaHandler>;
};

extern "C" void HAL_SPI_IRQHandler(SPI_HandleTypeDef *hspi);

template<>
struct IRQHandler<VectorTableEntry::Spi2>
{
    static constexpr auto LambdaHandler = [](){ 
        HAL_SPI_IRQHandler(&s_hspi2);
    };
    using constant_t = std::integral_constant<void(*)(), +LambdaHandler>;
};

#include "vectors.h"

class Dummy_Canvas final : public Canvas
{
public:
    DisplayST7735 display;

    Dummy_Canvas(const DisplayConfig& config)
        : Canvas(128,128)
    {
        display.init(config);
    }

    ~Dummy_Canvas()
    {
    }

    void writePixels(int16_t x, int16_t y, int16_t w, int16_t h, const uint16_t* data) override
    {
        ProfilingTimestamp("writePixels BEGIN");
        display.setAddrWindow(x, y, w, h);
        display.writePixels(data, w * h);
        ProfilingTimestamp("writePixels END");
    }

    void writePixels(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t c) override
    {
        display.setAddrWindow(x, y, w, h);
        for(int j = 0; j < h; ++j)
        {
            for(int i = 0; i < w; ++i)
            {
                display.writePixels(&c, 1);
            }
        }
    }
};

void SystemClock_Config(void)
{
    RCC_OscInitTypeDef RCC_OscInitStruct = {};
    RCC_ClkInitTypeDef RCC_ClkInitStruct = {};

    RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
    RCC_OscInitStruct.HSEState = RCC_HSE_ON;
    RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
    RCC_OscInitStruct.HSIState = RCC_HSI_OFF;
    RCC_OscInitStruct.HSICalibrationValue = 16;
    RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
    RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
    RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL9;
    HAL_RCC_OscConfig(&RCC_OscInitStruct);

    RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK|
                                    RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
    RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
    RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
    RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
    RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV4;
    HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2);

    HAL_SYSTICK_Config(HAL_RCC_GetHCLKFreq()/1000);

    HAL_SYSTICK_CLKSourceConfig(SYSTICK_CLKSOURCE_HCLK);

    /* SysTick_IRQn interrupt configuration */
    HAL_NVIC_SetPriority(SysTick_IRQn, 0, 0);
}

static GPIO_TypeDef* LCD_GPIO = GPIOC;
static GPIO_TypeDef* SPI2_GPIO = GPIOB;

static const uint16_t LCD_CS = GPIO_PIN_13;
static const uint16_t LCD_RST = GPIO_PIN_14;
static const uint16_t LCD_DC = GPIO_PIN_15;

static const uint16_t SPI2_MOSI = GPIO_PIN_15;
static const uint16_t SPI2_MISO = GPIO_PIN_14;
static const uint16_t SPI2_SCLK = GPIO_PIN_13;
static const uint16_t SPI2_NSS = GPIO_PIN_12;

void GPIO_Config()
{
    // Disable JTAG, only enable SWD.
    __HAL_RCC_AFIO_CLK_ENABLE();
    __HAL_AFIO_REMAP_SWJ_NOJTAG();
    
    // Enable all GPIO banks.
    __HAL_RCC_GPIOA_CLK_ENABLE();
    __HAL_RCC_GPIOB_CLK_ENABLE();
    __HAL_RCC_GPIOC_CLK_ENABLE();

    // GPIO:
    GPIO_InitTypeDef GPIO_InitStruct;
    GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
    GPIO_InitStruct.Pull = GPIO_PULLDOWN;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;

    GPIO_InitStruct.Pin = LCD_CS | LCD_RST | LCD_DC;
    HAL_GPIO_Init(LCD_GPIO, &GPIO_InitStruct);

    // Init alternate function on SPI2 pins.
    GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    GPIO_InitStruct.Pin = SPI2_MOSI | SPI2_SCLK | SPI2_NSS;
    HAL_GPIO_Init(SPI2_GPIO, &GPIO_InitStruct);

    GPIO_InitStruct.Mode = GPIO_MODE_AF_INPUT;
    GPIO_InitStruct.Pin = SPI2_MISO;
    HAL_GPIO_Init(SPI2_GPIO, &GPIO_InitStruct);

    // Setup input handling.  
#if PCB_REV == 1
    inputs.setRowPin(0, GPIO::B6);
    inputs.setRowPin(1, GPIO::B7);
    inputs.setRowPin(2, GPIO::B8);
    inputs.setRowPin(3, GPIO::B9);
    inputs.setColPin(0, GPIO::A8);
    inputs.setColPin(1, GPIO::A15);
    inputs.setColPin(2, GPIO::B3);
    inputs.setColPin(3, GPIO::B4);
    inputs.setColPin(4, GPIO::B5);
#elif PCB_REV >= 2
    inputs.setRowPin(0, GPIO::B8);
    inputs.setRowPin(1, GPIO::B7);
    inputs.setRowPin(2, GPIO::B9);
    inputs.setColPin(0, GPIO::A15);
    inputs.setColPin(1, GPIO::B5);
    inputs.setColPin(2, GPIO::B6);
    inputs.setColPin(3, GPIO::B3);
    inputs.setColPin(4, GPIO::B4);
#endif
}

void DMA_Config()
{
    HAL_StatusTypeDef status;

    __HAL_RCC_DMA1_CLK_ENABLE();

    // DMA init.
    DMA_InitTypeDef DMAInitDef = {};
    DMAInitDef.Direction = DMA_MEMORY_TO_PERIPH;
    DMAInitDef.PeriphInc = DMA_PINC_DISABLE;
    DMAInitDef.MemInc = DMA_MINC_ENABLE;
    DMAInitDef.PeriphDataAlignment = DMA_PDATAALIGN_BYTE;
    DMAInitDef.MemDataAlignment = DMA_MDATAALIGN_BYTE;
    DMAInitDef.Mode = DMA_NORMAL;
    DMAInitDef.Priority = DMA_PRIORITY_LOW;

    s_hdma15.Init = DMAInitDef;
    s_hdma15.Instance = DMA1_Channel5;
    status = HAL_DMA_Init(&s_hdma15);
    assert_param(status == HAL_OK);

    HAL_NVIC_SetPriority(DMA1_Channel5_IRQn, 1, 1);
    HAL_NVIC_EnableIRQ(DMA1_Channel5_IRQn);
}

void SPI_Config()
{
    HAL_StatusTypeDef status;

    __HAL_RCC_SPI2_CLK_ENABLE();

    // SPI2 init.
    SPI_InitTypeDef SPIInitDef = {};
    SPIInitDef.Mode = SPI_MODE_MASTER;
    SPIInitDef.Direction = SPI_DIRECTION_1LINE;
    SPIInitDef.DataSize = SPI_DATASIZE_8BIT;
    SPIInitDef.CLKPolarity = SPI_POLARITY_LOW;
    SPIInitDef.CLKPhase = SPI_PHASE_1EDGE;
    SPIInitDef.NSS = SPI_NSS_SOFT;
    SPIInitDef.BaudRatePrescaler = SPI_BAUDRATEPRESCALER_2;
    SPIInitDef.FirstBit = SPI_FIRSTBIT_MSB;
    SPIInitDef.TIMode = SPI_TIMODE_DISABLE;
    SPIInitDef.CRCCalculation = SPI_CRCCALCULATION_DISABLE;
    SPIInitDef.CRCPolynomial = 0;

    s_hspi2 = {};
    s_hspi2.Instance = SPI2;
    s_hspi2.Init = SPIInitDef;

    __HAL_LINKDMA(&s_hspi2, hdmatx, s_hdma15);

    status = HAL_SPI_Init(&s_hspi2);
}

void TIM_Config()
{
    HAL_StatusTypeDef status;

    // Get clock configuration.
    RCC_ClkInitTypeDef clkConfig;
    uint32_t flashLatency;
    HAL_RCC_GetClockConfig(&clkConfig, &flashLatency);

    const uint32_t timHz = s_precisionTimerBaseHz;
    const uint32_t targetHz = s_precisionTimerHz;
    const uint32_t timClock = ((clkConfig.APB1CLKDivider == RCC_HCLK_DIV1) ? 1 : 2) * HAL_RCC_GetPCLK1Freq();
    const uint32_t prescalerValue = (uint32_t) ((timClock / timHz) - 1U);

    TIM_Base_InitTypeDef timInit = {};
    timInit.Period = (timHz / targetHz) - 1U;
    timInit.Prescaler = prescalerValue;
    timInit.CounterMode = TIM_COUNTERMODE_UP;
    timInit.ClockDivision = TIM_CLOCKDIVISION_DIV1;
    timInit.RepetitionCounter = 1;
    timInit.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_DISABLE;

    s_htim2.Init = timInit;
    s_htim2.Instance = TIM2;
    s_htim2.Channel = HAL_TIM_ACTIVE_CHANNEL_1;

    __HAL_RCC_TIM2_CLK_ENABLE();
    HAL_NVIC_SetPriority(TIM2_IRQn, 3, 0);
    HAL_NVIC_EnableIRQ(TIM2_IRQn);

    status = HAL_TIM_Base_Init(&s_htim2);
    assert_param(status == HAL_OK);

    status = HAL_TIM_Base_Start_IT(&s_htim2);
    assert_param(status == HAL_OK);
}

int main()
{
    HAL_Init();
    SystemClock_Config();
    GPIO_Config();
    DMA_Config();
    SPI_Config();
    TIM_Config();

    ExampleInit();

    DisplayConfig config = 
    {
        0, 0, // row/col start
        &s_hspi2, // hspi
        &s_hdma15, // hdma
    };

    Dummy_Canvas canvas(config);

    while(true)
    {
        ExampleTick(canvas, canvas.display);
    }

    return 0;
}

#ifdef USE_FULL_ASSERT
extern "C" void assert_failed(uint8_t* file, uint32_t line)
{
    char error[64]; 
    const char* lastSeparator = (const char*)file;
    while(*file != '\0')
    {
        if(*file == '\\' || *file == '/')
            lastSeparator = (const char*)file + 1;
        file++;
    }

    sprintf(error, "Assertion Failed:\n  %s:%i", lastSeparator, line);

    DisplayConfig config = 
    {
        0, 0, // row/col start
        &s_hspi2, // hspi
        nullptr, // hdma
    };

    Dummy_Canvas canvas(config);
    canvas.display.begin();
    canvas.setColors(COLOR_RED, COLOR_BLACK);
    canvas.drawFilledBox(0, 0, 128, 128);
    canvas.setColors(COLOR_WHITE, COLOR_RED);
    canvas.setFont(&Picopixel);
    canvas.drawText(0, 0, error);
    canvas.display.end();
    while(true);
}
#endif

#endif

