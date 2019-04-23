#!/bin/sh

outfname=main
if [ -f $outfname ]
	then
	rm $outfname
fi
	
gcc multiply.c  main.c -Wall -std=c99 -Wextra -o $outfname
