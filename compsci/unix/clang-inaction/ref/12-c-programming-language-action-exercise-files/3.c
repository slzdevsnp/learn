#include <stdio.h>

int main()
{
    char * font = "Myriad Pro";
    int size = 32;
    char * message = "Hello world";
    
    char buffer[50];
    
    sprintf_s(buffer,
              sizeof(buffer),
              "<html><body><p style='font-family:%s;font-size:%dpx'>%s</p></body></html>",
              font,
              size,
              message);
            
    printf("%s\n", buffer);
}
















