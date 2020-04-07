;IRslope.asm
; Runs on any Cortex M

       .thumb
       .text
       .align 2
       .global Convert	//liked with converrt.asm
       .global main


Inputs .long 2000,2733,3466,4199,4932,5665,6398,7131,7864,8597,9330,10063,10796,11529, 12262,12995
Expect .long 800,713,496,380,308,259,223,196,175,158,144,132,122,114,106,100


main:  .asmfunc
     MOV R4, #0          ; R4 = 0 = Correct    (0 <= error < 1) or (-1 < error <= 0)
     MOV R5, #0          ; R5 = 0 = OffByOne   (1 <= error < 2) or (-2 < error <= -1)
     MOV R6, #0          ; R6 = 0 = Errors     (2 <= error    ) or (     error <= -2)
     MOV R7, #16         ; counter
     LDR R10, InputsAddr ; R10 = &Inputs (pointer
     LDR R11, ExpectAddr ; R11 = &Expect (pointer)
Test LDR R0, [R10],#4    ; input value
     BL  Convert         ; R0 = Convert()
     LDR R1, [R11],#4    ; R1 = Expect[index] (value)
     SUB R2, R0, R1      ; Convert(Inputs[index]) - Expect[index]
     CMP R2, #0          ; is Convert(Inputs[index]) - Expect[index] (R2) == 0
     BEQ OK
     CMP R2, #1          ; is Convert(Inputs[index]) - Expect[index] (R2) == 1
     BEQ One
     CMN R2, #1          ; is Convert(Inputs[index]) - Expected[index] (R2) == -1
     BEQ One
     ADD R6, R6, #1      ; Error = Error + 1
     B   Done
OK   ADD R4, R4, #1      ; Correct = Correct + 1
     B   Done
One  ADD R5, R5, #1      ; OffByOne = OffByOne + 1
Done SUBS R7, R7, #1
     BNE Test
loop B  loop             ; stall here and observe the registers
    .endasmfunc
ExpectAddr .field Expect,32
InputsAddr .field Inputs,32
    .end
