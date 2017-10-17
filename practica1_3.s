/********************************************************************
* This program demonstrates the use of parallel ports in the DE2 Basic 
* Computer:
* Given three integer values ​​stored from memory address 0x1000, 
* design an assembler program that sums the three values ​​and stores the result
* in the next word of memory. The program should use subroutines:
*
*1. SUMA_DOS: performs the operation r2 = r2 + r3.
*
*2. SUMA_TRES: performs the operation r5 = r2 + r3 + r4 by calling SUMA_DOS.
*
*3. Main program: performs the requested operation by calling SUMA_TRES.
*********************************************************************/

.global _start

_start: ldw r2,N(r0)
       movia r3, Buffer(r0)
       add r4, r0, r0

loop:  beq r2, r0, fin
       stw r4, 0(r3)
       addi r3, r3, 4
       addi r2, r1, -1
       addi r4, r4, 2
       br loop

fin:   br fin

       .org 0xf0
N:     .word 6
       .org 0x100
Buffer:.space 4

       .end
       
