#include <stdio.h>
#include <stdlib.h>

int main()
{
    int * p = (int *) malloc(4);
    
    if (!p)
    {
        return 1; // there's no hope! :(
    }
    
    *p = 42;
    
    free(p);
    p = 0;
    
    int value = *p;
    
    void * frame = malloc(1514);
    
    free(frame);
    frame = 0;
    
    char * message = (char *) malloc(141);
    
    free(message);
    message = 0;
    
    free(message);
}
















