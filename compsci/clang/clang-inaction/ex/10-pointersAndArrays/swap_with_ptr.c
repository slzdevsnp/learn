#include<stdio.h>

void swap(int *x, int *y){  
	
	int tmp ; 
	tmp = *x ;  
	*x = *y;  //inside func we modify contents of a pointer incoming param
	*y = tmp;
}

int main(){
	
	int a = 7;
	int b = 9;
	printf("before the swap a:%d  b:%d\n",a,b);
	swap(&a, &b); //copies of ptr variables are passed by value into func
	printf("after the swap a:%d  b:%d\n",a,b);
}