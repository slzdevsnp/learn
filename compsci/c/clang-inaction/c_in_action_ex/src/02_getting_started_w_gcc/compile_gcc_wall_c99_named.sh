#!/bin/sh

if [ -f Sample ]
 then
    rm Sample
fi

#compilation line
gcc sample.c -Wall -std=c99 -Wextra -o Sample

if [ -f Sample ]
 then
    echo compiled to an executable Sample ..
fi