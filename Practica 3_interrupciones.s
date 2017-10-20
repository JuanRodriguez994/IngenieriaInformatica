.global _start
_start:
	movia sp, 0x007FFFFC /* inicializar pila */

	movia r2, 0x10000050 /* inic máscara de interrup botones */
	movi r3, 0b1110
	stwio r3, 8(r2)
	
	movi r2, 0b010 /* habilitar interrupciones de los botones*/
	wrctl ienable, r2
	
	movi r2, 1 /* habilitar interrupciones del procesador */
	wrctl status, r2
	
	movia r2, 0x10000020 /* dir base displays */
	addi r6, r0, 0x3F /* valor inicial 0 del display */
	stwio r6, 0(r2) /* mostrar en el display */

IDLE: br IDLE /* el prog no hace nada más */

/*Sección Reset: es ubicada en la zona especificada cuando se carga la
descripción del procesador en la placa. Por defecto esta dirección es la
0x00000000. Mediante "ax" se indica que la sección es "allocatable" y
"executable" */

.section .reset, “ax”
				 movia r2, _start
				 jmp r2

/* Sección Exceptions: es ubicada en la zona especificada cuando se 
carga la descripción del procesador en la placa. Por defecto esta 
dirección es la 0x00000020. Mediante "ax" se indica que la sección 
es "allocatable" y "executable" */

.section .exceptions, “ax”
.global EXCEPTION_HANDLER
EXCEPTION_HANDLER:

	subi sp, sp, 4 /* guardar et en la pila */
	stw et, 0(sp)
	rdctl et, ctl4 /* cargar interrup pendientes */

	beq et, r0, NO_EXT /* no int externa=> finalizar*/
	subi ea, ea, 4 /*int externa => decrementar ea */
	subi sp, sp, 12 /* guardar registros en la pila */
	stw ea, 0(sp)
	stw ra, 4(sp)
	stw r2, 8(sp)

	andi r2, et, 0b10 /* existe interrup de botones? */
	beq r2, r0, FIN /* no? => deshacer y retornar */

	call BOTON /* sí? => tratarla */


FIN: 	ldw ea, 0(sp) /* recuperar TODOS regs de la pila */
		ldw ra, 4(sp)
		ldw r2, 8(sp)
		addi sp, sp, 12

NO_EXT: ldw et,0(sp)
        addi sp,sp,4
		eret


. global BOTON
BOTON: subi sp, sp, 24 /* guardar regs en la pila */
	   stw ra, 0(sp)
	   stw r3, 4(sp)
	   stw r4, 8(sp)
	   stw r5, 12(sp)
	   stw r6, 16(sp)
	   stw r2, 20(sp)
	   movia r2, 0x10000020 /* dir base displays */
	   movia r3, 0x10000050 /* dir base botones */

	   ldwio r4, 0xC(r3) /*leer estado botones. OJO: 0xC */

	   stwio r0, 0xC(r3) /* reiniciar la interrupción */

	   addi r5, r0, 2 /* hay botón pulsado ?*/
	   beq r4, r5, BOTON_1

	   slli r5, r5, 1
	   beq r4, r5, BOTON_2

	   slli r5, r5, 1
	   beq r4, r5, BOTON_3

	   br MOSTRAR /* Si todo va bien por aquí no pasa nunca*/

	   BOTON_1: addi r6, r0, 0x6 /* r6=valor a mostrar */
			    br MOSTRAR

	   BOTON_2: addi r6, r0, 0x5B
				br MOSTRAR

	   BOTON_3: addi r6, r0, 0x4F
       
       MOSTRAR: stwio r6, 0(r2) /* mostrar en el display */

				ldw ra, 0(sp) /* recuperar regs de la pila */
				ldw r3, 4(sp)
				ldw r4, 8(sp)
				ldw r5, 12(sp)
				ldw r6, 16(sp)
				ldw r2, 20(sp)
				addi sp, sp, 24
				ret
.end