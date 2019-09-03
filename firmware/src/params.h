#pragma once

#include "utils.h"

struct OperatorParams
{
    enum Enum
    {
        A,
        D,
        S,
        R,
        ATTN,
        WAVE,
        MULT,
        EN_SUS,
        EN_TRE,
        EN_VIB,

        MAX
    };

    OperatorParams()
        : a(7)
        , d(7)
        , s(7)
        , r(7)
        , attn(0)
        , mult(0)
        , wave(0)
        , en_sus(1)
        , en_tre(0)
        , en_vib(0)
    {}

    void adjustA(int val) { a = adjustClamp(a, val, 0, 15); }
    void adjustD(int val) { d = adjustClamp(d, val, 0, 15); }
    void adjustS(int val) { s = adjustClamp(s, val, 0, 15); }
    void adjustR(int val) { r = adjustClamp(r, val, 0, 15); }
    void adjustAttn(int val) { attn = adjustClamp(attn, val, 0, 63); }
    void adjustWave(int val) { wave = adjustWrap(wave, val, 0, 7); }
    void adjustMult(int val) { mult = adjustClamp(mult, val, 0, 11); }
    void adjustEnSus(int val) { en_sus = adjustWrap(en_sus, val, 0, 1); }
    void adjustEnTre(int val) { en_tre = adjustWrap(en_tre, val, 0, 1); }
    void adjustEnVib(int val) { en_vib = adjustWrap(en_vib, val, 0, 1); }

    uint32_t a : 4;
    uint32_t d : 4;
    uint32_t s : 4;
    uint32_t r : 4;
    uint32_t attn : 6;
    uint32_t mult : 4;
    uint32_t wave : 3;
    uint32_t en_sus : 1;
    uint32_t en_tre : 1;
    uint32_t en_vib : 1;
};

struct VoiceParams
{
    enum Enum
    {
        FREQ,
        CONN,
        FEEDBACK,
        CHANNELS,
    };

    VoiceParams()
        : conn(0)
        , feedback(0)
        , channels(0xf)
        , ops({})
    {}

    OperatorParams ops[4] = {};

    void adjustFreq(float val) { freq = adjustClamp(freq, val, 30.0f, 4000.0f); }
    void adjustConn(int val) { conn = adjustWrap(conn, val, 0, 5); }
    void adjustFeedback(int val) { feedback = adjustClamp(feedback, val, 0, 7); }

    uint16_t freq = 440;
    uint8_t conn : 4;
    uint8_t feedback : 4;
    uint8_t channels : 4;
    //
    uint8_t reserved : 4;
};

struct VoiceInfo
{
    VoiceInfo()
        : isUsed(false)
        , isLocked(false)
    {};
    
    char name[16] = { 'T', 'e', 's', 't', '\0' };
    uint32_t isUsed : 1;
    uint32_t isLocked : 1;
};

struct Params
{
    static const uint32_t MAGIC_ID = 0x1284fe04;
    static const uint8_t MAX_STORED_VOICES = 64;
    static const uint8_t MAX_MAPPED_VOICES = 6;

    uint32_t magicId = 0;
    uint32_t version = 0;

    VoiceParams storedVoiceParams[MAX_STORED_VOICES];
    VoiceInfo storedVoiceInfo[MAX_STORED_VOICES];

    VoiceParams mappedVoiceParams[MAX_MAPPED_VOICES];

    const VoiceParams* getStoredVoiceParams(int idx) const
    {
        if(idx < 0 || idx > MAX_STORED_VOICES)
            return nullptr;
        return &storedVoiceParams[idx];
    };

    const VoiceInfo* getStoredVoiceInfo(int idx) const
    {
        if(idx < 0 || idx > MAX_STORED_VOICES)
            return nullptr;
        return &storedVoiceInfo[idx];
    };

    VoiceParams* getMappedVoiceParams(int idx)
    {
        if(idx < 0 || idx > MAX_MAPPED_VOICES)
            return nullptr;
        return &mappedVoiceParams[idx];
    };
};

// Verify sizes.
static_assert(sizeof(OperatorParams) == 4, "OperatorParams must be 4b!");
static_assert(sizeof(VoiceParams) <= 24, "VoiceParams must be <= 24b!");
static_assert(sizeof(VoiceInfo) <= 32, "VoiceInfo must be <= 32b!");
static_assert(sizeof(Params) <= 4096, "Params must be <= 4096!");
