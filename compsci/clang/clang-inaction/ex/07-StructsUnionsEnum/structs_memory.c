#include <stdio.h>



typedef struct
{
    short first; // xx
    int second;  // xxxx
    short third; // xx

} Layout_unlayered;


typedef struct
{
    short first; // xx
    short third; // xx
    int second;  // xxxx
} Layout_layered;


int main(){


    //check the size of member variables and its struct
    printf("short %d\n", (int) sizeof(short));
    
    printf("int %d\n", (int) sizeof(int));
    
    printf("struct unlayered: %d\n", (int) sizeof(Layout_unlayered));
    printf("struct layered: %d\n", (int) sizeof(Layout_layered));

}