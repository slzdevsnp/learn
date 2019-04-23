#include <stdio.h>

int main()
{
    printf("pre %-10.2f post\n", 123.456);
    printf("pre %-10d post\n", 1234567);
    
    char * message = "Hello world, Goodbye cruel world";
    int size = 11;
    
    printf("%.*s\n", size, message);
}
















