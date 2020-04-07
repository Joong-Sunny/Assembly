; main.s
; Runs on any Cortex M processor
; A very simple first project implementing a random number generator
; Daniel Valvano
; May 12, 2015


       .thumb
       .data
       .align 2
M      .space 4
n      .space 4
       .text
       .align 2
       .global  main
main:  .asmfunc
       MOV R0,#1       ; Initial seed
       BL  Seed        ; M=1
loop   BL  Rand
       LDR R1,nAddr
       STR R0,[R1]
       B   loop
       .endasmfunc

;------------Random------------
; Return R0= random number
; Linear congruential generator
; from Numerical Recipes by Press et al.
Seed: .asmfunc
      LDR R1,MAddr ; R1=&M
      STR R0,[R1]  ; set M
      BX  LR
      .endasmfunc
Rand: .asmfunc
      LDR R2,MAddr ; R2=&M, address of M
      LDR R0,[R2]  ; R0=M, value of M
      LDR R1,Slope
      MUL R0,R0,R1 ; R0 = 1664525*M
      LDR R1,Offst
      ADD R0,R0,R1 ; 1664525*M+1013904223
      STR R0,[R2]  ; store M
      LSR R0,#24   ; 0 to 255
      BX  LR
      .endasmfunc
MAddr .field M,32
Slope .field 1664525,32
Offst .field 1013904223,32
nAddr .field n,32

       .end
