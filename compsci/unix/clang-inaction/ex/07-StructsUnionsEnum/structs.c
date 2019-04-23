#include <stdio.h>

//define a struct as a new type
typedef  struct {
	float X;
	float Y;
} Pixel;     //this syntax will work in C++ as well

print_pixel(Pixel p){
	printf("Pixel's X,Y coordinates: %.2f,%.2f\n", p.X, p.Y);
}

typedef unsigned char byte;

//define a struct as a new type which uses another typedef for its members
typedef struct{
	byte  Red;
	byte Green; 
	byte Blue;
} Color;

void print_color(Color c){
	printf("Color's rgb triplet: %d:%d:%d\n", c.Red, c.Green, c.Blue);
}


int main(){

	Pixel p = { 10.0f, 20.0f} ;
	Color cl = {255, 128, 0};

	print_pixel(p);
	print_color(cl);

	//now update ht ecolor
	cl.Blue = 255;
	print_color(cl);

}