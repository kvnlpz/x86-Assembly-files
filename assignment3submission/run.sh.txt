
#Copyright (C) 2020 Kevin Lopez

#This program is free software# you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation# either version 2
#of the License, or (at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY# without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.


# Author: Kevin Lopez
# Email: Kevinlopez8554@csu.fullerton.edu
# Date of last update: 3/5/20
# System Requirements: A modern computer with linux, and an x86 processor
# Program title: Biggest Integer Finder 
# Program Description: This program receives a sequence of integers, then puts them into an array
#   Then the program prints out the array, then prints out the array. Afterwards, the program finds
#   the biggest number in the array and its index, then tells us what they are.
# 
# FILES: main.c 
#        manager.asm
#        input_array.cpp 
#        display_array.asm
#        find_biggest.asm 
#        run.sh <---- You are here.

# File Purpose: Assemble and Compile every file we need and link them together so our program can run properly. 

# Remove other helper files.

rm *.out    
rm *.o
rm *.lis


# Assemble x86 module manager.asm.
nasm -f elf64 -l manager.lis -o manager.o manager.asm

# Assemble x86 module display_array.asm.
nasm -f elf64 -l display_array.lis -o display_array.o display_array.asm

# Assemble x86 module find_biggest.asm.
nasm -f elf64 -l find_biggest.lis -o find_biggest.o find_biggest.asm

# Compile C module main.c
g++ -c -m64 -Wall -l main.lis -o main.o main.c -fno-pie -no-pie

# Compile C++ module input_array.cpp
g++ -c -m64 -Wall -l input_array.lis -o input_array.o input_array.cpp -fno-pie -no-pie

# Link object files.
g++ -m64 -o program.out manager.o display_array.o main.o input_array.o find_biggest.o -fno-pie -no-pie

# .out file execution.
./program.out