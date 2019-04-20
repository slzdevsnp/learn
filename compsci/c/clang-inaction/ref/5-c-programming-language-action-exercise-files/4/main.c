// start of main.c
#include "multiply.h"

#define LEVEL 2

int main()
{
    #if !defined(RUNFAST)
    SQUARE(9);
    #endif
}
// end of main.c
