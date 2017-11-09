#include <stdio.h>

int main()
{
    double fiveNinths = 5.0 / 9;
    double nineFifths = 9 / 5.0;

    double threetwos = 3 / 2; // !!bad conversion  gets to 1.00
    
    printf("%.2f %.2f\n", fiveNinths, nineFifths);

    printf("%.2f\n", threetwos);
}

