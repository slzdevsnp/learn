#!/bin/sh

outfname=main
rm $outfname
gcc multiply.c  main.c -Wall -std=c99 -Wextra -o $outfname
