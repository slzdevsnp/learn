#include <stdio.h>

int main()
{
    int numbers[3] = { 101, 202, 303 };
    int size = sizeof(numbers) / sizeof(numbers[0]);
    
    int * p = numbers;
    int * end = p + size;
    
    for (; p != end; ++p)
    {
        printf("%d\n", *p);
    }
}
















