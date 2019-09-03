#define NULL 0

static void ClearUninitializedVariables()
{
    extern void* StartUninitializedData;
    extern void* EndUninitializedData;
    for (void** ClearPtr = &StartUninitializedData; ClearPtr < &EndUninitializedData; ClearPtr++)
    {
        *ClearPtr = 0;
    }
}

static void InitializeDataSection()
{
    extern void* StartInitializedDataInRam;
    extern void* EndInitializedDataInRam;
    extern void* StartInitializedDataInFlash;
	void** FlashDataPointer= &StartInitializedDataInFlash;
    for ( void** RamDataPointer = &StartInitializedDataInRam ; 
        RamDataPointer< &EndInitializedDataInRam; 
        FlashDataPointer++,RamDataPointer++)
        {
            *RamDataPointer = *FlashDataPointer;
        }
}

static void InitializeGlobalObjects()
{
    // Start and end points of the constructor list,
    // defined by the linker script.
    extern void (*__init_array_start)();
    extern void (*__init_array_end)();

    // Call each function in the list.
    // We have to take the address of the symbols, as __init_array_start *is*
    // the first function pointer, not the address of it.
    for (void (**p)() = &__init_array_start; p < &__init_array_end; ++p) {
        (*p)();
    }
}

extern "C"
{
    extern int main();
    void __libc_init_array();
    extern void SystemInit();

    void ResetHandler()
    {
        
        ClearUninitializedVariables();
        InitializeDataSection();

        SystemInit();
        __libc_init_array();
        (void)main();

        for (;;) ;
        //__libc_fini_array();
    }
}
