// Author: Kevin Lopez
// Program title: Array Reverser
// Program Description: This program receives a sequence of integers, then puts them into an array
//   Then the program prints out the array, then prints out the array in reverse, and finally
//   it calculates the mean of the data then passes it to the main function.
// 
// FILES: main.c <---- You are here.
//        manager.asm
//        reverse.cpp 
//        display_array.asm
//        run.sh

#include <stdio.h>
#include <stdint.h>
#include <math.h>

// "C" is a directive to the C++ compiler --> "CCC" rules for parameter passing.
extern "C" double manager();

int main(int argc, char *argv[])
{
    printf("\nWelcome to an array of integers.\nThis program is brought to you by Kevin Lopez.\n\n");
    double answer = 0;
    answer = manager();
    printf("%s%1.lf%s\n", "\nMain received this number: ", floor(answer), ".\nMain will return 0 to the operating system.");
    return 0;
}