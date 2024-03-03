cmake_minimum_required(VERSION 3.8)

project(Compiler)

find_package(FLEX REQUIRED)

flex_target(lexer lexer.l ${CMAKE_CURRENT_BINARY_DIR}/lexer.cc)

add_executable(stasyan main.cpp ${FLEX_lexer_OUTPUTS})

target_compile_features(stasyan PRIVATE cxx_std_20)

target_include_directories(stasyan PRIVATE ${CMAKE_CURRENT_BINARY_DIR})

target_include_directories(stasyan PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})