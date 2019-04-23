#include <stdio.h>

static int eggs;

void up()
{
    eggs += 10;
}

void down()
{
    eggs -= 5;
}

int main()
{
    up();
    up();
    down();
    
    printf("%d\n", eggs);
}
