
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
;   Then the program then prints out the array. Afterwards, the program finds
;   the biggest number in the array and its index, then tells us what they are.
; 
; FILES: main.c 
;        manager.asm 
;        input_array.cpp 
;        display_array.asm 
;        find_biggest.asm <---- You are here.
;        run.sh

; File Purpose: This file is in charge of finding the biggest value of any array that gets passed into it. It returns the biggest value, and the size of the index.
; They are both returned by putting those two values into an index of size 2. That array gets sent back to the manager file.

    extern printf                                       ; External / global funtions.
    extern scanf
    global find_biggest

segment .data                                           ; Initialized data.
    msg                 db "The largest value ", 0 
    stringformat        db "%s", 0
    integerformat       db "%i ", 0                     ; general decimal integer
    indexPrint          db "has been found at index %i", 10, 10, 0


segment .bss                                            ; Un-initialized data.

    returnArray resq 2                                  ; This is the array we are returning

segment .text                                           ; Start of executable instructions.

find_biggest:                                           ; Entry point.
; ****************************************************************************************
    push rbp                                            ; Back-up registers.
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
; ****************************************************************************************

mov r14, rdi                                         ; backing up the array into r14
mov r13, rsi 

mov r12, 0
movsd xmm14, [r14]
movsd xmm0, [r14]

start:
cmp r12, r13            ;cmpare r12(counter) with size
je final

inc r12

movsd xmm15, [r14+r12*8]
ucomisd xmm14, xmm15
ja next
jmp start

movsd xmm14, xmm15
jmp start


next: 
movsd xmm14, xmm14
jmp start

final:
movsd xmm0, xmm14

; ****************************************************************************************
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