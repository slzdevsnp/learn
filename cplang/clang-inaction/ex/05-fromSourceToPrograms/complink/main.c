#include <stdio.h>  //this is a preprocessor statement
#include "multiply.h" //this is a preprocessor statement

int main(){
	
	printf("4 * 5 = %d\n",multiply(4,5)); //cannot included code defined in another file without its header file

}