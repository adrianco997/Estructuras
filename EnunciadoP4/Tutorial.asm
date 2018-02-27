######################################################################
## Fichero: Tutorial.s
## Descripci�n: Ejemplo de un programa en ensamblador
## Fecha �ltima modificaci�n: 2016-03-07
## Autores: Alberto S�nchez (2012, 2016), �ngel de Castro (2014)
## Asignatura: E.C. 1� grado
## Grupo de Pr�cticas: 
## Grupo de Teor�a: 
## Pr�ctica: 4
## Ejercicio: 1
######################################################################

#############################
# Equivalente en C
# if (a < b) 
#	c = b;
# else
#	c = a;
# while (1);
#############################

.text # Comienzo de seccion de codigo de usuario
main:	lw $t0, a  # Cargar en registro $t0 la variable a. Aunque el formato est�ndar es lw $rt, imm($rs), se admiten variantes como lw $rt, label
	lw $t1, b # Cargar en registro $t1 la variable b
	slt $t2, $t0, $t1 # $t2 ser� 1 si a<b
	beq $t2, $zero, falso # Si $t2 es 0, entonces no se cumple a<b, nos vamos al else
	addi $t3, $t1, 0 # Rama principal del if, $t3 hace de variable c
	j finCondicion # Salto al final del bucle para que no se ejecute el else
falso:	addi $t3, $t0, 0 # Rama del else

finCondicion: sw $t3, c # Guardar en memoria el valor del registro $t3

bucle: j bucle
	
	
.data  # Comienzo de seccion de datos de usuario
.align 2 # Direccion alineada a palabra (multiplo de 2^2=4), no hace falta salvo que metamos a mano en .data una direcci�n que no sea m�ltiplo de 4
a: 3  # Variable a, ocupa una palabra. Tambi�n se podr�a poner a: .word 5, pero es redundante porque por defecto ocupa una palabra
b: 6  # Variable b
c: 0  # Variable c
# Se podr�a haber puesto a: .word 5, 6, 0 pero entonces no podr�amos hacer lw $t1, b. Habr�a que hacer lw $t1, a($t7) metiendo previamente un 4 en $t7


