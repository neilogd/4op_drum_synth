# this one is important
SET(CMAKE_SYSTEM_NAME arm-bare)

# this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

SET(CMAKE_C_COMPILER arm-none-eabi-gcc CACHE STRING "C Compiler")
SET(CMAKE_CXX_COMPILER arm-none-eabi-g++ CACHE STRING "C++ Compiler")
SET(CMAKE_SIZE arm-none-eabi-size CACHE STIRNG "size")
SET(CMAKE_NM arm-none-eabi-nm CACHE STIRNG "nm")

SET(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
SET(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/Modules")

SET(COMMON_LINKER_FLAGS "--specs=nosys.specs --specs=nano.specs -Wl,--gc-sections -ffunction-sections -fdata-sections")

SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -ffreestanding -fno-non-call-exceptions")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ffreestanding -fno-non-call-exceptions -fno-use-cxa-atexit -fno-threadsafe-statics")

IF(DEFINED STM32_FAMILY)
    IF(${STM32_FAMILY} STREQUAL "F0")
        SET(CMAKE_EXE_LINKER_FLAGS_INIT "${COMMON_LINKER_FLAGS} -mthumb -mcpu=cortex-m0plus -march=armv6-m")
        ADD_COMPILE_OPTIONS(-mthumb -mcpu=cortex-m0plus -march=armv6-m -ggdb)

    ELSEIF(${STM32_FAMILY} STREQUAL "F1")
        SET(CMAKE_EXE_LINKER_FLAGS_INIT "${COMMON_LINKER_FLAGS} -mthumb -mcpu=cortex-m3 -march=armv7-m")
        ADD_COMPILE_OPTIONS(-mthumb -mcpu=cortex-m3 -march=armv7-m -ggdb)

    ELSEIF(${STM32_FAMILY} STREQUAL "F4")
        SET(CMAKE_EXE_LINKER_FLAGS_INIT "${COMMON_LINKER_FLAGS} -mthumb -mcpu=cortex-m4 -march=armv7-m")
        ADD_COMPILE_OPTIONS(-mthumb -mcpu=cortex-m4 -march=armv7-m -mfpu=fpv4-sp-d16 -mfloat-abi=hard -ggdb)
    ELSE()
        MESSAGE("STM32_FAMILY \"${STM32_FAMILY}\" unsupported!")
    ENDIF()
ENDIF()
