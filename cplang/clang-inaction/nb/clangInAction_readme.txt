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


chap 05-fromSourceToPrograms
	complink/build.sh  shows an explicit build of object files and their linking
	complink/build.bat  does the same on windows
	
