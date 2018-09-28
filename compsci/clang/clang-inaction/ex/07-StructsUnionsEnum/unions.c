#include <stdio.h>

typedef union
{
    int Integer;
    char Character;
} OneThingOrAnother;


typedef struct
{
    int Integer;
    char Character;
} OneThingOrAnotherBis;  // same as union before



int main()
{
    printf("int %d\n", (int) sizeof(int));
    printf("char %d\n", (int) sizeof(char));
    printf("aggregate union %d\n", (int) sizeof(OneThingOrAnother));
    printf("aggregate struct %d\n", (int) sizeof(OneThingOrAnotherBis));
}
