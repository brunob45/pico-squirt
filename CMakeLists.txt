# Generated Cmake Pico project file

cmake_minimum_required(VERSION 3.13)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Initialise pico_sdk from installed location
# (note this can come from environment, CMake cache etc)

# == DO NOT EDIT THE FOLLOWING LINES for the Raspberry Pi Pico VS Code Extension to work ==
if(WIN32)
    set(USERHOME $ENV{USERPROFILE})
else()
    set(USERHOME $ENV{HOME})
endif()
set(sdkVersion 2.2.0)
set(toolchainVersion 14_2_Rel1)
set(picotoolVersion 2.2.0)
set(picoVscode ${USERHOME}/.pico-sdk/cmake/pico-vscode.cmake)
if (EXISTS ${picoVscode})
    include(${picoVscode})
endif()
# ====================================================================================
set(PICO_BOARD pico2 CACHE STRING "Board type")

# Pull in Raspberry Pi Pico SDK (must be before project)
include(pico_sdk_import.cmake)

project(pico-squirt C CXX ASM)

# Initialise the Raspberry Pi Pico SDK
pico_sdk_init()

# Add executable. Default name is the project name, version 0.1

add_executable(pico-squirt
    src/avr.cpp
    src/canbus.cpp
    src/decoder.cpp
    src/flash.cpp
    src/main.cpp
    src/simulation.cpp
    src/adc_conv.cpp
    src/serial.cpp
)

pico_set_program_name(pico-squirt "pico-squirt")
pico_set_program_version(pico-squirt "0.1")

# Generate PIO header
# pico_generate_pio_header(pico-squirt
#     ${CMAKE_CURRENT_LIST_DIR}/pio/blink.pio
# )

# Modify the below lines to enable/disable output over UART/USB
pico_enable_stdio_uart(pico-squirt 0)
pico_enable_stdio_usb(pico-squirt 1)

# Add the standard library to the build
target_link_libraries(pico-squirt
    pico_stdlib
)

# Add the standard include files to the build
target_include_directories(pico-squirt PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/include
)

add_subdirectory(lib/can2040)
add_subdirectory(lib/libdivide)

# Add any user requested libraries
target_link_libraries(pico-squirt 
    # hardware_pio
    pico_multicore
    hardware_interp
    hardware_timer
    hardware_watchdog
    hardware_spi
    hardware_adc
    can2040
    libdivide
)

pico_add_extra_outputs(pico-squirt)

# Select a 200Mhz clock - or use PICO_USE_FASTEST_SUPPORTED_CLOCK=1
# add_compile_definitions(SYS_CLK_MHZ=200)
add_compile_definitions(PICO_USE_FASTEST_SUPPORTED_CLOCK=1)
