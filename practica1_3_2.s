/********************************************************************
*Write a program in NIOS II assembly language 
*that computes the Fibonacci series of the first
*8 numbers (0, 1, 1, 2, 3, 5, 8, 13). 
*Note that the first two numbers are 0, 1.
********************************************************************/


.global _start

_start: movia sp,0x800000
        ldw r2,datos(r0)
        ldw r3,datos+4(r0)
        ldw r4,datos+8(r0)
        call suma3

fin: br fin

suma2:	add r2, r2, r3
        ret

suma3: 	addi sp, sp, -4
		stw ra, 0(sp)
		call suma2
		add r3, r4, r0
		call suma2
		ldw ra, 0(sp)
		addi sp, sp, 4
		ret

		.org 0x1000
datos:	.word 5,6,7
		.end
