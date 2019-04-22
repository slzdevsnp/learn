#include "../util/ufuncs.h"
#include <stdio.h>
#include <stdlib.h>


int  testIntMalloc(){
    int *p = (int *) malloc(4); // 4 bytes allocated
    if (!p){
        return 1; // no hope
    }
    *p = 42;

    //how to allocate bigger blocks
    void * frame = malloc(1514);  //just raw bytes
    char *msg = (char *) malloc(141); //141 byte for a string

    //freeing memory
    free(frame);
    free(msg);
    //free(msg);  deallocating twice is an error
    frame = 0;
    msg = 0;

    free(p);
    p = 0;
    //int value = *p; //accessing a freed pointer is an error!

    return 0;
}


int main(){

    print_header("allocate bytes with malloc");
    testIntMalloc();

}
