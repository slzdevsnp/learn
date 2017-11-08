#include <stdio.h>

float celcius_to_fahrenheit(float celcius)
{
	return celcius * 9 / 5 + 32;
}

float celcius_to_kelvin(float celcius){
	return celcius + 273.15f;
}

int main()
{

	float celcius = 0;

    
   while (celcius < 100)
   {

	celcius += 10;

	printf("%.3f C = %.3f F= %.3f K\n",   // this format %.3f is for floats with fixed number of digits after .
		celcius,
		celcius_to_fahrenheit(celcius),
		celcius_to_kelvin(celcius));
  }

}
