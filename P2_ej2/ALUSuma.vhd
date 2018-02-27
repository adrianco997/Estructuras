-----------------------------------------------
-----------------------------------------------
-- Fichero:					MicroSuma.vhd			--
-- Descripción: 			Microprocesador 		--
--								(MIPS) simplificado	--
-- Última modificación:	2017-03-04				--
--															--
-- Pareja:					6  						--
-- Autores: 			*	Adrian Caballero		--
--							*	Manuel Salvador		--
-- Asignatura: 			E.C. 1º grado			--
-- Grupo de Prácticas: 	2101						--
-- Grupo de Teoría: 		210						--
-- Práctica: 				2							--
-- Ejercicio:				2							--
-----------------------------------------------
-----------------------------------------------
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity ALUSuma is
	port (
		Op1 : in  std_logic_vector(31 downto 0); -- Operando 1
		Op2 : in  std_logic_vector(31 downto 0); -- Operando 2
		Res : out std_logic_vector(31 downto 0)  -- Resultado
	);
end ALUSuma;
-----------------------------------------------
--							PRACTICA						--
-----------------------------------------------
architecture Simple of ALUSuma is
begin
	Res(31 downto 0) = (Op1(31 downto 0) + Op2(31 downto 0)); -- (Op1 + Op2)=Res;
end Simple;