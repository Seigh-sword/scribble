cmake_minimum_required(VERSION 3.13)
project(scribble VERSION 2.0.0 LANGUAGES C CXX ASM)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Build shared libraries (DLLs on Windows, .so on Linux)
option(BUILD_SHARED_LIBS "Build shared libraries" OFF)

# Runtime example (mixed C/C++/asm)
add_executable(scribble_example
    src/main.cpp
    src/hello.c
    src/asm_helper.S
)

target_include_directories(scribble_example PRIVATE src)
set_target_properties(scribble_example PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

# Compiler (scribblec)
include(${CMAKE_CURRENT_SOURCE_DIR}/compiler/CMakeLists.txt)
