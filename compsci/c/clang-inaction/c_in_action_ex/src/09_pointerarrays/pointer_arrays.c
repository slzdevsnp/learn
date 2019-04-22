#include "../util/ufuncs.h"
#include <stdio.h>



void testPointerOnInt(){
    int i= 1234;
    //print an adress of an int . value is architecture specific
    printf("memory address of an int: %p\n", &i);

    //define a pointer type
    int * p = 0; //safe way to define a pointer pointing to inaccessible address;

    print_light_header("referencing a pointer to a variable");
    p = &i ; //assign a pointer variable to existing int variable
    printf("memory address of a pointer assigned int: %p\n", &p);

    int j = *p; //assign brand new int variable with a pointer's value
    printf("j value and its adresse: %d %p\n",j,&j); //expected to be different than &i

    print_light_header("changing pointer's contents and hence the underlying variable");
    *p = 23445;
    printf("i after p* was changed %d\n",i);

}

void swap(int *x, int *y){
    int tmp = *x;
    *x = *y;
    *y = tmp;
}
/*inside func  contents of params from
 * the outer scopeare modified */
void testSwap(){
    int a = 9;
    int b = 11;
    printf("before swap a %d  b %d\n",a,b);
    swap(&a, &b);
    printf("after swap a %d  b %d\n",a,b);

}

void testArrayNoPtr(){
    //arrray of length 4,  the last element is unassigned, and contains 0;
    int numbers[4] = { 101, 202, 303 };

    // a way to compute array lenght in elements
    int size = sizeof(numbers) / sizeof(numbers[0]);

    for (int i = 0; i < size; ++i)
    {
        printf("%d\n", numbers[i]);
    }
}

void testArrayWithPtr(){

    int numbers[4] = { 101, 202, 303 };
    int size = sizeof(numbers) / sizeof(numbers[0]);
    //point to a start of the array (1st element)
    int *p = numbers;
    //point to end of the array (element next to last)
    int *end = numbers + size;

    for (; p != end; p++){
        printf("%d\n", *p);

    }

}

int* findMax(int * begin, int * end){
    if (begin == end) return 0; //array with lenght 0;
    int *largest = begin;
    for(;begin !=end; begin++){
        if (*largest < *begin){
            largest = begin;
        }
    }
    return largest;
}



void testFindArrayMaxWithPtr(){
    int numbers[] = {9,-10,8,15,17,111,22};
    int size = sizeof(numbers)/sizeof(numbers[0]);
    int *start = numbers;
    int *end = start+size;
    int  *maxVal = findMax(start,end);
    printf("max value in array: %d\n",*maxVal);
}


void iterateOverIntArray(int *start){
    do{
        printf("el %d\n",*start);
    }while(*start++);
}
void testArrayWihNoEnd(){
    int numbers[5] = {1,3,5,7,9};
    iterateOverIntArray(numbers);
}

int strLen(char *string){

    int length = 0;
    while (*string++){
        ++length;
    }
    return length;
}

void testStringLength() {
    printf("Hello world len: %d\n", strLen("Hello world"));
    printf("empty string len %d\n", strLen(""));
    printf("Hi! string len %d\n", strLen("Hi!"));
    printf("\ttab string len %d\n", strLen("\ttab"));

}


void MinMax( int *begin, int *end,
             int **smallest,
             int **largest){
    if (begin == end){
        *smallest = 0;
        *largest = 0;
    }else{
        *smallest = *largest = begin;
        while (++begin != end){
            if (*begin < **smallest){
                *smallest = begin;
            }
            if (*begin > **largest){
                *largest = begin;
            }
        }
    }
}

void testPointerPointerMinMax(){
    int values [] = { 5, 2, -4, 3, 9, 7};
    int size = sizeof(values) / sizeof(values[0]);

    int * smallest  = 0;
    int * largest = 0;

    MinMax(values,values + size,
           &smallest,  //reference to a poiner are passed into func i.e. pointer to pointer
           &largest);

    printf("min=%d max=%d\n",
           *smallest,
           *largest);
}


/*###########################################################*/

int main(){

    print_header("pointer referencing and dereferencing");
    testPointerOnInt();
    print_header("pointers in a swap func");
    testSwap();

    print_header("array  with no pointers");
    testArrayNoPtr();

    print_header("array  with pointers");
    testArrayWithPtr();

    print_header("finding max val in array  using poingters");
    testFindArrayMaxWithPtr();

    print_header("it is important to specify array start and end when iterating");
    testArrayWihNoEnd();

    print_header("string literals w pointers");
    testStringLength();

    print_header("pointer to pointer, finding min max in a func ");
    testPointerPointerMinMax();



}
