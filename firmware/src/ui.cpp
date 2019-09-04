#include "ui.h"
#include "icons.h"
#include "printf.h"
#include "utils.h"

#define PROGMEM
#include "fonts/Picopixel.h"
#include "fonts/Org_01.h"

extern Params params;

static const int opOffX[] = { 4, 68, 4, 68 };
static const int opOffY[] = { 24, 24, 78, 78 };
static const char* ops[] = { "Op1 ", "Op2 ", "Op3 ", "Op4 " };
static const char* mult[] = { " /2", " x1", " x2", " x3", " x4", " x5", " x6", " x7", " x8", " x9", "x10", "x10", "x12", "x12", "x12" };

static char s_textBuffer[32];

static const int MAX_VISIBLE_ITEMS = 12;

inline constexpr uint16_t Color565From888(uint16_t r, uint16_t g, uint16_t b)
{
#if defined(PLATFORM_PC)
    return ((r >> 3) << 11) | ((g >> 2) << 5) | ((b >> 3));
#else
    uint16_t col = ((b >> 3) << 11) | ((g >> 2) << 5) | ((r >> 3));
    return (col << 8) | (col >> 8);
#endif
}

inline constexpr uint16_t ColorInvert(uint16_t c)
{
    return ~c;
}

#define COLOR_DEFAULT             Color565From888(255, 255, 255)
#define COLOR_LIGHT_GREY          Color565From888(64, 64, 64)
#define COLOR_DARK_GREY           Color565From888(32, 32, 32)
#define COLOR_BACKGROUND          Color565From888(0, 0, 0)
#define COLOR_TITLE               Color565From888(255, 255, 255)
#define COLOR_SELECTED            Color565From888(0, 255, 0)
#define COLOR_MIDI_IDLE           Color565From888(255, 255, 255)
#define COLOR_MIDI_ACTIVITY       Color565From888(255, 255, 255)

namespace
{
    struct ItemsMain
    {
        enum
        {
            BACK,
            OPTIONS,
            LIBRARY,
            MAX,
        };

        static constexpr const MenuItem items[MAX] = 
        {
            { "<-- Back" },
            { "Options" },
            { "Library" },
        };
    };

    struct ItemsOptions
    {
        enum
        {
            BACK,
            XOFFSET,
            YOFFSET,
            COLOR_SCHEME,
            MAX,
        };

        static constexpr const MenuItem items[MAX] = 
        {
            { "<-- Back" },
            { "Screen X Offset" },
            { "Screen Y Offset" },
            { "Color Scheme" },
        };
    };

    struct ItemsLibrary
    {
        enum
        {
            BACK,
            MAX,
        };

        static constexpr const MenuItem items[MAX] = 
        {
            { "<-- Back" },
        };
    };
    
    struct ItemsVoice
    {
        enum
        {
            CONN,
            FEEDBACK,
            FREQ,
            CHANNELS,
            OP0,
            OP1,
            OP2,
            OP3,
            MAX,
        };

        static constexpr const MenuItem items[MAX] = 
        {
            { "Connection" },
            { "Feedback" },
            { "Frequency" },
            { "Channels" },
            { "Op1" },
            { "Op2" },
            { "Op3" },
            { "Op4" },
        };
    };

    struct ItemsOperator
    {
        enum
        {
            A,
            D,
            S,
            R,
            ATTN,
            MULT,
            WAVE,
            MAX,
        };

        static constexpr const MenuItem items[MAX] = 
        {
            { "Attack" },
            { "Decay" },
            { "Sustain" },
            { "Release" },
            { "Attn." },
            { "Mult." },
            { "Wave" },
        };
    };

    struct Menus
    {
        enum
        {
            MAIN,
            OPTIONS,
            LIBRARY,
            VOICE,
            OP0,
            OP1,
            OP2,
            OP3,
            MAX,
        };

