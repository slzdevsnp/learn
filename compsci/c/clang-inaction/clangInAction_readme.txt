author: Kenny Ker
title: The C programming Language in action 



chap 01-gettingStartedWithVcc

in VSS open developer command prompt 

	> cl /help

	>cd 02-gettingStartWithVcc
	> cl sample.c   # produces and obj file and and executable


chap 02-gettingStartedWithGcc

	cd c:\Mingw
	#to set paths
	>c:\mingw>set_distro_paths.bat
 
	g++ --version 
	gcc --version

	gcc sample.c -Wall -std=c99 -Wextra -o Sample


	NB! no unique and standard distribution of the gcc


chap 03-tourOfClang

     temperature.c
     temperature_functions.c

chap 04-fromSourceToPrograms
	build.sh  shows an explicit build of object files and their linking
	complink/build.bat  does the same on windows


chap 05-TypesAndDeclarations  OK
	scope.c  //shows  difference between local instance variable and a static variable

	basic_types.c  //shows basic data types, first use of typedef  and also print the size of different variables


chap 06-StructsUnionsEnum

    new:
    struct_union.c

   structs.c  //shows a definition of structs and how to modified their members
   structs_memory.c //shows  structs layering in memory and affecting the struct's size
   
   enum.c  //defines  the  first enum  and makes a switch statement


chap 07-statemetns
    new: loop_switch.c
	switch.c  // how to use switch  on a basic type. do not forget break;
	for_loop;  //anonymous for loop

chap 08-expressions
  new: conversion_incrementator.c 

  before-after-incrementors.c //shows  ++var and var++
  basic-converions.c //how the automatic conversion between numeric types happens

chap 09-pointersAndArrays
    it is key to understand pointers!! 
new : pointer_arrays.c 

    pointer-on-int  basic refrencing dereferencing a pointer
    array_no_ptr shows array without using pointer
    array_with_ptr shows array with pointers
    swap_with_ptr  swap func implementation with pointer parameters so the changes are persisted outside the func
chap 10-memoryManagement
    new mem_malloc.c
    memory from Stack (preallocated) 
    memory from Heap which you can allocate and deallocate
    this chapter is too smallg.  example show how to 
    grab memory from Heap and release it.
    and what are the pitfals to avoid reusing freed pointers.


chap 11-inputOutput
    new: io_examples.
    c io library is blazingly fast (faster than c++)
    basic examples for
    printf, sprintf, scanf, fprintf

chap 12-workingWithStrings
    new: string_ops.c
    copy, concatenation,escape chars,
    char classification, manipulation,
    numeric conversion, comparison


chap 13-fromCtoCpp
new: connection.cpp

class, members, public private, constructors, destructors, const

	
