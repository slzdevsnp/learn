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
include CMakeFiles/09_pointer_arrays.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/09_pointer_arrays.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/09_pointer_arrays.dir/flags.make

CMakeFiles/09_pointer_arrays.dir/src/09_pointerarrays/pointer_arrays.c.o: CMakeFiles/09_pointer_arrays.dir/flags.make
CMakeFiles/09_pointer_arrays.dir/src/09_pointerarrays/pointer_arrays.c.o: ../src/09_pointerarrays/pointer_arrays.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/09_pointer_arrays.dir/src/09_pointerarrays/pointer_arrays.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/09_pointer_arrays.dir/src/09_pointerarrays/pointer_arrays.c.o   -c /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/src/09_pointerarrays/pointer_arrays.c

CMakeFiles/09_pointer_arrays.dir/src/09_pointerarrays/pointer_arrays.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/09_pointer_arrays.dir/src/09_pointerarrays/pointer_arrays.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/src/09_pointerarrays/pointer_arrays.c > CMakeFiles/09_pointer_arrays.dir/src/09_pointerarrays/pointer_arrays.c.i

CMakeFiles/09_pointer_arrays.dir/src/09_pointerarrays/pointer_arrays.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/09_pointer_arrays.dir/src/09_pointerarrays/pointer_arrays.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/src/09_pointerarrays/pointer_arrays.c -o CMakeFiles/09_pointer_arrays.dir/src/09_pointerarrays/pointer_arrays.c.s

CMakeFiles/09_pointer_arrays.dir/src/util/ufuncs.c.o: CMakeFiles/09_pointer_arrays.dir/flags.make
CMakeFiles/09_pointer_arrays.dir/src/util/ufuncs.c.o: ../src/util/ufuncs.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/09_pointer_arrays.dir/src/util/ufuncs.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/09_pointer_arrays.dir/src/util/ufuncs.c.o   -c /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/src/util/ufuncs.c

CMakeFiles/09_pointer_arrays.dir/src/util/ufuncs.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/09_pointer_arrays.dir/src/util/ufuncs.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/src/util/ufuncs.c > CMakeFiles/09_pointer_arrays.dir/src/util/ufuncs.c.i

CMakeFiles/09_pointer_arrays.dir/src/util/ufuncs.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/09_pointer_arrays.dir/src/util/ufuncs.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/src/util/ufuncs.c -o CMakeFiles/09_pointer_arrays.dir/src/util/ufuncs.c.s

# Object files for target 09_pointer_arrays
09_pointer_arrays_OBJECTS = \
"CMakeFiles/09_pointer_arrays.dir/src/09_pointerarrays/pointer_arrays.c.o" \
"CMakeFiles/09_pointer_arrays.dir/src/util/ufuncs.c.o"

# External object files for target 09_pointer_arrays
09_pointer_arrays_EXTERNAL_OBJECTS =

09_pointer_arrays: CMakeFiles/09_pointer_arrays.dir/src/09_pointerarrays/pointer_arrays.c.o
09_pointer_arrays: CMakeFiles/09_pointer_arrays.dir/src/util/ufuncs.c.o
09_pointer_arrays: CMakeFiles/09_pointer_arrays.dir/build.make
09_pointer_arrays: CMakeFiles/09_pointer_arrays.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable 09_pointer_arrays"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/09_pointer_arrays.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/09_pointer_arrays.dir/build: 09_pointer_arrays

.PHONY : CMakeFiles/09_pointer_arrays.dir/build

CMakeFiles/09_pointer_arrays.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/09_pointer_arrays.dir/cmake_clean.cmake
.PHONY : CMakeFiles/09_pointer_arrays.dir/clean

CMakeFiles/09_pointer_arrays.dir/depend:
	cd /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/cmake-build-debug /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/cmake-build-debug /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/clang-inaction/c_in_action_ex/cmake-build-debug/CMakeFiles/09_pointer_arrays.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/09_pointer_arrays.dir/depend