        static constexpr const MenuScreen screens[MAX] = 
        {
            MenuScreen( "Main Menu" )
                .setItems<ItemsMain>()
                .setActionFn(&UI::OnActionMenu_Main)
            ,

            MenuScreen( "Options" )
                .setItems<ItemsOptions>()
                .setActionFn(&UI::OnActionMenu_Options)
                .setDrawItemFn(&UI::OnDrawMenu_Options)
            ,

            MenuScreen( "Library" )
                .setItemProviderFn(&UI::ItemProvider_Library)
                .setActionFn(&UI::OnActionMenu_Library)
            ,

            MenuScreen( "Voice" )
                .setItems<ItemsVoice>(true)
                .setActionFn(&UI::OnActionMenu_Voice)
                .setUpdateFn(&UI::OnUpdateMenu_Voice)
                .setDrawScreenFn(&UI::OnDrawMenu_Voice)
            ,

            MenuScreen( "Voice -> Op1" )
                .setItems<ItemsOperator>(true)
                .setActionFn(&UI::OnActionMenu_Operator)
                .setUpdateFn(&UI::OnUpdateMenu_Operator)
                .setDrawScreenFn(&UI::OnDrawMenu_Operator)
            ,

            MenuScreen( "Voice -> Op2" )
                .setItems<ItemsOperator>(true)
                .setActionFn(&UI::OnActionMenu_Operator)
                .setUpdateFn(&UI::OnUpdateMenu_Operator)
                .setDrawScreenFn(&UI::OnDrawMenu_Operator)
            ,

            MenuScreen( "Voice -> Op3" )
                .setItems<ItemsOperator>(true)
                .setActionFn(&UI::OnActionMenu_Operator)
                .setUpdateFn(&UI::OnUpdateMenu_Operator)
                .setDrawScreenFn(&UI::OnDrawMenu_Operator)
            ,

            MenuScreen( "Voice -> Op4" )
                .setItems<ItemsOperator>(true)
                .setActionFn(&UI::OnActionMenu_Operator)
                .setUpdateFn(&UI::OnUpdateMenu_Operator)
                .setDrawScreenFn(&UI::OnDrawMenu_Operator)
            ,
        };

        static MenuState states[MAX];
    };

    // TODO: make automatic or something?
    MenuState Menus::states[MAX] = 
    {
        screens[0], 
        screens[1], 
        screens[2], 
        screens[3],
        screens[4],
        screens[5],
        screens[6],
        screens[7],
    };

} // end anonymous namespace

UI::UI(Inputs& inputs)
    : inputs_(inputs)
    , fontTitle_(Org_01)
    , fontDefault_(Picopixel)
{
}

void UI::init()
{
    currMenuState_ = &Menus::states[Menus::MAIN];
}

void UI::update()
{
    // Update inputs.
    for(int i = 0; i < 2; ++i)
    {
        prevButtonVals_[i] = buttonVals_[i];
        encoderDeltaVals_[i] = inputs_.getEncoderValue(i);
        buttonVals_[i] = inputs_.getEncoderButton(i);
    }

    int8_t& selectedIdx = currMenuState_->selectedItem;
    int8_t& firstIdx = currMenuState_->firstItem;
    const MenuScreen& menuScreen = currMenuState_->menu;
    const MenuItem& selectedItem = menuScreen.items[selectedIdx];

    int numItems = menuScreen.numItems;
    if(menuScreen.itemProviderFn)
        numItems = (this->*(menuScreen.itemProviderFn))(currMenuState_, 0, nullptr);

    selectedIdx += encoderDeltaVals_[0];
    if(selectedIdx < 0)
        selectedIdx = numItems - 1;
    if(selectedIdx >= numItems)
        selectedIdx = 0;

    int diff = (selectedIdx - firstIdx); 
    if(diff < 0)
        firstIdx--;
    else if(diff >= MAX_VISIBLE_ITEMS)
        firstIdx++;

    if(buttonVals_[0] && !prevButtonVals_[0])
    {
        if(menuScreen.onActionFn)
            currMenuState_ = (this->*(menuScreen.onActionFn))(currMenuState_);
    }

    if(menuScreen.onUpdateFn)
        (this->*(menuScreen.onUpdateFn))(currMenuState_);
}

void UI::draw(CommandList& cmdList)
{
    drawMenu(cmdList, *currMenuState_);
}

void UI::print(CommandList& cmdList, const char* msg)
{
    cmdList.setColors(COLOR_DEFAULT, COLOR_DEFAULT);
    cmdList.setFont(&fontDefault_);
    cmdList.drawText(0, 0, msg);
}

