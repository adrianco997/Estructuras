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
	addi $t1, $0, 0x2004 		#2004 es la direccion de A y la metemos en t1  a traves de una suma 
	addi $t2, $0, 0x201c 		#201c es la direccion de B y la metemos en t2 a traves de una suma con el registro 0
	addi $t3, $0, 0x2034 			#2034 es la direccion de C y la metemos en t3 a traves de una suma con el registro 0
	lw $t4, N			#Leemos la variable del ejercicio (N) y la guarda en el registro
	add $t5, $zero, $zero
	
	
for: 	
	add $t6, $t5, $t5		#Se actualiza el registro t5 en funcion de t7
	add $t6, $t6, $t6
	
	add $s1, $t1, $t6	#Se introduce en el registro la direccion de A
	
	add $s2, $t2, $t6	#Se introduce en el registro s1 la variable B
	
	add $s3, $t3, $t6	#Se introduce en el registro s3 la variablede C
	
	
	lw $a1, ($s1)		#Se carga el dato contenio en el registro s0(A)
	
	lw $a2, ($s2)		#Se carga el dato contenio en el registro s0(A)
	
	add $a2, $a2, $a2	#Se multiplica por 4 el dato de a1
	add $a2, $a2, $a2
					
	add $a3, $a2, $a1	#Se suman A y B en el registro A2
	sw $a3, ($s3)		#Guardamos en el registro la posicion i
	
	addi $t5, $t5,  1
	slt $t7, $t4, $t5
	beq $t7, $0, for
	
bucle: j bucle

.data
N: .word 6

A:  .word 2, 4, 6, 8, 10, 12

B:  .word -1, -5, 4, 10, 1, -5

C: .space 24 #bytes que necesitamos para guardar 6 posiciones 6*4= 24
