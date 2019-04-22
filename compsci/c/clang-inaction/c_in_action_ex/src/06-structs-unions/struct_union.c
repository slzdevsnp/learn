#include "../util/ufuncs.h"

#include <stdio.h>



/*##############  structs #########*/
//structs, enums are made with  typedef


typedef struct {
    double X;
    double Y;
} Pixel; // Pixel is a new type name

typedef unsigned  char byte;

/* we can use previously defined types  in new types*/
typedef struct{
    byte Red;
    byte Green;
    byte Blue;
} RGBColor;

void print_pixel(Pixel p){
    printf("Pixel's X,Y coordinates: %.2f,%.2f\n", p.X, p.Y);
}
void print_color(RGBColor c){
    printf("Color's rgb triplet: %d:%d:%d\n", c.Red, c.Green, c.Blue);
}

void testMakeStruct(){
    Pixel p = { 10.0, 20.0};
    RGBColor cl = {255, 128, 0};
    print_pixel(p);
    print_color(cl);

    cl.Green =255;
    printf("after color.Blue update..");
    print_color(cl);
}

/*##############  enums #########*/

typedef struct{
    int Integer;
    char Character;
} IntOrChar;

typedef enum{
    theInteger,
    theCharacter
} WhichThing;

typedef enum{
    MON,TUE,WED,THU,FRI,SAT,SUN
} Weekday;


void testEnums(){

    IntOrChar var;
    var.Integer = 123;
    WhichThing kind  = theInteger;
    printf("var=%d type=%d (enum id)\n",var.Integer, kind);

    var.Character='V';
    kind = theCharacter;
    printf("var=%c type=%d (enum id)\n",var.Character, kind);

}

void testSwitch(){
    Weekday day;
    //day = TUE;
    day = THU;

    switch(day){
        case MON: printf("this is Monday"); break;
        case TUE: printf("we are glad to all Tuesdays");break;
        default: printf("we welcome all other days");break;
    }
}

int main(){
    print_header("Create structs");
    testMakeStruct();

    print_header("Create enums");
    testEnums();

    print_header("switch statement");
    testSwitch();
}
