######################################################################
## Fichero: Vectores.asm
## Descripción: Ejercicio 1 
## Fecha última modificación: 
## Autores: Manuel Salvador y Adrian Caballero
## Asignatura: E.C. 1º grado
## Grupo de Prácticas: 2111
## Grupo de Teoría: 211/210
## Práctica: 4
## Ejercicio: 1
######################################################################
.text 
main:
	la $t1, A 		#Leemos la direccion de memoria y la guarda en el registro
	la $t2, B		#Leemos la direccion de memoria y la guarda en el registro
	la $t3, C		#Leemos la direccion de memoria y la guarda en el registro
	lw $t4, N		#Leemos la variable del ejercicio (N) y la guarda en el registro
	add $t5, $zero, $zero
	
	
for: 	
	sll $t6, $t5, 2		#Se actualiza el registro t5 en funcion de t7
	
	add $s1, $t1, $t6	#Se introduce en el registro la direccion de A
	
	add $s2, $t2, $t6	#Se introduce en el registro s1 la variable B
	
	add $s3, $t3, $t6	#Se introduce en el registro s3 la variablede C
	
	
	lw $a1, ($s1)		#Se carga el dato contenio en el registro s0(A)
	
	lw $a2, ($s2)		#Se carga el dato contenio en el registro s0(A)
	
	sll $a2, $a2, 2		#Se multiplica por 4 el dato de a1
	add $a3, $a2, $a1	#Se suman A y B en el registro A2
	sw $a3, ($s3)		#Guardamos en el registro la posicion i
	
	addi $t5, $t5,  1
	slt $t7, $t4, $t5
	beqz $t7, for
	
bucle: j bucle

.data
A:  .word 2,2,4,6,5,6,7,8,9,10
.space 40
B:  .word -1, -5, 4, 10, 1, -2, 5, 10, -10, 0
.space 40

N: .word 10

C: .space 80
