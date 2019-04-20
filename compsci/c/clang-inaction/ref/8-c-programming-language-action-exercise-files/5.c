#include <stdio.h>

int main()
{
    int count = 0;

    for (;;)
    {
        printf("count %d\n", count);
        
        count += 1;
        
        if (count == 10) break;
    }
}






