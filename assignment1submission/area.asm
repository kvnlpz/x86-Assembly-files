;Author: Kevin Lopez
;Program title: Assembly Area Calculator
;Program Description: This program prompts the user for a whole number and calculates
;      the area of a circle with a radius of that number.
;      it then prints out the area with the remainder in 
;      meters and passes the area back to the main program.
;
;FILES: egpytian.c 
;       area.asm  <---- You are here.
;       run.sh

                                                  ; Declare constants if needed
null equ 0                                        ; Reference: Jorgensen book 1.1.40, page 34.
newline equ 10

; Declare the names of programs called from this X86 source file, but whose own source code is not in this file.
extern printf                                     ; Reference: Jorgensen book 1.1.40, page48
extern scanf


global    area

section   .data
message1:                 db "welcome to your friendly area calculator", 10
message2:                 db "The main program will now call the area function", 10
message3:                 db "This program is brought to you by Kevin Lopez", 10
message4:                 db "Please enter the radius of a circle in whole number of meters: ", 0
farewell:                 db "The integer part of the area will be returned to the main program. Please enjoy your circles", 10, 0
currentValue:             dq 0 
promptforinteger1:        db "Enter the first signed integer: ", null
outputformat1:            db "The number received was %ld", 10, 0
stringoutputformat:       db "%s", 0
signedintegerinputformat: db "%ld", null
promptforinteger2:        db "Enter the second signed integer: ", 0
areaanswer:               db "The area of a circle with this radius is %ld", 0
metersanswer:             db " and %ld/7 meters", 10, 0

segment .bss                                                ; Uninitialized data are declared in this segment


section   .text                                             ; Where my code starts
area:


;Back up the general purpose registers for the sole purpose of protecting the data of the caller.
push rbp                                                    ; Backup rbp
mov  rbp,rsp                                                ; The base pointer now points to top of stack
push rdi                                                    ; Backup rdi
push rsi                                                    ; Backup rsi
push rdx                                                    ; Backup rdx
push rcx                                                    ; Backup rcx
push r8                                                     ; Backup r8
push r9                                                     ; Backup r9
push r10                                                    ; Backup r10
push r11                                                    ; Backup r11
push r12                                                    ; Backup r12
push r13                                                    ; Backup r13
push r14                                                    ; Backup r14
push r15                                                    ; Backup r15
push rbx                                                    ; Backup rbx
pushf                                                       ; Backup rflags
push qword -1                                               ; Now the number of pushes is even


                                                            ; PRINT OUT THE WELCOME MESSAGE
          mov       rax, 1
          mov       rdi, 1
          mov  rsi, message3
          mov      rdx, 46
          syscall

          ;Prompt for the first integer
          mov qword rdi, stringoutputformat                 ; Place the address of the prompt into rsi
          mov qword rsi, message4
          mov qword rax, 0
          call printf

                                                            ; Input the first integer
          mov qword rdi, signedintegerinputformat
          push qword -1                                     ; Place an arbitrary value on the stack; -1 is ok, any quad value will work
          mov qword rsi, rsp                                ; Now rsi points to that dummy value on the stack
          mov qword rax, 0                                  ; No vector registers
          call scanf                                        ; Call the external function; the new value is placed into the location that rsi points to
          pop qword r14                                     ; First inputted integer is saved in r14


                                                            ; Output the value previously entered
          mov qword rdi, outputformat1
          mov qword rsi, r14
          mov qword rdx, r14                                ; Both rsi and rdx hold the inputted value as well as r14
          mov qword rax, 0
          call printf
                                                            ; first I want to divide the quotent so i can use it as PI


          jmp divisionsection
          divisionsection:
          mov qword rax, 22                                 ; The first integer is in rax
          mov qword r15, 7                                  ; put the denominator in r15
          cqo
          idiv r15                                          ; Divide rdx:rax by denominator
          mov r13, qword rdx                                ; Keep the remainder inside of r13



                                                            ; This is where we find the circumference
          imul qword r14, r14                               ; squaring r14, so r14 = 36
          imul rax, r14                                     ; rax had 3 so 3x36 is 109, and it gets put into rax
          mov qword r9, rax                                 ; backed up rax into r9 because rax was going to get divided and modified
                                                           
                                                            ; now we need to add 36*remainder
          mov qword rax, r14                                ; we put r14 into rax
          cqo
          idiv r15                                          ; dividing rax by r15 (7)
                                                            ; r14 has the 36, r13 has the remainder, so we should get 5.14ish
                                                            ; the 5 will be put into r14


          add qword rax, r9                                 ; adding the remainder area to the main area
          mov [currentValue], rax

                                                            ; printing out the number
          mov qword rdi, areaanswer                         ; format
          mov qword rsi, rax                                ; Copy the area to rsi
          mov qword rdx, rax                                ; Copy the area to rdx
          mov qword rax, 0
          call printf

                                                            ; printing out the extra meters
          mov qword rax, r14                            
          mov qword r13, 7
          cqo
          idiv r13                                          ; divide by r13 (7), will get me the remainder
          mov r13, rdx

          mov qword rdi, metersanswer                       ; print out the meter remainder
          mov qword rsi, r13
          mov qword rdx, r13
          mov qword rax, 0
          call printf

                                                            ; printing out farwell message
          mov qword rdi, farewell                           ; passing string
          mov qword rax, 0
          call printf

          ; Restore the original values to the general registers before returning to the caller.
          pop rax                                           ; Remove the extra -1 from the stack
          popf                                              ; Restore rflags
          pop rbx                                           ; Restore rbx
          pop r15                                           ; Restore r15
          pop r14                                           ; Restore r14
          pop r13                                           ; Restore r13
          pop r12                                           ; Restore r12
          pop r11                                           ; Restore r11
          pop r10                                           ; Restore r10
          pop r9                                            ; Restore r9
          pop r8                                            ; Restore r8
          pop rcx                                           ; Restore rcx
          pop rdx                                           ; Restore rdx
          pop rsi                                           ; Restore rsi
          pop rdi                                           ; Restore rdi
          pop rbp                                           ; Restore rbp

          mov word rax, [currentValue]
          ret                                               ; Pop the integer stack and jump to the address represented by the popped value.