#import <stdio.h>  //this is a preprocessor statement
#include "multiply.h" //this is a preprocessor statement

int main(){
	
	printf("The multiply result: %d\n",multiply(2,3)); //cannot included code defined in another file without its header file

}