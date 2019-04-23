//
// Created by Sviatoslav Zimine on 2019-04-20.
//

#include <stdio.h>

float celcius_to_fahrenheit(float celcius){
    return celcius * 9/5 + 32 ;
}

float celcius_to_kelvin(float celcius){
    return celcius + 273.15f ;
}

int main() {
    float celcius = 0;

    while (celcius < 100){
        printf("%.2f C =  %.2f F= %.2f K\n",
                celcius,
                celcius_to_fahrenheit(celcius),
                celcius_to_kelvin(celcius));
        celcius += 5;
    }
}

