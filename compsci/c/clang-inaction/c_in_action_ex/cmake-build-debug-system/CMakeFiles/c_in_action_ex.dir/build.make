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
CMAKE_SOURCE_DIR = /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/c/clang-inaction/c_in_action_ex

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/c/clang-inaction/c_in_action_ex/cmake-build-debug-system

# Include any dependencies generated for this target.
include CMakeFiles/c_in_action_ex.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/c_in_action_ex.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/c_in_action_ex.dir/flags.make

CMakeFiles/c_in_action_ex.dir/src/main.c.o: CMakeFiles/c_in_action_ex.dir/flags.make
CMakeFiles/c_in_action_ex.dir/src/main.c.o: ../src/main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/c/clang-inaction/c_in_action_ex/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/c_in_action_ex.dir/src/main.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/c_in_action_ex.dir/src/main.c.o   -c /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/c/clang-inaction/c_in_action_ex/src/main.c

CMakeFiles/c_in_action_ex.dir/src/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/c_in_action_ex.dir/src/main.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/c/clang-inaction/c_in_action_ex/src/main.c > CMakeFiles/c_in_action_ex.dir/src/main.c.i

CMakeFiles/c_in_action_ex.dir/src/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/c_in_action_ex.dir/src/main.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/c/clang-inaction/c_in_action_ex/src/main.c -o CMakeFiles/c_in_action_ex.dir/src/main.c.s

# Object files for target c_in_action_ex
c_in_action_ex_OBJECTS = \
"CMakeFiles/c_in_action_ex.dir/src/main.c.o"

# External object files for target c_in_action_ex
c_in_action_ex_EXTERNAL_OBJECTS =

c_in_action_ex: CMakeFiles/c_in_action_ex.dir/src/main.c.o
c_in_action_ex: CMakeFiles/c_in_action_ex.dir/build.make
c_in_action_ex: CMakeFiles/c_in_action_ex.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/c/clang-inaction/c_in_action_ex/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable c_in_action_ex"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/c_in_action_ex.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/c_in_action_ex.dir/build: c_in_action_ex

.PHONY : CMakeFiles/c_in_action_ex.dir/build

CMakeFiles/c_in_action_ex.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/c_in_action_ex.dir/cmake_clean.cmake
.PHONY : CMakeFiles/c_in_action_ex.dir/clean

CMakeFiles/c_in_action_ex.dir/depend:
	cd /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/c/clang-inaction/c_in_action_ex/cmake-build-debug-system && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/c/clang-inaction/c_in_action_ex /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/c/clang-inaction/c_in_action_ex /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/c/clang-inaction/c_in_action_ex/cmake-build-debug-system /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/c/clang-inaction/c_in_action_ex/cmake-build-debug-system /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/c/clang-inaction/c_in_action_ex/cmake-build-debug-system/CMakeFiles/c_in_action_ex.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/c_in_action_ex.dir/depend

