----------------------------------------------------------------------
-- Fichero: MicroSuma.vhd
-- Descripci�n: 
-- Fecha �ltima modificaci�n: 

-- Autores: 
-- Asignatura: E.C. 1� grado
-- Grupo de Pr�cticas:
-- Grupo de Teor�a:
-- Pr�ctica: 2
-- Ejercicio: 2
----------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity MicroSuma is
	port (
		Clk : in std_logic; -- Reloj
		NRst : in std_logic; -- Reset activo a nivel bajo
		MemProgAddr : out std_logic_vector(31 downto 0); -- Direcci�n para la memoria de programa
		MemProgData : in std_logic_vector(31 downto 0) -- C�digo de operaci�n
	);
end MicroSuma;

architecture Practica of MicroSuma is


begin


end Practica;

