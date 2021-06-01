/*
Copyright (C) 2020 Kevin Lopez

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

*/

// Author: Kevin Lopez
// Email: Kevinlopez8554@csu.fullerton.edu
// Date of last update: 3/5/20
// System Requirements: A modern computer with linux, and an x86 processor
// Program title: Biggest Integer Finder 
// Program Description: This program receives a sequence of integers, then puts them into an array
//   Then the program prints out the array, then prints out the array. Afterwards, the program finds
//   the biggest number in the array and its index, then tells us what they are.
// 
// FILES: main.c 
//        manager.asm 
//        input_array.cpp <---- You are here.
//        display_array.asm 
//        find_biggest.asm 
//        run.sh

// File purpose: Once it gets called, the function inside recieves a pointer to an array and size
//              it then adds numbers to the array until it's filled.

#include <stdio.h>
#include <iostream>
#include <cstring>
using namespace std;

extern "C" int input_array(  double a[], int size);


int input_array( double a[], int size)
{
	int i = 0;
	char str[20];
	int functionSize = 4;
	while(fgets(str, functionSize, stdin) != NULL)
	{
		if(atof(str) > 0.0 + 0.0001 || atof(str) < 0.0 - 0.0001)
		{
			a[i] = atof(str);
			size++;
			i++;
		}
	}
	return size;
}