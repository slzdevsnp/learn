#include <stdio.h>

typedef struct
{
    float X;
    float Y;
} Pixel;

typedef unsigned char byte;

struct Color
{
    byte Red;
    byte Green;
    byte Blue;
};

int main()
{
    Pixel p = { 10.0f, 20.0f };
    struct Color c = { 255, 128 };
    
    float x = p.X;
    c.Blue = 255;
}
