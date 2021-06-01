; Author: Kevin Lopez
; Program title: Array Reverser
; Program Description: This program receives a sequence of integers, then puts them into an array
;   Then the program prints out the array, then prints out the array in reverse, and finally
;   it calculates the mean of the data then passes it to the main function.
; 
; FILES: main.c
;        manager.asm <---- You are here.
;        reverse.cpp
;        display_array.asm
;        run.sh



    extern reverse                                                    ; Global / external function declarations.
    extern display
    extern printf                                              
    extern scanf
    extern squares                                    
    global manager            


segment .data    
    dmlIOFormat         db "%ld", 0                                   ; Formatting.
    arrayaddressmessage db "The first element of the array is located at 0x%016lx in stack space", 10, 0
    initialmessage      db "This X86 program will demonstrate the use of Control-D to terminate a loop.", 10, 0
    promptmessage       db "Enter a sequence of floating point numbers in base 10 separate each number with white space.  After the last "
                        db "valid input press 'enter' followed by a control+D to terminate: ", 10, 0
    count_message       db "You have entered %1ld floating point numbers.", 10, 0
    stringformat        db "%s", 0                                    ; general string format
    integerformat       db "%i ", 0                                   ; general decimal integer
    eight_byte_format   db "%lf", 0                                   ; general 8-byte float format

    mssg1                db "This programm will reverse your array of integers", 10, 0                    
    mssg2                db "Enter a sequence of long integers separated by white spaces. After the last input press enter followed by Control+D", 0
    mssg3                db " ", 10, 0 
    mssg4                db "These numbers were recieved and placed into the array:", 10, 0 
    mssg5                db "The number of numbers entered is %i and the mean is %i.", 10, 0 
    mssg6                db "The mean will now be returned to the main function.", 10, 0 
    resultmssg1          db "The mean of these %ld numbers is %lf", 10, 0 
    currentValue         dq 0                                         ; Tempporary input space.

segment .bss         
    intArray resq 65                                                  ; 65 element quad array


segment .text                                              
manager:                                                              ; Entry point.

; ************************************************************
    push rbp                                                          ; Back-up registers.
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
  ; ************************************************************

    mov r14, intArray                                                 ; Array.
    mov r15, 0                                                        ; Array size.
    mov  r12, 0                                                       ; total

  ; ************************************************************
    mov qword rax, 0                                                  ; Message 1
    mov rdi, stringformat                                             ; Load in scanf/printf string I/O format, rdi: Default param #1 
    mov rsi, mssg1                                                     ; Load in the first instruction message, rsi: Default param #2 
    call printf                                                       ; C Library function
        
    mov qword rax, 0                                                  ; Message 2
    mov rdi, stringformat                                              ; Load in scanf/printf string I/O format, rdi: Default param #1 
    mov rsi, mssg2                                                     ; Load in the first instruction message, rsi: Default param #2 
    call printf                                                       ; C Library function

    mov qword rax, 0                                                  ; Message 3
    mov rdi, stringformat                                              ; Load in scanf/printf string I/O format, rdi: Default param #1 
    mov rsi, mssg3                                                     ; Load in the first instruction message, rsi: Default param #2 
    call printf                                                       ; C Library function

  ; ************************************************************

;=========== Prompt for a sequence of floating point numbers to be inputted =======================================================

mov qword  rax, 0                                                     ; No data from SSE will be printed
mov        rdi, stringformat                                          ; "%s"
mov        rsi, promptmessage                                         ; "Enter a sequence of floating point numbers in base 10 separate ..."
call       printf                                                     ; Call a library function to make the output

inputLoop:                                                            ; User input:  
    mov rdi, dmlIOFormat                                              ; Load in scanf/printf signed int I/O format, rdi: Default param #1
    mov rsi, currentValue                                             ; Load the current loop iterations user input value, rsi: Default param #2
    call scanf                                                        ; C Library function

                                                                      ; Check conditions:
    cdqe                                                              ; rdx = The sign-extension of that 32-bit number
    cmp rax, -1                                                       ; Check for CTRL + D, (-1) input
    je loop_finished             

    mov rcx, qword [currentValue]                                     ; Move the current input value into rcx.
    mov qword [r14+r15*8], rcx                                        ; Move the current input value from rcx into the array position.
    add r12, rcx
    inc r15                                                           ; Increment the array count register.
    jmp inputLoop                                                     ; Jump back to the top of this loop.

loop_finished: 
    mov qword rax, 0                                                  ; Message Output 4: 
    mov rdi, stringformat                                             ; using String format
    mov rsi, mssg4                                                    ; passing message to rsi
    call printf 

                                                                      ; Get ready to call the display function
    mov rdi, r14                                                      ; Pass array.
    mov rsi, r15                                                      ; Pass array size.
    call display                                                      ; calling my display function

                                                                      ; Getting ready to call the reverse function
    mov rdi, r14                                                      ; passing the array 
    mov rsi, r15                                                      ; passing the array size
    mov qword rax, 0    
    call reverse                                                      ; Calling the reverse function

    mov rdi, r14                                                      ; Pass array.
    mov rsi, r15                                                      ; Pass array size.
    call display                                                      ; calling my display function

   
                                                                      ; I did this twice, because I couldn't return using the other registers
    cvtsi2sd xmm15, r12                                               ; Sum to double (float).
    cvtsi2sd xmm3, r15                                                ; array size to double (float). 
    divsd xmm15, xmm3                                                 ; FP Division, mean goes into xmm15


                                                                      ; calclating mean
    mov  rax,r12                                                      ; The first integer is in rax
    cqo
    idiv r15                                                          ; Divide rdx:rax by denominator
    mov r12,  rax                                                     ; Keep the remainder inside of r12
    
    
    mov qword rax,0
    mov rdi, mssg5                                                    ; Passing in our message #5
    mov rsi, r15                                                      ; 2nd parameter
    mov rdx, r12                                                      ; 3rd parameter
    call printf                                                       ; function call

                                                                      ; Message Output 6: 
    mov rdi, stringformat                                             ; format parameter
    mov rsi, mssg6                                                    ; string parameter
    call printf                                                       ; calling printf

    
    movsd xmm0, xmm15                                                 ; Move original mean value from xmm15 back to xmm0 for return to caller funtion.

; ************************************************************
    popf                                                              ; Restore registers.
    pop r15
    pop r14
    pop r13
    pop r11
    pop r12
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rbp

    ret                                                               ; Return to calling function.