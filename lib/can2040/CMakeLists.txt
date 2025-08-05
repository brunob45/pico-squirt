# Add a library to the project using the specified source files.
add_library(can2040 "")

# Add sources to a target.
target_sources(can2040 PRIVATE
    src/can2040.c
)

# Specify libraries to use when linking.
target_link_libraries(can2040
    hardware_pio
)

# Add include directories to a target.
target_include_directories(can2040 PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/src
)
