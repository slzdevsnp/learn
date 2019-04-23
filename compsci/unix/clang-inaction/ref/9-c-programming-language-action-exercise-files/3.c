#include <stdio.h>

int main()
{
    int eggs = 12;
    
    int before = eggs++;
    int after = ++eggs;
    
    printf("before=%d after=%d\n", before, after);
}






