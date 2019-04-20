#include <stdio.h>

typedef struct
{
    int Integer;
    char Character;
} OneThingOrAnother;

typedef enum 
{
    TheInteger = 10,
    TheCharacter = 20
} WhichThing;

int main()
{
    OneThingOrAnother var;
    
    var.Integer = 123;
    WhichThing type = TheInteger;
    
    printf("var=%d type=%d\n",
           var.Integer,
           type);
    
    var.Character = 'V';
    type = TheCharacter;

    printf("var=%c type=%d\n",
           var.Character,
           type);
}






