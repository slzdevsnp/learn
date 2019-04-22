#include "../util/ufuncs.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void testPrintf(){
    printf("pre %-10.2f post\n", 123.456);  // %-10.2f  left aligned, 10 chars used to print
    printf("pre %-10d post\n", 1234567);    // %-10d  left aligned
    printf("pre %-10d post\n", 111222333444); // wrongly prints
    printf("pre %lld post\n", 111222333444); // prints long ok on gcc

    print_light_header("printing a string");
    char * message = "Hello world, Goodbye cruel world";
    int size = 15;

    printf("%s\n", message);
    printf("%.*s\n", size, message);
}

void test_sprintf(){
    char * font = "Myriad Pro";
    int size = 32;
    char * message = "Hello world";

    char buffer[500]; // no check on buffer length. if it is too short  segfault

    //on unix snprintf, on win sprintf_s
    snprintf(buffer,
              sizeof(buffer),
              "<html><body><p style='font-family:%s;font-size:%dpx'>%s</p></body></html>",
              font,
              size,
              message);

    printf("%s\n", buffer);

}

void test_scanf(){
    char message[12];
    printf("enter a word followed by a CR:");
    scanf("%12s",message);  // dev has to make sure that there is no buffer overfloat

    printf("%s\n",message);
}

int test_file_write(char *fname){
    FILE *f = 0;
    f = fopen(fname,"w"); // w: (re)write, a: append
    if (!f){
        perror("file opening failed:");
        return EXIT_FAILURE;
    }
    //writing to the file
    fprintf(f, "Hello world\n");

    fclose(f);
}

int test_file_read(char *fname){
    FILE *fp = 0;
    fp = fopen(fname,"r");
    if (!fp){
        perror("file opening failed:");
        return EXIT_FAILURE;
    }
    //reading a contents of a file
    print_light_header("reading contents of a file..");
    int c;
    while( (c=fgetc(fp)) != EOF){
        putchar(c); // print 1 byte
    }
    if (ferror(fp))
        puts("I/O error when reading");
    else if (feof(fp))
        puts("End of file reached successfully");
    fclose(fp);
}


int  main(){

    print_header("printf ");
    testPrintf();

    print_header("sprintf");
    test_sprintf();

    print_header("scanf");
    //test_scanf();
    printf("skipped..");

    print_header("fprintf writing to file");
    test_file_write("/tmp/message.txt");
    test_file_read("/tmp/message.txt"); //test_file_read("/tmp/bogus_message.txt");
}
