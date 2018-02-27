######################################################################
## Fichero: Alcance.asm
## Descripción: Programa que...
## Fecha última modificación: 28/03/17
## Autores: Manuel Salvador y Adrian Caballero.
## Asignatura: E.C. 1º grado
## Grupo de Prácticas: 2111
## Grupo de Teoría: 211/210
## Práctica: 4
## Ejercicio: 2
######################################################################

.text
main:	  
	lw $s5, lut
	lw $t2, angulo
	la $sp, 0x4000	
	addi $sp, $sp, -4 
	sw $t2, 0($sp)
	jal calculaAlcance
	lw $t7, 0($sp)
	addi $sp, $sp, 4
	sw $t7, resultado
	jal bucle
	
bucle: j bucle
	
		
calculaAlcance: 
	lw $s0, 0($sp)
	sll $t4, $s0, 2
	lw $t6, lut($t4) 
	sw $t6, 0($sp)
	jr $ra

.data
lut: .word 0, 9, 17, 26, 35, 43, 52, 60, 69, 77, 86, 94, 102, 110, 117, 125, 132, 140, 147, 154, 161, 167, 174, 180, 186, 192, 197, 202, 207, 212, 217, 221, 225, 228, 232, 235, 238, 240, 243, 245, 246, 248, 249, 260, 260 # Faltan los valores correspondientes a los ángulos 41, 42, 43, 44 y 45 grados.
angulo: .word 10
resultado: .word 0 
