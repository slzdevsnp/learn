#include <stdio.h>

int main()
{
	    int numbers[3] = { 101, 202, 303 }; //the 4th element is not initalized but space is reserved

	    int size = sizeof(numbers) / sizeof(numbers[0]); // this is how size of array can be determined
	    

	int *p = numbers ; //point tto th efirst element of th earray

	int *end =p + size ;  //point to end of the array

	for (; p != end; ++p){  //a pointer is incremented
		printf("el through ptr %d\n", *p);		
	}

    printf("sizeof(numbers) %d\nsizeof(p) %d\n", 
    		(int) sizeof(numbers),  //size of an array of 3 integers
    		(int) sizeof(p));   //size of a pointer  variable

}
