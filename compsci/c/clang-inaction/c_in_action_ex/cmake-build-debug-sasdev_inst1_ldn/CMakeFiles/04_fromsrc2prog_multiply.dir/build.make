# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.13

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/sz_metafused_com/cpp/c_in_action_ex

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/sz_metafused_com/cpp/c_in_action_ex/cmake-build-debug-sasdev_inst1_ldn

# Include any dependencies generated for this target.
include CMakeFiles/04_fromsrc2prog_multiply.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/04_fromsrc2prog_multiply.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/04_fromsrc2prog_multiply.dir/flags.make

CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/main.c.o: CMakeFiles/04_fromsrc2prog_multiply.dir/flags.make
CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/main.c.o: ../src/04_from_src2prog/main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/sz_metafused_com/cpp/c_in_action_ex/cmake-build-debug-sasdev_inst1_ldn/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/main.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/main.c.o   -c /home/sz_metafused_com/cpp/c_in_action_ex/src/04_from_src2prog/main.c

CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/main.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/sz_metafused_com/cpp/c_in_action_ex/src/04_from_src2prog/main.c > CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/main.c.i

CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/main.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/sz_metafused_com/cpp/c_in_action_ex/src/04_from_src2prog/main.c -o CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/main.c.s

CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/multiply.c.o: CMakeFiles/04_fromsrc2prog_multiply.dir/flags.make
CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/multiply.c.o: ../src/04_from_src2prog/multiply.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/sz_metafused_com/cpp/c_in_action_ex/cmake-build-debug-sasdev_inst1_ldn/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/multiply.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/multiply.c.o   -c /home/sz_metafused_com/cpp/c_in_action_ex/src/04_from_src2prog/multiply.c

CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/multiply.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/multiply.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/sz_metafused_com/cpp/c_in_action_ex/src/04_from_src2prog/multiply.c > CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/multiply.c.i

CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/multiply.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/multiply.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/sz_metafused_com/cpp/c_in_action_ex/src/04_from_src2prog/multiply.c -o CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/multiply.c.s

# Object files for target 04_fromsrc2prog_multiply
04_fromsrc2prog_multiply_OBJECTS = \
"CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/main.c.o" \
"CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/multiply.c.o"

# External object files for target 04_fromsrc2prog_multiply
04_fromsrc2prog_multiply_EXTERNAL_OBJECTS =

04_fromsrc2prog_multiply: CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/main.c.o
04_fromsrc2prog_multiply: CMakeFiles/04_fromsrc2prog_multiply.dir/src/04_from_src2prog/multiply.c.o
04_fromsrc2prog_multiply: CMakeFiles/04_fromsrc2prog_multiply.dir/build.make
04_fromsrc2prog_multiply: CMakeFiles/04_fromsrc2prog_multiply.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/sz_metafused_com/cpp/c_in_action_ex/cmake-build-debug-sasdev_inst1_ldn/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable 04_fromsrc2prog_multiply"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/04_fromsrc2prog_multiply.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/04_fromsrc2prog_multiply.dir/build: 04_fromsrc2prog_multiply

.PHONY : CMakeFiles/04_fromsrc2prog_multiply.dir/build

CMakeFiles/04_fromsrc2prog_multiply.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/04_fromsrc2prog_multiply.dir/cmake_clean.cmake
.PHONY : CMakeFiles/04_fromsrc2prog_multiply.dir/clean

CMakeFiles/04_fromsrc2prog_multiply.dir/depend:
	cd /home/sz_metafused_com/cpp/c_in_action_ex/cmake-build-debug-sasdev_inst1_ldn && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/sz_metafused_com/cpp/c_in_action_ex /home/sz_metafused_com/cpp/c_in_action_ex /home/sz_metafused_com/cpp/c_in_action_ex/cmake-build-debug-sasdev_inst1_ldn /home/sz_metafused_com/cpp/c_in_action_ex/cmake-build-debug-sasdev_inst1_ldn /home/sz_metafused_com/cpp/c_in_action_ex/cmake-build-debug-sasdev_inst1_ldn/CMakeFiles/04_fromsrc2prog_multiply.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/04_fromsrc2prog_multiply.dir/depend

