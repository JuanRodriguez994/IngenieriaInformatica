# Computer Engineering
## Projects from start to the .END

Here you will find all the data of the works and ideas of the passage through the faculty of informatics, both the works that complement the laboratories and the practices demonstrating that the knowledge that I learned settled in my mind and they were clear and understood demonstrating in these fragments of code as for example the one of the first practice:

The code is as follows:

/* Program that finds the largest number in a list of integers */
.equ LIST, 0x500		/* Starting address of the list */


.global _start


_start:

	movia r4, LIST		/* r4 points to the start of the list */
	ldw r5, 4(r4)		/* r5 is a counter, initialize it with n */
	addi r6, r4, 8		/* r6 points to the first number */
	ldw r7, (r6)		/* r7 holds the largest number found so far */

LOOP:

	subi r5, r5, 1		/* Decrement the counter */
	beq r5, r0, DONE	/* Finished if r5 is equal to 0 */
	addi r6, r6, 4		/* Increment the list pointer */
	ldw r8, (r6)		/* Get the next number */
	bge r7, r8, LOOP	/* Check if larger number found */
	add r7, r8, r0		/* Update the largest number found */
	br LOOP
	
DONE:
	
	stw r7, (r4)		/* Store the largest number into RESULT */
	
STOP:
	
	br STOP			/* Remain here if done */


.org 0x500

RESULT:  .skip 4		        /* Space for the largest number found */

N:   .word 7				/* Number of entries in the list */

NUMBERS:  .word 4, 5, 3, 6, 1, 8, 2	/* Numbers in the list */

.end


After that we proceeded with several exercises to test in the NIOS II that include a summation, the calculation of Fibonacci or the even numbers of a set.


# This is followed by Practice 2: Using the Input / Output System of a Computer

The code in the figures displays the values of the SW switches on the red LEDs, and the
pushbutton keys on the green LEDs. It also displays a rotating pattern on 7-segment
displays HEX3...HEX0 and HEX7...HEX4. This pattern is shifted to the right by using a
Nios II rotate instruction, and a delay loop is used to make the shifting slow enough to
observe. 

## Example Practica2_Ejemplo1.s

The pattern on the HEX displays can be changed to the values of the SW
switches by pressing any of pushbuttons KEY3, KEY2, or KEY1 (recall from section
2.1 that KEY0 causes a reset of the DE2 Basic Computer). When a pushbutton key is
pressed, the program waits in a loop until the key is released.


## Part 2. Using the JTAG-UART Series Interface

Their function is to first send an ASCII string to the JTAG UART, and then enter an
endless loop. In the loop, the code reads character data that has been received by the
JTAG UART, and echoes this data back to the UART for transmission. If the program
is executed by using the Altera Monitor Program, then any keyboard character that is
typed into the Terminal Window of the Monitor Program will be echoed back, causing
the character to appear in the Terminal Window.

### see the Practica2_Ejemplo2a.s, Practica2_Ejemplo2b.s
