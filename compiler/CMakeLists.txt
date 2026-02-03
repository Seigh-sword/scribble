cmake_minimum_required(VERSION 3.13)
project(scribble_compiler LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Compiler sources
set(COMPILER_SOURCES
    compiler/src/main.cpp
    compiler/src/lexer.cpp
    compiler/src/parser.cpp
    compiler/src/codegen.cpp
)

# Include directories
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/compiler/include)

# Main compiler executable
add_executable(scribblec ${COMPILER_SOURCES})

# Install to bin/
set_target_properties(scribblec PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

# Copy example .scrib files to bin/
file(COPY examples/hello.scrib DESTINATION "${CMAKE_BINARY_DIR}/bin/examples")

# Enable testing
enable_testing()
add_test(NAME compiler_test COMMAND scribblec --help WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
