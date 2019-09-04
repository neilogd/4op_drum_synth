#pragma once

#include "config.h"
#include "inputs.h"
#include "enum.h"
#include "params.h"

#include "commandlist.h"

enum class EnvelopeMode : uint8_t
{
    BARS,
    LINES,
};

enum class SelectFlags : uint32_t
{
    NONE            = 0x0000,
    ALL             = 0xffff,

    // Params.
    FREQ            = 0x0001,
    FEEDBACK        = 0x0002,
    CONN            = 0x0004,
    MULT            = 0x0008,
    ENV             = 0x0010,
    ATTN            = 0x0020,
    WAVE            = 0x0040,
  
    // Ops.
    OP1             = 0x1000,
    OP2             = 0x2000,
    OP3             = 0x4000,
    OP4             = 0x8000,
};

enum class Menu : uint32_t
{
    VOICE_LIBRARY,
    VOICE_SELECT,
    VOICE_EDIT,
    CONFIG,
};

static constexpr SelectFlags OperatorFlags[4] = 
{
    SelectFlags::OP1,
    SelectFlags::OP2,
    SelectFlags::OP3,
    SelectFlags::OP4,
};

DEFINE_ENUM_CLASS_FLAG_OPERATOR(SelectFlags, |);
DEFINE_ENUM_CLASS_FLAG_OPERATOR(SelectFlags, &);

class UI;
struct MenuState;
struct MenuItem;

using MenuItemProviderFn = int(UI::*)(const MenuState*, int, MenuItem*);
using MenuActionFn = MenuState*(UI::*)(MenuState*);
using MenuUpdateFn = void(UI::*)(MenuState*);
using MenuDrawScreenFn = void(UI::*)(CommandList&, const MenuState* state);
using MenuDrawItemFn = void(UI::*)(CommandList&, const MenuState* state, const MenuItem*);

struct MenuItem
{
    const char* itemText;
};

struct MenuScreen
{
    constexpr MenuScreen(const char* _titleText)
        : titleText(_titleText)
    {}

    template<typename ITEMS_TY>
    constexpr MenuScreen& setItems(bool _itemInTitle = false)
    {
        static_assert(ITEMS_TY::MAX == arraySize(ITEMS_TY::items));
        items = ITEMS_TY::items;
        numItems = ITEMS_TY::MAX;
        itemInTitle = _itemInTitle;
        return *this;
    }

    constexpr MenuScreen& setActionFn(MenuActionFn _onActionFn) { onActionFn = _onActionFn; return *this; }
    constexpr MenuScreen& setUpdateFn(MenuUpdateFn _onUpdateFn) { onUpdateFn = _onUpdateFn; return *this; }
    constexpr MenuScreen& setDrawScreenFn(MenuDrawScreenFn _onDrawScreenFn) { onDrawScreenFn = _onDrawScreenFn; return *this; }
    constexpr MenuScreen& setDrawItemFn(MenuDrawItemFn _onDrawItemFn) { onDrawItemFn = _onDrawItemFn; return *this; }
    constexpr MenuScreen& setItemProviderFn(MenuItemProviderFn _itemProviderFn) { itemProviderFn = _itemProviderFn; return *this; }

    const char* titleText = nullptr;
    const MenuItem* items = nullptr;
    int8_t numItems = 0;
    bool itemInTitle = false;

    MenuActionFn onActionFn = nullptr;
    MenuUpdateFn onUpdateFn = nullptr;
    MenuDrawScreenFn onDrawScreenFn = nullptr;
    MenuDrawItemFn onDrawItemFn = nullptr;
    MenuItemProviderFn itemProviderFn = nullptr;
};

struct MenuState
{
    constexpr MenuState(const MenuScreen& _menu)
        : menu(_menu)
    {}

    const MenuScreen& menu;
    int8_t selectedItem = 0;
    int8_t firstItem = 0;
};

class UI
{
public:
    UI(Inputs& inputs);

    void init();
    void update();

    void draw(CommandList& cmdList);
    void print(CommandList& cmdList, const char* msg);

    void error(CommandList& cmdList, const char* text, uint16_t color, int ms);

    void drawMenu(CommandList& cmdList, const MenuState& menuState);

public:
    // main
    MenuState* OnActionMenu_Main(MenuState* state);

    // options
    MenuState* OnActionMenu_Options(MenuState* state);
    void OnDrawMenu_Options(CommandList& cmdList, const MenuState* state, const MenuItem* item);

    // library
    int ItemProvider_Library(const MenuState* state, int idx, MenuItem* item);
    MenuState* OnActionMenu_Library(MenuState* state);

    // voice
    MenuState* OnActionMenu_Voice(MenuState* state);
    void OnUpdateMenu_Voice(MenuState* state);
    void OnDrawMenu_Voice(CommandList& cmdList, const MenuState* state);

    // operator
    MenuState* OnActionMenu_Operator(MenuState* state);
    void OnUpdateMenu_Operator(MenuState* state);
    void OnDrawMenu_Operator(CommandList& cmdList, const MenuState* state);

    MenuState* currMenuState_;

private:
    void drawIcon(CommandList& cmdList, int x, int y, int idx, uint16_t col);

    void drawVoice(CommandList& cmdList, int selVoiceIdx, int selOperatorIdx, const VoiceParams& voiceParams);
    void drawOperator(CommandList& cmdList, int x, int y, int opIdx, int selOperatorIdx, const OperatorParams& op);

    void drawADSR_Bars(CommandList& cmdList, int selOperatorIdx, int x, int y, const OperatorParams& op);
    void drawADSR_Lines(CommandList& cmdList, int selOperatorIdx, int x, int y, const OperatorParams& op);

    Inputs& inputs_;

    int encoderDeltaVals_[2];
    bool buttonVals_[2];
    bool prevButtonVals_[2];

    enum VoiceParam
    {
        CONN,
        FEEDBACK,
        FREQ,
    };

    bool isButtonPressed(int i) const { return buttonVals_[i] && !prevButtonVals_[i]; }
    bool isButtonReleased(int i) const { return buttonVals_[i] && !prevButtonVals_[i]; }

    VoiceParams voiceParams_;

    const GFXfont& fontTitle_;
    const GFXfont& fontDefault_;
};
