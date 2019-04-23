#include <stdio.h>

int main()
{
    float celsius = 0, fahrenheit, kelvin;
    
    while (celsius < 100)
    {
        celsius = celsius + 10;
        fahrenheit = celsius * 9 / 5 + 32;
        kelvin = celsius + 273.15f;
        
        printf("%.2f C = %.2f F = %.2f K\n",
               celsius,
               fahrenheit,
               kelvin);
   }
}
