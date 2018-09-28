#!/bin/sh


rm  ./a.out
rm ./Sample
#produces a.out  with c99 language standard
gcc sample.c -Wall -std=c99 -Wextra -o Sample


