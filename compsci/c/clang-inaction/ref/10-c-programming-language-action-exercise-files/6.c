#include <stdio.h>

int StringLength(char * string)
{
    int length = 0;
    
    while (*string++)
    {
        ++length;
    }
    
    return length;
}

int main()
{
    printf("%d\n", StringLength("Hello world"));
    printf("%d\n", StringLength(""));
    printf("%d\n", StringLength("Hi!"));
}
















