author: Kenny Ker
title: The C programming Language in action 



chap 02-gettingStartedWithVcc

in VSS open developer command prompt 

	> cl /help

	>cd 02-gettingStartWithVcc
	> cl sample.c   # produces and obj file and and executable


chap 03-gettingStartedWithGcc

	cd c:\Mingw
	#to set paths
	>c:\mingw>set_distro_paths.bat
 
	g++ --version 
	gcc --version

	gcc sample.c -Wall -std=c99 -Wextra -o Sample


	NB! no unique and standard distribution of the gcc


chap 04-tourOfClang

     temperature.c
     temperature_functions.c

chap 05-fromSourceToPrograms
	complink/build.sh  shows an explicit build of object files and their linking
	complink/build.bat  does the same on windows


chap 06-TypesAndDeclarations
	scope.c  //shows  difference between local intance variable and a static variable

	basic_types.c  //shows basic data types, first use of typedef  and also print the size of different variables


chap 07-StructsUnionsEnum

   structs.c  //shows a definition of structs and how to modified their members
   structs_memory.c //shows  structs layering in memory and affecting the struct's size
   
   enum.c  //defines  the  first enum  and makes a switch statement


chap 08-statemetns
	switch.c  // how to use switch  on a basic type. do not forget break;
	for_loop;  //anonymous for loop

chap 09-expressions

  before-after-incrementors.c //shows  ++var and var++
  basic-converions.c //how the automatic conversion between numeric types happens

chap 10-pointersAndArrays



chap 11-memoryManagement

chap 12-inputOutput

chap 13-workingWithStrings

chap 14-fromCtoCpp

	
