
#include <stdio.h>

#include "../util/ufuncs.h"


void run1(){
    int hens;  // becaue value is unnassigned  we see value in next run taken from the stack see trample
    int eggs = 4;

    hens += 1;
    eggs += 1;
    printf("hens: %d, eggs: %d\n",hens,eggs);
}
void run2(){
    static int hensa;  // because value is unnassigned  we see value in next run taken from the stack see trample
    int eggs = 4;

    hensa += 1;
    eggs += 1;
    printf("hens: %d, eggs: %d\n",hensa,eggs);
}
void run3(){
    static int hensb = 4;
    int eggs = 4;

    hensb += 1;
    eggs += 1;
    printf("hens: %d, eggs: %d\n",hensb,eggs);
}
void trample(){
    int a = 123;
    int b = 124;
}


static int eggs; //global var unassigned. so it's value is: 0

void up(){
    eggs += 10;
}

void down(){
    eggs -= 5;
}

void print_eggs(){
    printf("currently eggs:%d\n",eggs);
}

int main()
{
    print_header("run1 uninitialized local variable hens");
    trample(); run1();
    trample(); run1();
    trample(); run1();

    print_header("run2 uninitialized static  variable hens");
    trample(); run2();
    trample(); run2();
    trample(); run2();

    print_header("run3 initialized static  variable hens");
    trample(); run3();
    trample(); run3();
    trample(); run3();


    print_header("global static variable");
    up();
    up();
    down();
    print_eggs(); //expect 15
    up();
    print_eggs(); //expect 25

}