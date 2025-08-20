cmake_minimum_required(VERSION 3.13)

# Add a library to the project using the specified source files.
add_library(uart_bridge "")

# Add sources to a target.
target_sources(uart_bridge PRIVATE
    uart-bridge.c
    usb-descriptors.c
)

# Specify libraries to use when linking.
target_link_libraries(uart_bridge
    hardware_flash
    pico_multicore
    pico_stdlib
    tinyusb_device
)

# Add include directories to a target.
target_include_directories(uart_bridge PUBLIC
    ./
    pico-sdk/lib/tinyusb/src
)
