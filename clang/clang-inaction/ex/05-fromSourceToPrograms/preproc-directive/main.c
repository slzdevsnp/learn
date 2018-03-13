#include <stdio.h>
#include "multiply.h"

#define LEVEL  2


int main(){
	int res = 0;
	#if LEVEL > 0             //only execute if preprocessor condition ok
	    #if !defined(RUNFAST)
		   res = SQUARE(5);    //this statement is in double preprocessor #if
		#endif
   	    printf("result: %d\n",res);
   	#endif
}
