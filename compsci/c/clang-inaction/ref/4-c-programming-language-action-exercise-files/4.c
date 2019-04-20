#include <stdio.h>

float celsius_to_fahrenheit(float celsius)
{
    return celsius * 9 / 5 + 32;
}

float celsius_to_kelvin(float celsius)
{
    return celsius + 273.15f;
}

int main()
{
    float celsius = 0;
    
    while (celsius < 100)
    {
        celsius = celsius + 10;
        
        printf("%.2f C = %.2f F = %.2f K\n",
               celsius,
               celsius_to_fahrenheit(celsius),
               celsius_to_kelvin(celsius));
   }
}
