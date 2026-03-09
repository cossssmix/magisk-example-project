cmake_minimum_required(VERSION 3.18)

project(zygisk_module)

set(CMAKE_SYSTEM_NAME Android)
set(CMAKE_SYSTEM_VERSION 21)
set(CMAKE_ANDROID_NDK $ENV{ANDROID_NDK_HOME})
set(CMAKE_TOOLCHAIN_FILE "${CMAKE_ANDROID_NDK}/build/cmake/android.toolchain.cmake")
set(CMAKE_ANDROID_ARCH_ABI x86_64)
set(CMAKE_ANDROID_STL_TYPE c++_static)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(
    ${CMAKE_SOURCE_DIR}/include
    $ENV{ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/${CMAKE_HOST_SYSTEM_NAME}-x86_64/sysroot/usr/include
)

add_library(zygisk_module SHARED src/main.cpp)

target_link_libraries(zygisk_module log)

set_target_properties(zygisk_module PROPERTIES PREFIX "" OUTPUT_NAME ${CMAKE_ANDROID_ARCH_ABI})