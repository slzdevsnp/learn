#include <stdio.h>

int main()
{

	float celcius, fahrenheit, kelvin;

	celcius = 21;
	fahrenheit = celcius * 9 / 5 + 32;
	kelvin = celcius + 273.15f;   // 273.15f  for floats

	printf("%.3f C = %.3f F= %.3f K\n",   // this format %.3f is for floats with fixed number of digits after .
		celcius,
		fahrenheit,
		kelvin);

}
