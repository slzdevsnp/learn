#include <stdio.h>

typedef struct
{
    int Integer;
    char Character;
} OneThingOrAnother;

int main()
{
    printf("int %d\n", (int) sizeof(int));
    printf("char %d\n", (int) sizeof(char));
    printf("aggregate %d\n", (int) sizeof(OneThingOrAnother));
}