void UI::error(CommandList& cmdList, const char* text, uint16_t color, int ms)
{
    cmdList.setColors(color, color);
    cmdList.drawFilledBox(0, 0, 128, 128);

    cmdList.setColors(0xffff, 0xffff);
    cmdList.setFont(&fontDefault_);
    cmdList.drawText(0, 0, text);

    cmdList.setColors(COLOR_BACKGROUND, COLOR_BACKGROUND);
    cmdList.drawFilledBox(0, 0, 128, 128);
}

void UI::drawMenu(CommandList& cmdList, const MenuState& menuState)
{
    const int16_t TITLE_X = 4;
    const int16_t TITLE_Y = 0;
    const int16_t TITLE_SEPARATOR_Y = fontDefault_.yAdvance + 2;
    const int16_t ITEM_SPACING = fontDefault_.yAdvance + 2;
    const int16_t ITEM_X_BEGIN = 0;
    const int16_t ITEM_Y = fontDefault_.yAdvance + 4;

    cmdList.setCursor(0, 0);
    cmdList.setColors(0x0000, 0x0000);
    cmdList.drawFilledBox(0, 0, 128, 128);

    uint16_t col = COLOR_DEFAULT;

    cmdList.setFont(&fontTitle_);
    cmdList.setColors(COLOR_TITLE, COLOR_TITLE);
    cmdList.drawText(TITLE_X, TITLE_Y, menuState.menu.titleText);

    if(menuState.menu.itemInTitle)
    {
        int16_t titleWidth = fontTitle_.measureTextWidth(menuState.menu.titleText);
        cmdList.drawText(TITLE_X + titleWidth, TITLE_Y, " -> ");
        titleWidth += fontTitle_.measureTextWidth(" -> ");
                cmdList.drawText(TITLE_X + titleWidth, TITLE_Y, menuState.menu.items[menuState.selectedItem].itemText);
    }
    cmdList.drawHLine(0, TITLE_SEPARATOR_Y, 128);

    cmdList.setFont(&fontDefault_);

    if(menuState.menu.onDrawScreenFn)
        (this->*(menuState.menu.onDrawScreenFn))(cmdList, &menuState);

    int itemY = ITEM_Y;
    int firstItemIdx = 0;
    if(menuState.menu.items && !menuState.menu.itemInTitle || menuState.menu.itemProviderFn)
    {
        int numItems = menuState.menu.numItems;
        if(menuState.menu.itemProviderFn)
            numItems = (this->*(menuState.menu.itemProviderFn))(&menuState, 0, nullptr);
        MenuItem localItem;
        for(int i = 0; i < MAX_VISIBLE_ITEMS; ++i)
        {
            const int idx = i + menuState.firstItem;
            if(idx >= numItems)
                break;
            
            const bool isSelected = idx == menuState.selectedItem;
            const MenuItem* item = &localItem;
            if(menuState.menu.items)
                item = &menuState.menu.items[idx];
            else if(menuState.menu.itemProviderFn)
                (this->*(menuState.menu.itemProviderFn))(&menuState, idx, &localItem);

            cmdList.setCursor(ITEM_X_BEGIN, itemY);
            if(isSelected)
            {
                cmdList.drawFilledBox(0, 0, 128, ITEM_SPACING);
                cmdList.setColors(ColorInvert(COLOR_TITLE), ColorInvert(COLOR_TITLE));
            }

            if(menuState.menu.onDrawItemFn)
                (this->*(menuState.menu.onDrawItemFn))(cmdList, &menuState, item);
            else
                cmdList.drawText(2, 0, item->itemText);
                
            if(isSelected)
            {
                cmdList.setColors(COLOR_TITLE, COLOR_TITLE);
            }
            itemY += ITEM_SPACING;
        }
        if(numItems > (menuState.firstItem + MAX_VISIBLE_ITEMS))
        {
            cmdList.setCursor(ITEM_X_BEGIN, itemY);
            cmdList.drawText(2, 0, "...");
        }
    }
}

MenuState* UI::OnActionMenu_Main(MenuState* state)
{
    switch(state->selectedItem)
    {
    case ItemsMain::BACK:
        return &Menus::states[Menus::VOICE];

    case ItemsMain::OPTIONS:
        return &Menus::states[Menus::OPTIONS];

    case ItemsMain::LIBRARY:
        return &Menus::states[Menus::LIBRARY];
    }
    return state;
}

MenuState* UI::OnActionMenu_Options(MenuState* state)
{
    if(state->selectedItem == ItemsOptions::BACK)
    {
        return &Menus::states[Menus::MAIN];
    }    
    return state;
}

