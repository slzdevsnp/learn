#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

#include "../util/ufuncs.h"


void test_concat(){
    char *str1 = "Hello";
    char *str2 = " baby.";
    char *str3 = " You are wonderfull";
    char buffer[500];
    strcpy(buffer,str1);
    strcat(buffer,str2);
    strncat(buffer,str3,4); //concatenante 4 first chars from the src
    printf("after strcat: %s\n",buffer);
}

void test_escape_chars(){
    // \r CR \n LF
    char * message = "\"Hello world\"\r\nC:\\Foo\\Bar\r\nhttp://kennykerr.ca\n";
    printf(message);
}

void test_char_classification(){
    char * message = "\"Hello world\"\nC:\\Foo\\Bar\nhttp://kennykerr.ca\n";

    printf(message);

    for (char * p = message; *p; ++p)
    {
        char c = *p;

        printf("%c\t", c);

        if (isalnum(c)) printf("isalnum ");
        if (isalpha(c)) printf("isalpha ");
        if (islower(c)) printf("islower ");
        if (isupper(c)) printf("isupper ");
        if (isdigit(c)) printf("isdigit ");
        if (isxdigit(c)) printf("isxdigit ");
        if (iscntrl(c)) printf("iscntrl ");
        if (isgraph(c)) printf("isgraph ");
        if (isspace(c)) printf("isspace ");
        if (isblank(c)) printf("isblank ");
        if (isprint(c)) printf("isprint ");
        if (ispunct(c)) printf("ispunct ");

        printf("\n");
    }
}


void test_char_manipulation(){

    char message[] = "Hello world!";

    for (char *p = message; *p; ++p)
    {
        if (isupper(*p)) { *p = (char) tolower(*p); }
        else if (islower(*p)){ *p = (char) toupper(*p);}
    }
    printf(message);
}

void test_str_numeric_conversion(){
    double d = atof("123.456");
    int i = atoi("1234");

    printf("%.3f %d\n", d, i);

    print_light_header("string to numbers with strtol");
    char * numbers = "12 0x123 101";
    char * next = numbers;

    int first = strtol(next, &next, 10);
    int second = strtol(next, &next, 0);
    int third = strtol(next, &next, 2);

    printf("%d %d %d\n", first, second, third);
}

void test_str_comparison(){
    char * message = "Hello world";
    printf("message size: %d\n", (int) strlen(message));

    printf("Apples %d\n", strcmp(message, "Apples"));
    printf("Oranges %d\n", strcmp(message, "Oranges"));
    printf("Hello world %d\n", strcmp(message, "Hello world"));
}

int main(){
    print_header("concatenation");
    test_concat();

    print_header("escape chars");
    test_escape_chars();

    print_header("char classification");
    test_char_classification();

    print_header("char manipulation");
    test_char_manipulation();

    print_header("string numeric conversion");
    test_str_numeric_conversion();

    print_header("string comparision");
    test_str_comparison();

}
