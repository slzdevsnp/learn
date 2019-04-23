#include <stdio.h>

float powered(float x, int powered){

    float res = 1.0f ;
    for (int i=0;i<powered;i++){
        res *= x ; 
    }
    return res;
}


int main()
{
    int width = 100;
    int height = 200;
    
    int area = width * height;
    int perimeter = (width + height) * 2;
    
    printf("area %d perimeter %d\n", area, perimeter);
    
    ++width;
    width = width + 1;
    width += 1;
    
    printf("currenty width:%d, height:%d\n",width,height);

    printf("height modulo width:%d\n", height % width );



    if (width == height) printf("square\n");
    if (width > height) printf("wider\n");
    if (width < height) printf("taller\n");
    if (width != height) printf("not square\n");

    printf("3^3 %.2f\n", powered(3.0, 3));
    printf("5^15 %.2f\n", powered(5.0, 15));

}