void UI::OnDrawMenu_Options(CommandList& cmdList, const MenuState* state, const MenuItem* item)
{
    cmdList.drawText(2, 0, item->itemText);
    if(item != &ItemsOptions::items[0])
    {
        const char* text = "<...>";
        const int16_t w = fontDefault_.measureTextWidth(text);
        cmdList.drawText(126 - w, 0, text);
    }
}

int UI::ItemProvider_Library(const MenuState* state, int idx, MenuItem* item)
{
    if(item)
    {
        if(idx == 0)
        {
            item->itemText = "<-- Back";
        }
        else
        {
            const int voiceIdx = idx - 1;
            if(const VoiceInfo* voiceInfo = params.getStoredVoiceInfo(voiceIdx))
            {
                item->itemText = voiceInfo->name;
            }
        }
    }
    return 1 + Params::MAX_STORED_VOICES;
}

MenuState* UI::OnActionMenu_Library(MenuState* state)
{
    if(state->selectedItem == ItemsLibrary::BACK)
    {
        return &Menus::states[Menus::MAIN];
    }    
    return state;
}

MenuState* UI::OnActionMenu_Voice(MenuState* state)
{
    switch(state->selectedItem)
    {
    case ItemsVoice::OP0:
        return &Menus::states[Menus::OP0];
    case ItemsVoice::OP1:
        return &Menus::states[Menus::OP1];
    case ItemsVoice::OP2:
        return &Menus::states[Menus::OP2];
    case ItemsVoice::OP3:
        return &Menus::states[Menus::OP3];
    }
    return &Menus::states[Menus::MAIN];
}

void UI::OnUpdateMenu_Voice(MenuState* state)
{
    auto& voiceParams = *params.getMappedVoiceParams(0);

    switch(state->selectedItem)
    {
    case ItemsVoice::CONN:
        voiceParams.adjustConn(encoderDeltaVals_[1]);        
        break;
    case ItemsVoice::FEEDBACK:
        voiceParams.adjustFeedback(encoderDeltaVals_[1]);
        break;
    case ItemsVoice::FREQ:
        voiceParams.adjustFreq(encoderDeltaVals_[1] * encoderDeltaVals_[1] * encoderDeltaVals_[1]);
        break;
    case ItemsVoice::CHANNELS:
        voiceParams.adjustChannels(encoderDeltaVals_[1] * encoderDeltaVals_[1] * encoderDeltaVals_[1]);
        break;
    }
}

void UI::OnDrawMenu_Voice(CommandList& cmdList, const MenuState* state)
{
    const auto& voiceParams = *params.getMappedVoiceParams(0);

    drawVoice(cmdList, Menus::states[Menus::VOICE].selectedItem, -1, voiceParams);
}


MenuState* UI::OnActionMenu_Operator(MenuState* state)
{
    return &Menus::states[Menus::VOICE];
}

void UI::OnUpdateMenu_Operator(MenuState* state)
{
    auto& voiceParams = *params.getMappedVoiceParams(0);
    auto& op = voiceParams.ops[Menus::states[Menus::VOICE].selectedItem - ItemsVoice::OP0];

    switch(state->selectedItem)
    {
    case ItemsOperator::A:
        op.adjustA(-encoderDeltaVals_[1]);
        break;
    case ItemsOperator::D:
        op.adjustD(-encoderDeltaVals_[1]);
        break;
    case ItemsOperator::S:
        op.adjustS(-encoderDeltaVals_[1]);
        break;
    case ItemsOperator::R:
        op.adjustR(-encoderDeltaVals_[1]);
        break;
    case ItemsOperator::MULT:
        op.adjustMult(encoderDeltaVals_[1]);
        break;
    case ItemsOperator::WAVE:
        op.adjustWave(encoderDeltaVals_[1]);
        break;
    case ItemsOperator::ATTN:
        op.adjustAttn(-encoderDeltaVals_[1]);
        break;
    }
}

void UI::OnDrawMenu_Operator(CommandList& cmdList, const MenuState* state)
{
    const auto& voiceParams = *params.getMappedVoiceParams(0);

    drawVoice(cmdList, Menus::states[Menus::VOICE].selectedItem, state->selectedItem, voiceParams);
}

