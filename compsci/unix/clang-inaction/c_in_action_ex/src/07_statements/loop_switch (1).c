#include "../util/ufuncs.h"

#include <stdio.h>



void testAnonDefinedLoop(){
    //anon
    int count = 0;
    for (;;)
    {
        printf("count %d\n", count);

        count += 1;

        if (count == 7) break;
    }
    //classic
    count = 0;
    for(int i=0; i<3; i++){
        printf("classic for count %d\n",count);
        count += 1;
    }
}

void testSwitch(){
    int eggs = 1;

    switch (eggs){

        case 0: printf("no cake :(\n");  break;
        case 1: printf("cupkake  :)\n"); break;
        default: printf("cake!\n"); break;
    }
}



int main(){
    print_header("anonymous loop and classic loop");
    testAnonDefinedLoop();

    print_header("switch statement on int variable");
    testSwitch();
}
