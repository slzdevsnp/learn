#include <stdio.h>
#include <stdlib.h>

int main()
{
    double d = atof("123.456");
    int i = atoi("1234");
    
    printf("%.3f %d\n", d, i);
    
    char * numbers = "12 0x123 101";
    char * next = numbers;
    
    int first = strtol(next, &next, 10);
    int second = strtol(next, &next, 0);
    int third = strtol(next, &next, 2);
    
    printf("%d %d %d\n", first, second, third);
}
















