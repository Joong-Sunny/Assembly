; Convert.asm
; Runs on any Cortex M

       .thumb
       .text
       .align 2
       .global Convert

;------------Convert------------
Convert:   .asmfunc
; put your solution here

 LDR R1, IRMax
 CMP R0, R1
 BHS OK
 MOV R0, #800
 B done

OK: LDR R1, IROffset
 ADD R2, R1, R0
 LDR R3, IRSlope
 SDIV R0, R3, R2


done: BX LR

      .endasmfunc
      .align 4

IRSlope  .field 1195172,32
IROffset .field -1058,32
IRMax    .field 2552,32

    .end
//////////////////////////////////////////
