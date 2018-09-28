#include <stdio.h>

int main()
{
    int count = 0;

    for (;;)
    {
        printf("count %d\n", count);
        
        count += 1;
        
        if (count == 7) break;
    }


    count = 0;
    for(int i=0; i<10; i++){
    	printf("classic for count %d\n",count);
    	count += 1;
    }
}
