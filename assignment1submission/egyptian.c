//Author: Kevin Lopez
//Program title: Assembly Area Calculator
//Program Description: This program prompts the user for a whole number and calculates
//      the area of a circle with a radius of that number.
//      it then prints out the area with the remainder in
//      meters and passes the area back to the main program.
//
//FILES: egpytian.c <---- You are here.
//       area.asm
//       run.sh 

#include <stdio.h>
#include <stdint.h>

long int area();

int main()
{
    printf("Welcome to your friendly area calculator.\n");
    printf("The main program will now call the area function.\n");
    long int result_code = 1;
    result_code = area();
    printf("%s%ld\n", "The main received this integer: ", result_code);
    printf("Have a nice day. Main will now return 0 to the operating system.\n");
    return 0;
} //End of main
