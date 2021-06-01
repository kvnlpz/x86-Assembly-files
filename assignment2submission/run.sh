# Author: Kevin Lopez
# Program title: Array Reverser
# Program Description: This program receives a sequence of integers, then puts them into an array
#   Then the program prints out the array, then prints out the array in reverse, and finally
#   it calculates the mean of the data then passes it to the main function.
# 
# FILES: main.c 
#        manager.asm
#        reverse.cpp 
#        display_array.asm
#        run.sh <---- You are here.


# Remove other helper files.

rm *.out    
rm *.o
rm *.lis


# Assemble x86 module manager.asm.
nasm -f elf64 -l manager.lis -o manager.o manager.asm

# Assemble x86 module display_array.asm.
nasm -f elf64 -l display_array.lis -o display_array.o display_array.asm

# Compile C module main.c
g++ -c -m64 -Wall -l main.lis -o main.o main.c -fno-pie -no-pie

# Compile C++ module reverse.cpp
g++ -c -m64 -Wall -l reverse.lis -o reverse.o reverse.cpp -fno-pie -no-pie

# Link object files.
g++ -m64 -o program.out manager.o display_array.o main.o reverse.o -fno-pie -no-pie

# .out file execution.
./program.out