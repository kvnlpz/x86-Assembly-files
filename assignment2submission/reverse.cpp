// Author: Kevin Lopez
// Program title: Array Reverser
// Program Description: This program receives a sequence of integers, then puts them into an array
//   Then the program prints out the array, then prints out the array in reverse, and finally
//   it calculates the mean of the data then passes it to the main function.
// 
// FILES: main.c
//        manager.asm
//        reverse.cpp <---- You are here.
//        display_array.asm
//        run.sh

#include <stdio.h>
#include <iostream>
using namespace std;

extern "C" void reverse(long a[], int size);

void reverse(long a[], int size)
{
    long backup[100];
    cout << endl;
    cout << "After the reverse function these are the numbers of the array in the new order: " << endl;
    int index = 0;
    for (int i = size - 1; i > -1; i--)
    {   
        //std::cout << a[i] << " ";
        backup[index] = a[i];
        index++;
    }

    //We just copied it to another array

    //Now copy it back to the original one    
     index = 0;
     for (index = size - 1; index > -1; index--)
    {   
        //std::cout << a[i] << " ";
        a[index] = backup[index];
    }



    cout << endl << endl;
}