cmake_minimum_required(VERSION 3.13)
project(c_in_action_ex C)

set(CMAKE_C_STANDARD 99)


add_executable(02_strat_w_gcc_sample src/02_getting_started_w_gcc/sample.c)

add_executable(03_tour_temp_w_func  src/03_tour_of_clang/temperature_w_func.c )


add_executable(04_fromsrc2prog_multiply  src/04_from_src2prog/main.c  src/04_from_src2prog/multiply.c )