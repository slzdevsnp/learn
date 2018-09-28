#include <stdio.h>

int main(){

	int i = 1234;

	printf("memory adress of an int: %p\n", &i); //print an adress of an int . value is architecture specific

	//define a pointer

	int * p = 0;  //safe way to initalize poiners to invalid "zero" adress
	p = &i ;  // reference (point) p to an existing variable

	//pointing to the adresse of i

	printf("adress of pointer p %p and its contents:%d\n", p, *p);	

    int j = *p ;  //initialize j with a contents of  p  //j is stored in another memory cell 
    printf("j value and its adresse: %d %p\n",j,&j);  

    *p = 2345 ; //change the poiter contens  so i is changed 
    printf("i after p* was changed %d\n",i);

}