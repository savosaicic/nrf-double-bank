cmake_minimum_required(VERSION 3.20.0)

set(DTC_OVERLAY_FILE ${CMAKE_CURRENT_SOURCE_DIR}/bank1/boards/nrf9151dk_nrf9151_ns.overlay)

find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(bank1)

target_include_directories(app PRIVATE bank1/include)
target_sources(app PRIVATE
  bank1/src/main.c
  bank1/src/gnss.c
  bank1/src/temperature.c
  bank1/src/ecompass.c
  bank1/src/firmware_update.c
)
