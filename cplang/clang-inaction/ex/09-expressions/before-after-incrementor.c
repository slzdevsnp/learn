#include <stdio.h>

int main()
{
    int eggs = 12;
    
    int before = eggs++;  //post  before copies the value of eggs before increment

    printf("before=%d and eggs=%d\n", before, eggs);


    int after = ++eggs; //pre   after takes a a value  of eggs after the increment
    
    printf("after=%d and eggs=%d\n", after,eggs);
}

