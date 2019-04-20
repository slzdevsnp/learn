#include <stdio.h>

void run()
{
    int hens = 4;
    static int eggs = hens;
    
    hens += 1;
    eggs += 1;
    
    printf("%d %d\n", hens, eggs);
}

int main()
{
    run();
    run();
    run();
}