void UI::drawIcon(CommandList& cmdList, int x, int y, int idx, uint16_t col)
{
    const uint8_t* data = &icons_data[32 * idx];
    cmdList.setColors(col, col);
    cmdList.drawBitmap(x, y, 16, 16, data);
}

void UI::drawVoice(CommandList& cmdList, int selVoiceIdx, int selOperatorIdx, const VoiceParams& voiceParams)
{
    uint16_t col = COLOR_DEFAULT;
    cmdList.setFont(&fontDefault_);

    col = (selVoiceIdx == ItemsVoice::CONN) ? COLOR_SELECTED : COLOR_DEFAULT;
    drawIcon(cmdList, 4, 9, voiceParams.conn, col);
 
    col = (selVoiceIdx == ItemsVoice::FEEDBACK) ? COLOR_SELECTED : COLOR_DEFAULT;
    drawIcon(cmdList, 34, 10, 14, col);
    sprintf(s_textBuffer, "%i", (int)voiceParams.feedback);
    cmdList.drawText(50, 11, s_textBuffer);

    col = (selVoiceIdx == ItemsVoice::FREQ) ? COLOR_SELECTED : COLOR_DEFAULT;
    sprintf(s_textBuffer, "%iHz", (int)voiceParams.freq);
    cmdList.setColors(col, col);
    cmdList.drawText(70, 11, s_textBuffer);

    col = (selVoiceIdx == ItemsVoice::CHANNELS) ? COLOR_SELECTED : COLOR_DEFAULT;
    cmdList.setColors(col, col);
    if(voiceParams.channels & 1)
        cmdList.drawText(104, 11, "A");
    if(voiceParams.channels & 2)
        cmdList.drawText(108, 11, "B");
    if(voiceParams.channels & 4)
        cmdList.drawText(112, 11, "C");
    if(voiceParams.channels & 8)
        cmdList.drawText(116, 11, "D");

    cmdList.setColors(COLOR_LIGHT_GREY, COLOR_LIGHT_GREY);
    cmdList.drawHLine(4, opOffY[2] - 4, 120);
    cmdList.drawHLine(4, opOffY[2] - 5, 120);
    cmdList.drawVLine(opOffX[1] - 4, 24, 128 - 28);
    cmdList.drawVLine(opOffX[1] - 5, 24, 128 - 28);

    for (int i = 0; i < 4; ++i) 
    {
        bool isOpSelected = i == (selVoiceIdx - ItemsVoice::OP0);
        if(isOpSelected)
        {
            cmdList.setColors(COLOR_SELECTED, COLOR_BACKGROUND);
            cmdList.drawBox(opOffX[i] - 2, opOffY[i] - 2, 60, 50);
        }
        drawOperator(cmdList, opOffX[i], opOffY[i], i, isOpSelected ? selOperatorIdx : -1, voiceParams.ops[i]);
    }

}

void UI::drawOperator(CommandList& cmdList, int x, int y, int opIdx, int selOperatorIdx, const OperatorParams& op)
{
    uint16_t col = COLOR_DEFAULT;

    drawADSR_Lines(cmdList, selOperatorIdx, x, y, op);

    y += 37;

    const float attn = op.attn * 0.75f;

    col = (selOperatorIdx == ItemsOperator::ATTN) ? COLOR_SELECTED : COLOR_DEFAULT;
    cmdList.setColors(col, col);
    sprintf(s_textBuffer, "-%idB", (int)attn); 
    cmdList.drawText(x, y, s_textBuffer);

    col = (selOperatorIdx == ItemsOperator::MULT) ? COLOR_SELECTED : COLOR_DEFAULT;

    cmdList.setColors(col, col);
    cmdList.drawText(x + 26, y, mult[op.mult]);

    col = (selOperatorIdx == ItemsOperator::WAVE) ? COLOR_SELECTED : COLOR_DEFAULT;
    drawIcon(cmdList, x + 40, y - 4, op.wave + 6, col);
}

