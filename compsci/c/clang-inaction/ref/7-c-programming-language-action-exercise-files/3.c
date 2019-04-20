#include <stdio.h>

typedef struct
{
    short first; // xx
    short third; // xx
    int second;  // xxxx
} Layout;

int main()
{
    printf("short %d\n", (int) sizeof(short));
    
    printf("int %d\n", (int) sizeof(int));
    
    printf("struct %d\n", (int) sizeof(Layout));
}
