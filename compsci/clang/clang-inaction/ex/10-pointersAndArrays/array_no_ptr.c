#include <stdio.h>

int main()
{
    int numbers[4] = { 101, 202, 303 };

    int size = sizeof(numbers) / sizeof(numbers[0]); // this is how size of array can be determined
    
    for (int i = 0; i < size; ++i)
    {
        printf("%d\n", numbers[i]);
    }
}
