cmake_minimum_required(VERSION 3.13)
project(c_in_action_ex C)

set(CMAKE_C_STANDARD 99)


add_executable(02_sample  src/02_getting_started_w_gcc/sample.c)

add_executable(03_tour_temp  src/03_tour_of_clang/temperature_w_func.c )

add_executable(04_fromsrc2prog_multiply src/04_from_src2prog/main.c  src/04_from_src2prog/multiply.c )

add_executable(05_basic_types src/05_types_and_declare/basic_types.c)

add_executable(05_typedeclare_scope src/05_types_and_declare/scope.c  src/util/ufuncs.c )

add_executable(06_struct_union_test src/06-structs-unions/struct_union.c  src/util/ufuncs.c )

add_executable(07_loop_switch_test src/07_statements/loop_switch.c  src/util/ufuncs.c )

add_executable(08_convert_test src/08_expressions/conversion_incrementator.c  src/util/ufuncs.c )

add_executable(09_pointer_arrays src/09_pointerarrays/pointer_arrays.c  src/util/ufuncs.c )

add_executable(10_mem_malloc src/10_memorymgmt/mem_malloc.c  src/util/ufuncs.c )

add_executable(11_io src/11_input_output/io_examples.c  src/util/ufuncs.c )

add_executable(12_strings src/12_strings/string_ops.c src/util/ufuncs.c )

#add_executable(13_connection src/13_fromc_to_cpp/connection.cpp src/util/ufuncs.c ) build.sh in src/14_fromc_to_cpp
