
;Copyright (C) 2020 Kevin Lopez

;This program is free software; you can redistribute it and/or
;modify it under the terms of the GNU General Public License
;as published by the Free Software Foundation; either version 2
;of the License, or (at your option) any later version.

;This program is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;GNU General Public License for more details.


; Author: Kevin Lopez
; Email: Kevinlopez8554@csu.fullerton.edu
; Date of last update: 3/5/20
; System Requirements: A modern computer with linux, and an x86 processor
; Program title: Biggest Integer Finder 
; Program Description: This program receives a sequence of integers, then puts them into an array
;   Then the program prints out the array, then prints out the array. Afterwards, the program finds
;   the biggest number in the array and its index, then tells us what they are.
; 
; FILES: main.c 
;        manager.asm 
;        input_array.cpp 
;        display_array.asm <---- You are here.
;        find_biggest.asm 
;        run.sh

; File Purpose: This file is in charge of displaying whatever array is passed into it

    extern printf                                        ; External / global funtions.
    extern scanf
    global display_array
    

segment .data                                            ; Initialized data.
    msg             db " "  ,  10, 0 
    floatIOFormat   db "%lf" ,  10, 0                     ; Formating.
    stringformat    db "%s" ,      0
    dmlIOFormat     db "%ld",  10, 0
    integerformat   db "%i ",      0                     ; general decimal integer

segment .bss                                             ; Un-initialized data.
segment .text                                            ; Start of executable instructions.

display_array:                                           ; Entry point.
; ********************************************************************************************************
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
; ********************************************************************************************************

    mov r14, rdi                                         ; backing up our array into r14

    mov r13, rsi                                         ; baking up our array size into r13

start_loop:                                              ; Iterate through array

    cmp r13, 0                                           ; (arraySize == 0)
    je loopComplete                                      ; --> Jump if true.
    ; mov qword rax, 0                                            
    movsd xmm0, [r14]
   ; cvtsd2ss xmm0, xmm0
    mov rdi, floatIOFormat                               ; passing in the format to use
    mov rax, 1                                       ; passing in our array index
    call printf  


    dec r13                                              ; Decrement the loop/array index counter.
    add r14, 8                                           ;  Add current array value to r8.
    jmp start_loop                                       ; Jump to the top of this loop.

loopComplete:

    mov rdi, stringformat
    mov rsi, msg
    call printf

; ********************************************************************************************************
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

; ********************************************************************************************************
    
    ret                                                  ; Return to calling funtion.