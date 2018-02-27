######################################################################
## Fichero: Ensamblador.asm
## Descripción: Programa que ensambla los datos pasados en la practica
## Fecha última modificación: 28/03/17
## Autores: Manuel Salvador y Adrián Caballero
## Asignatura: E.C. 1º grado
## Grupo de Prácticas: 2111
## Grupo de Teoría: 211/210
## Práctica: 4
## Ejercicio: 3
######################################################################
.text
main:		
	#0x8c012008 -> 100011 00000 00001 0010000000001000
	#Los 6 primeros bits nos dan la instruccion, los 10 siguientes los registros
	lw $1 0x2008($0)
	
	#0x00011200 -> 0000 0000 0000 0001 0001 0010 0000 0000
	#Los ultimos 6 bits nos dan la instruccion ya que los 6 ultimos primeros son 0 
	sll $2, $1, 8 
	
 	#0x8c03200c -> 1000 1100 0000 0011 0010 0000 0000 1100
 	#Los 6 primeros bits nos señalan la instruccion, los 10 siguientes los registro usados(5 cada uno) y el resto son los datos a usar
 	lw $3, 0x200c($0)
 	
 	#0x00432025 -> 0000 0000 0100 0011 0010 0000 0010 0101  
	#Los ultimos 6 bits nos dan la instruccion ya que los 6 ultimos primeros son 0 	
	or $4, $2, $3
 	
 	#0x20050005 -> 001000 00000 00101 0000 0000 0000 0101
	#Los 6 primeros bits nos señalan la instruccion, los 10 siguientes los registro usados(5 cada uno)
 	addi  $5, $0, 0x0005
 	
 	#0x0065302a -> 000000 00011 00101 00110 00000 101010
 	#Los ultimos 6 bits son la instruccion ya que los 6 primeros son 0.
 	slt $6, $3, $5
 	
 	#0x10c00002 -> 000100 00110 00000 00000 00000 000010
 	#Los 6 primeros bits nos señalan la instruccion, los 10 siguientes los registro usados(5 cada uno)
 	 beq $6, $0, E
 	 
 	 #0xac042004 -> 101011 00000 00100 00100 00000 000100
 	 #Los 6 primeros bits nos señalan la instruccion, los 10 siguientes los registro usados(5 cada uno)
 	 sw $4, 0x2004($0)
 	 
 	 #0x0800000a -> 000010 00000 00000 00000 00000 001010
 	 #Los 6 primeros bits nos señalan la instruccion, los 10 siguientes los registro usados(5 cada uno)
 	 j S
	 
 	 #0xac042000 -> 101011 00000 00100 00100 00000 000000
 	 #Los 6 primeros bits nos señalan la instruccion, los 10 siguientes los registro usados(5 cada uno)
 	 E:
 	 sw $4, 0x2000($0)
 	 S:
 	 #0x0800000a -> 000010 00000 00000 00000 00000 001010
 	 #Los 6 primeros bits nos señalan la instruccion, los 10 siguientes los registro usados(5 cada uno) el resto son los datos a usar
 	 j S
.data
 .word 0, 0, 52922, 5 
