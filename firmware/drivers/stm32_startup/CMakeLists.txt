cmake_minimum_required(VERSION 3.12)

set (this_dir "${CMAKE_CURRENT_LIST_DIR}"  CACHE INTERNAL "")
set (this_binary_dir "${CMAKE_CURRENT_BINARY_DIR}"  CACHE INTERNAL "")

function (add_section section_name section_perms section_address section_size)
    list(APPEND sections "${section_name} (${section_perms}) : ORIGIN = ${section_address}, LENGTH = ${section_size}")
    set(sections "${sections}" PARENT_SCOPE)
endfunction()

function (set_ram_section_name)
    set (ram_section_name "${ARGV}" PARENT_SCOPE)
endfunction()

function (set_flash_section_name)
    set (flash_section_name "${ARGV}" PARENT_SCOPE)
endfunction()

function (generate_linker_file LINKER_FILE)
    string (REGEX REPLACE ";" "\n\t" expanded_sections "${sections}")
    configure_file("${this_dir}/stm32.ld.in" ${this_binary_dir}/stm32.ld @ONLY)
    SET(LINKER_FILE "${this_binary_dir}/stm32.ld" PARENT_SCOPE)
endfunction()

IF(${STM32_FAMILY} STREQUAL "F0")
    SET(STM32_SYSTEM_SOURCE "system_stm32f0xx.c")
    SET(STM32_STARTUP_SOURCE "startup_stm32f042x6.s")
ELSEIF(${STM32_FAMILY} STREQUAL "F1")
    SET(STM32_SYSTEM_SOURCE "system_stm32f1xx.c")
    SET(STM32_STARTUP_SOURCE "startup_stm32f103xb.s")
ELSEIF(${STM32_FAMILY} STREQUAL "F4")
    SET(STM32_SYSTEM_SOURCE "system_stm32f4xx.c")
    SET(STM32_STARTUP_SOURCE "")
ENDIF()

SET(SOURCE_FILES 
    "startup.cpp"
    "${ROOT_PATH}/drivers/CMSIS/Device/ST/STM32${STM32_FAMILY}xx/Source/Templates/${STM32_SYSTEM_SOURCE}"
    "${ROOT_PATH}/drivers/CMSIS/Device/ST/STM32${STM32_FAMILY}xx/Source/Templates/gcc/${STM32_STARTUP_SOURCE}"
)

ADD_LIBRARY(startup STATIC ${SOURCE_FILES})
TARGET_INCLUDE_DIRECTORIES(startup PUBLIC
    ${ROOT_PATH}/drivers/STM32${STM32_FAMILY}xx_HAL_Driver/Inc
    ${ROOT_PATH}/include
    ${ROOT_PATH}/drivers/CMSIS/Device/ST/STM32${STM32_FAMILY}xx/Include
    ${ROOT_PATH}/drivers/CMSIS/Include
)
