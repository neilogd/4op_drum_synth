ENTRY(ResetHandler)

MEMORY
{
    flash (rx) : ORIGIN = 0x08000000, LENGTH = 64K
	ram (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
}

/*
.output_section_name : {filename(.input_section_name)}
*/

_estack = ORIGIN(ram) + LENGTH(ram);
	

SECTIONS
{
    .StackPointer : {
        KEEP(*(.StackPointer));
    }> flash
    
    .VectorTable : {
        KEEP(*(.VectorTable));
    } > flash



    .text :
    {
        *(.text)
        *(.rodata)
        KEEP(*(.init))
        KEEP(*(.fini))
        _etext = .;
    } >  flash 

    .ARM.extab : /* exception unwsinding information */
    {
        *(.ARM.extab*)
    } >flash
    .ARM.exidx : /* index entries for section unwinding */
    {
        __exidx_start = .;
        *(.ARM.exidx*)
        __exidx_end = .;
    } >flash

    /*//global object initialization functions*/
    .preinit_array :
    {
        PROVIDE_HIDDEN(__preinit_array_start = .);
        KEEP(*(.preinit_array*))
        PROVIDE_HIDDEN(__preinit_array_end = .);
    } >flash
    .init_array :
    {
        PROVIDE_HIDDEN(__init_array_start = .);
        KEEP(*(SORT(.init_array.*)))
        KEEP(*(.init_array*))
        PROVIDE_HIDDEN(__init_array_end = .);
    } >flash
    .fini_array :
    {
        PROVIDE_HIDDEN(__fini_array_start = .);
        KEEP(*(SORT(.fini_array.*)))
        KEEP(*(.fini_array*))
        PROVIDE_HIDDEN(__fini_array_end = .);
    } >flash

    StartInitializedDataInFlash = .;
/* this address points to the initialized data in Flash */
    .data : 
    {
        /* this symbol points to the ram as it is inside > sram */
        StartInitializedDataInRam = .;
        *(.data*)
        EndInitializedDataInRam = .;
    } > ram AT > flash

    .bss : {
        StartUninitializedData = .;
        __bss_start__ = .;
        *(.bss)
        EndUninitializedData = .;
        __bss_end__ = .;
        } > ram
        end = .;
        __end__ = .;
}


/*//ram = VMA
//rom  = LMA
//when we are using the section names in our startup
//we need to get the address of the variables   
*/


/*
    High Address
/-----------------------------------------------\
stack (grows downwards) 
/-----------------------------------------------\




/-----------------------------------------------\
heap (grows upwards)
/-----------------------------------------------\
bss (uninitialized data, zeroed by ResetHandler)
/-----------------------------------------------\
data (initialized data, copied to ram by ResetHandler) LMA
/-----------------------------------------------\
text (program code)
interrupt vectors

/-----------------------------------------------\
    Low Address
*/
