; Sin.asm
; Runs on any Cortex M


       .thumb
       .text
       .align 2
       .global Sin
IxTab .long 0, 13, 26, 38, 51, 64, 77, 90
      .long 102, 115, 128, 141, 154, 166, 179
      .long 192, 205, 218, 230, 243, 255, 256

IyTab .long 0, 39, 75, 103, 121, 127, 121, 103
      .long 75, 39, 0, -39, -75, -103, -121
      .long -127, -121, -103, -75, -39, 0, 0


Sin:   .asmfunc
       PUSH {R4-R6,LR}
       LDR  R1,IxTabAddr  ;find x1<=Ix<x2
       LDR  R2,IyTabAddr
lookx1 LDR  R6,[R1,#4] ;x2
       CMP  R0,R6      ;check Ix<x2
       BLO  found      ;R1 => x1
       ADD  R1,#4
       ADD  R2,#4
       B    lookx1
found  LDR  R4,[R1]    ;x1
       SUB  R4,R0,R4   ;Ix-x1
       LDR  R5,[R2,#4] ;y2
       LDR  R2,[R2]    ;y1
       SUB  R5,R2      ;y2-y1
       LDR  R1,[R1]    ;x1
       SUB  R6,R1      ;x2-x1
       MUL  R0,R4,R5   ;(y2-y1)*(Ix-x1)
       SDIV R0,R0,R6
       ADD  R0,R2      ;Iy
       POP {R4-R6,PC}
IxTabAddr .field IxTab,32
IyTabAddr .field IyTab,32
    .endasmfunc
    .end