void UI::drawADSR_Bars(CommandList& cmdList, int selOperatorIdx, int x, int y, const OperatorParams& op)
{
#if UI_INVERTED_ADSR 
    const int a = op.a < 15 ? (15 - op.a) * 2 : 1;
    const int d = op.d < 15 ? (15 - op.d) * 2 : 1;
    const int s = op.s < 15 ? (15 - op.s) * 2 : 1;
    const int r = op.r < 15 ? (15 - op.r) * 2 : 1;
#else
    const int a = op.a > 0 ? op.a * 2 : 1;
    const int d = op.d > 0 ? op.d * 2 : 1;
    const int s = op.s > 0 ? op.s * 2 : 1;
    const int r = op.r > 0 ? op.r * 2 : 1;
#endif

    selOperatorIdx == ItemsOperator::A ? cmdList.setColors(COLOR_SELECTED, COLOR_SELECTED) :  cmdList.setColors(COLOR_DEFAULT, COLOR_DEFAULT);
    cmdList.drawFilledBox(x + 0, y + 32 - a, 7, a);
    selOperatorIdx == ItemsOperator::D ? cmdList.setColors(COLOR_SELECTED, COLOR_SELECTED) :  cmdList.setColors(COLOR_DEFAULT, COLOR_DEFAULT);
    cmdList.drawFilledBox(x + 8, y + 32 - d, 7, d);
    selOperatorIdx == ItemsOperator::S ? cmdList.setColors(COLOR_SELECTED, COLOR_SELECTED) :  cmdList.setColors(COLOR_DEFAULT, COLOR_DEFAULT);
    cmdList.drawFilledBox(x + 16, y + 32 - s, 7, s);
    selOperatorIdx == ItemsOperator::R ? cmdList.setColors(COLOR_SELECTED, COLOR_SELECTED) :  cmdList.setColors(COLOR_DEFAULT, COLOR_DEFAULT);
    cmdList.drawFilledBox(x + 24, y + 32 - r, 7, r);
}
    
void UI::drawADSR_Lines(CommandList& cmdList, int selOperatorIdx, int x, int y, const OperatorParams& op)
{
    const int a = ((15 - op.a) + 1);
    const int d = ((15 - op.d) + 1);
    const int s = ((15 - op.s) * 2);
    const int r = ((15 - op.r) + 1);

    float susLen = 6.0f;
    float aStart = 0.0f;
    float dStart = aStart + a;
    float sStart = dStart + d;
    float sEnd = sStart + susLen;
    float rStart = sEnd + r;
    float invS = 31 - s;

    cmdList.setColors(COLOR_DARK_GREY, COLOR_DARK_GREY);
    for(int i = 0; i <= 56; i += 8)
    {
        cmdList.drawVLine(x + i, y, 32);
    }
    for(int i = 0; i <= 32; i += 8)
    {
        cmdList.drawHLine(x, y + i, 56);
    }

    cmdList.setColors(COLOR_LIGHT_GREY, COLOR_LIGHT_GREY);
    cmdList.drawLine(x, y + 28, x, y + 32);
    cmdList.drawLine(x, y + 28, x + sEnd, y + 28);
    cmdList.drawLine(x + sEnd, y + 28,  x + sEnd, y + 32);
    cmdList.drawLine(x + sEnd, y + 32,  x + rStart, y + 32);

    selOperatorIdx == ItemsOperator::A ? cmdList.setColors(COLOR_SELECTED, COLOR_SELECTED) :  cmdList.setColors(COLOR_DEFAULT, COLOR_DEFAULT);
    cmdList.drawLine(x + aStart, y + 32, x + dStart, y);
    selOperatorIdx == ItemsOperator::D ? cmdList.setColors(COLOR_SELECTED, COLOR_SELECTED) :  cmdList.setColors(COLOR_DEFAULT, COLOR_DEFAULT);
    cmdList.drawLine(x + dStart, y,            x + sStart, y + invS);
    selOperatorIdx == ItemsOperator::S ? cmdList.setColors(COLOR_SELECTED, COLOR_SELECTED) :  cmdList.setColors(COLOR_DEFAULT, COLOR_DEFAULT);
    cmdList.drawLine(x + sStart, y + invS,    x + sEnd, y + invS);
    selOperatorIdx == ItemsOperator::R ? cmdList.setColors(COLOR_SELECTED, COLOR_SELECTED) :  cmdList.setColors(COLOR_DEFAULT, COLOR_DEFAULT);
    cmdList.drawLine(x + sEnd,     y + invS,    x + rStart, y + 32);

    cmdList.setColors(COLOR_DEFAULT, COLOR_DEFAULT);
    cmdList.drawLine(x + rStart, y + 32, x + 54, y + 32);
}
