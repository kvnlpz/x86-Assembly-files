# Author: Kevin Lopez
# Program title: Assembly Area Calculator
# Program Description: This program prompts the user for a whole number and calculates
#       the area of a circle with a radius of that number.
#       it then prints out the area with the remainder in 
#       meters and passes the area back to the main program.
#
# FILES: egpytian.c 
#        area.asm
#        run.sh <---- You are here.


#Delete some un-needed files
rm *.o
rm *.out

#echo "The script file for circumference finder has begun"

#echo "Assemble area.asm"
nasm -f elf64 -l area.lis -o area.o area.asm

#echo "Compile integerdriver.c"
gcc -c -Wall -m64 -no-pie -o egyptian.o egyptian.c -std=c11

#echo "Link the object files"
gcc -m64 -no-pie -o math.out -std=c11 area.o egyptian.o

#echo "Run the program Integer Arithmetic:"
./math.out

#echo "The script file will terminate"

