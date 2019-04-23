
#include "multiply.h" //this is a preprocessor statement
#include <stdio.h>
int main(){

    double res = multiply(2,3); //cannot included code defined in another file without its header file
    printf("multiply result: %.3f\n",res);
}
