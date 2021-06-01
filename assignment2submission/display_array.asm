; Author: Kevin Lopez
; Program title: Array Reverser
; Program Description: This program receives a sequence of integers, then puts them into an array
;   Then the program prints out the array, then prints out the array in reverse, and finally
;   it calculates the mean of the data then passes it to the main function.
; 
; FILES: main.c
;        manager.asm 
;        reverse.cpp
;        display_array.asm <---- You are here.
;        run.sh


    extern printf                                        ; External / global funtions.
    extern scanf
    global display

segment .data                                            ; Initialized data.
    msg             db " ", 10, 0 
    floatIOFormat   db "%f", 10, 0                       ; Formating.
    stringformat     db "%s", 0
    dmlIOFormat     db "%ld", 10, 0
    integerformat   db "%i ", 0                          ; general decimal integer

segment .bss                                             ; Un-initialized data.
segment .text                                            ; Start of executable instructions.

display:                                                 ; Entry point.
; ********************************************
    push rbp                                             ; Back-up registers.
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf
; ********************************************

                                                         ; Array:
    mov r14, rdi                                         ; rdi --> r14

    mov r13, rsi                                         ; Array size:
    mov r15, rsi                                         ; rsi --> r13, r15

    mov r8, 0                                            ; Sum of user-inputed integer (decimal) array.


start_loop:                                              ; Iterate through array

    cmp r13, 0                                           ; (arraySize == 0)
    je loopComplete                                      ; --> Jump if true.
    mov qword rax, 0                                            
    mov rdi, integerformat                               ; passing in the format to use
    mov rsi, [r14]                                       ; passing in our array index
    call printf  


    dec r13                                              ; Decrement the loop/array index counter.
    add r14, 8                                           ;  Add current array value to r8.
    jmp start_loop                                       ; Jump to the top of this loop.
    mov rax, 0
loopComplete:

    mov rdi, stringformat                                ; We are printing the final message
    mov rsi, msg
    call printf

; ********************************************
    popf                                                 ; Restore registers.
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rbp

; ********************************************
    
    ret                                                  ; Return to calling funtion.