#include <stdio.h>
#include <string.h>

int main()
{
    char * message = "Hello world";
    printf("size %d\n", (int) strlen(message));
    
    printf("Apples %d\n", strcmp(message, "Apples"));
    printf("Oranges %d\n", strcmp(message, "Oranges"));
    printf("Hello world %d\n", strcmp(message, "Hello world"));
}
















