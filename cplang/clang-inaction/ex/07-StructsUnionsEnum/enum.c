 #include <stdio.h>

typedef struct
{
    int Integer;
    char Character;
} OneThingOrAnother;

typedef enum 
{
    TheInteger,
    TheCharacter
} WhichThing;  //enum is a type

int main()
{
    OneThingOrAnother var;
    
    var.Integer = 123;
    WhichThing type = TheInteger;
    
    printf("var=%d  type=%d (enum id)\n",
           var.Integer,
           type);
    
    var.Character = 'V';
    type = TheCharacter;

    printf("var=%c type=%d (enum id)\n",
           var.Character,
           type);

    switch (type) {
        case TheInteger:  printf("type is TheInteger\n"); break;
        case TheCharacter: printf("type is the Character\n");  break;  //expected
        default:  printf("type is undefined\n");break;
    } 

}
