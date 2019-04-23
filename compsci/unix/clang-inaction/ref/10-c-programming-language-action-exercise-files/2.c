#include <stdio.h>

int main()
{
    int i = 1234;
    
    int * p = 0;
    
    p = &i;
    
    int j = *p;
    
    *p = 2345;
    
    printf("i = %d j = %d\n", i, j);
}
















