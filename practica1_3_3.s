/********************************************************************
* This program demonstrates the use of parallel ports in the DE2 Basic 
Computer:
* Given N an integer value stored in memory address 0xf0, 
* design an assembler program that stores in memory, from address 0x100, 
* a vector of words formed by the first N-even numbers.
*********************************************************************/

.Text
global_start
_start: 
		ldw r2, N(r0)
		movia r3,DATA +8 /* Direccion del siguiente elemento*/
		addi r4, r0 ,r0 
		addi r5, r0 ,1
		addi r2, r2 ,-2

LOOP: 	blt  r2, r0,fin
	    add  r6, r4, r5
	    stw  r6, 0(r3)
	    addi r2, r2, 1
	    addi r3, r3, 4
	    add  r4, r5, r0
	    add  r5, r6, r0
	    br LOOP

fin:    br fin

.data
N : .word 8
DATA:  .Word 0,1

