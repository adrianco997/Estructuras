
----------------------------------------------------------------------
-- Fichero: MemProgVectores.vhd
-- Descripción: para la memoria de programa para el MIPS
-- Fecha última modificación: 16/04/2017

-- Autores: Manuel Salvador y Adrián Caballero.
-- Asignatura: EC 1º grado
-- Grupo de Prácticas: 2191
-- Grupo de Teoría: 211/210
-- Práctica: 5
-- Ejercicio: 1
----------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity MemProgVectores is
	port (
		MemProgAddr : in std_logic_vector(31 downto 0); -- Dirección para la memoria de programa
		MemProgData : out std_logic_vector(31 downto 0) -- Código de operación
	);
end MemProgVectores;

architecture Simple of MemProgVectores is

begin

	LecturaMemProg: process(MemProgAddr)
	begin
		-- La memoria devuelve un valor para cada dirección.
		-- Estos valores son los códigos de programa de cada instrucción,
		-- estando situado cada uno en su dirección.
		case MemProgAddr is
		--------------------------------------------------------------
			when X"00000000" => MemProgData <= X"20092004";
			when X"00000004" => MemProgData <= X"200a201c";
			when X"00000008" => MemProgData <= X"200b2034";
			when X"0000000c" => MemProgData <= X"8c0c2000";
			when X"00000010" => MemProgData <= X"00006820";
			when X"00000014" => MemProgData <= X"01ad7020";
			when X"00000018" => MemProgData <= X"01ce7020";
			when X"0000001c" => MemProgData <= X"012e8820";
			when X"00000020" => MemProgData <= X"014e9020";
			when X"00000024" => MemProgData <= X"016e9820";
			when X"00000028" => MemProgData <= X"8e250000";
			when X"0000002c" => MemProgData <= X"8e460000";
			when X"00000030" => MemProgData <= X"00c63020";
			when X"00000034" => MemProgData <= X"00c63020";
			when X"00000038" => MemProgData <= X"00c53820";
			when X"0000003c" => MemProgData <= X"ae670000";
			when X"00000040" => MemProgData <= X"21ad0001";
			when X"00000044" => MemProgData <= X"018d782a";
			when X"00000048" => MemProgData <= X"11e0fff2";
			when X"0000004c" => MemProgData <= X"08000013";
			
			
			
		---------------------------------------------------------------------	
			
			when others => MemProgData <= X"00000000"; -- Resto de memoria vacía
		end case;
	end process LecturaMemProg;

end Simple;


