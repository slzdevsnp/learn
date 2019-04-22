#include "../util/ufuncs.h"

#include <stdio.h>


void testIncrementator(){

    int eggs = 12;

    int before = eggs++;  //post  before expected: 12

    printf("before=%d and eggs=%d\n", before, eggs);


    int after = ++eggs; //pre   after expected: 14

    printf("after=%d and eggs=%d\n", after,eggs);
}

void testPrimitiveNumericTypeConversions(){
    double fiveNinths = 5.0 / 9;
    double nineFifths = 9 / 5.0;

    double threetwos = 3 / 2; // !!bad conversion  gets to 1.00

    printf("fiveNinths %.2f  ninFiths %.2f\n", fiveNinths, nineFifths);

    printf("threeTwos %.2f\n NB! ints are converted to int not a double!", threetwos);
}

double powered(double x, int powered){
    double res = 1.0;
    for (int i=0;i<powered;i++){
        res *= x ;
    }
    return res;
}


void testBasicMathOps(){

    int width = 100;
    int height = 200;

    int area = width * height;
    int perimeter = (width + height) * 2;

    printf("width %d  height %d  area %d perimeter %d\n",width, height, area, perimeter);

    print_light_header("pre incrementing width");
    ++width; //101
    width = width + 1; //102
    width += 1;  //103

    printf("currenty height:%d, width:%d, \n",height,width);
    printf("height modulo width:%d\n", height % width );

    print_light_header("numerics powered to a given arg");
    printf("3^3: %.3f\n", powered(3.0, 3));
    printf("5^15: %.3f\n", powered(5.0,15));

}

/*###########################################################*/
int main(){

    print_header("incrementator post and pre");
    testIncrementator();

    print_header("primitive numeric types ayto conversions");
    testPrimitiveNumericTypeConversions();

    print_header("basic math ops");
    testBasicMathOps();

}