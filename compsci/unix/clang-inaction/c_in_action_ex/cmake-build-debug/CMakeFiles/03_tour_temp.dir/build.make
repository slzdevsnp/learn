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
CMAKE_COMMAND = /Applications/CLion2.app/Contents/bin/cmake/mac/bin/cmake

# The command to remove a file.
RM = /Applications/CLion2.app/Contents/bin/cmake/mac/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/03_tour_temp.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/03_tour_temp.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/03_tour_temp.dir/flags.make

CMakeFiles/03_tour_temp.dir/src/03_tour_of_clang/temperature_w_func.c.o: CMakeFiles/03_tour_temp.dir/flags.make
CMakeFiles/03_tour_temp.dir/src/03_tour_of_clang/temperature_w_func.c.o: ../src/03_tour_of_clang/temperature_w_func.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/03_tour_temp.dir/src/03_tour_of_clang/temperature_w_func.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/03_tour_temp.dir/src/03_tour_of_clang/temperature_w_func.c.o   -c /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/src/03_tour_of_clang/temperature_w_func.c

CMakeFiles/03_tour_temp.dir/src/03_tour_of_clang/temperature_w_func.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/03_tour_temp.dir/src/03_tour_of_clang/temperature_w_func.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/src/03_tour_of_clang/temperature_w_func.c > CMakeFiles/03_tour_temp.dir/src/03_tour_of_clang/temperature_w_func.c.i

CMakeFiles/03_tour_temp.dir/src/03_tour_of_clang/temperature_w_func.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/03_tour_temp.dir/src/03_tour_of_clang/temperature_w_func.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/src/03_tour_of_clang/temperature_w_func.c -o CMakeFiles/03_tour_temp.dir/src/03_tour_of_clang/temperature_w_func.c.s

# Object files for target 03_tour_temp
03_tour_temp_OBJECTS = \
"CMakeFiles/03_tour_temp.dir/src/03_tour_of_clang/temperature_w_func.c.o"

# External object files for target 03_tour_temp
03_tour_temp_EXTERNAL_OBJECTS =

03_tour_temp: CMakeFiles/03_tour_temp.dir/src/03_tour_of_clang/temperature_w_func.c.o
03_tour_temp: CMakeFiles/03_tour_temp.dir/build.make
03_tour_temp: CMakeFiles/03_tour_temp.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable 03_tour_temp"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/03_tour_temp.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/03_tour_temp.dir/build: 03_tour_temp

.PHONY : CMakeFiles/03_tour_temp.dir/build

CMakeFiles/03_tour_temp.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/03_tour_temp.dir/cmake_clean.cmake
.PHONY : CMakeFiles/03_tour_temp.dir/clean

CMakeFiles/03_tour_temp.dir/depend:
	cd /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/cmake-build-debug /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/cmake-build-debug /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/cmake-build-debug/CMakeFiles/03_tour_temp.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/03_tour_temp.dir/depend

