#include <stdio.h>


typedef unsigned char byte;

int main(){

	int i = 123;
	float f = 1.23f;
	double d = 2.344668783;
	char c = 'c';

    unsigned int ui = 1023u;
    short int si = 123; 
    long int li = 123;
  


    byte b = 0x12;

    //print the size of tpes 
    printf("%d  int has size: (%d)\n",i,(int) sizeof(i));
    printf("%d  unsigned int has size: (%d)\n",ui,(int) sizeof(ui));

    printf("%d  short int has size: (%d)\n",si,(int) sizeof(si));
    printf("%d  long int has size: (%d)\n",li,(int) sizeof(li));

    printf("%f  float has size: (%d)\n",f,(int) sizeof(f));
    printf("%f  double has size: (%d)\n",d,(int) sizeof(d));
    printf("%c  char has size: (%d)\n",c,(int) sizeof(c));
    printf("%d  byte has size: (%d)\n",b,(int) sizeof(b));

     	

}