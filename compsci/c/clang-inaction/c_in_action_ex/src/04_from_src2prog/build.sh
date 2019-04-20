#!/bin/sh

outfname=04_fromsrc2prog_multiply

if [ -f $outfname ]
	then
	rm $outfname
fi

echo "creating object files"
gcc  -Wall  -c multiply.c -std=c99 -Wextra
gcc  -Wall  -c main.c -std=c99 -Wextra

echo "linking"
gcc -o ${outfname} multiply.o  main.o