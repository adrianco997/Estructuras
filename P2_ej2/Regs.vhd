-- Fichero:					MicroSuma.vhd			--
-- Descripción: 			Microprocesador 		--
--								(MIPS) simplificado	--
-- Última modificación:	2017-02-25				--
--															--
-- Pareja:					6  						--
-- Autores: 			*	Adrian Caballero		--
--							*	Manuel Salvador		--
-- Asignatura: 			E.C. 1º grado			--
-- Grupo de Prácticas: 	2101						--
-- Grupo de Teoría: 		210						--
-- Práctica: 				2							--
-- Ejercicio:				1							--
-----------------------------------------------
-----------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
entity Regs is port (
	Clk 	: in std_logic; 									-- Reloj(CLK)
	NRst 	: in std_logic; 									-- Reset asíncrono a nivel bajo
	RtIn 	: in std_logic_vector (31 downto 0); 		-- Dato de entrada RT
	RtAddr: in std_logic_vector (4  downto 0); 		-- Dirección RT
	RsAddr: in std_logic_vector (4  downto 0); 		-- Dirección RS
	RsOut : out std_logic_vector(31 downto 0));		-- Salida RS
end Regs;
architecture Practica of Regs is
	-- Tipo para almacenar los registros
	type regs_t is array (0 to 31) of std_logic_vector(31 downto 0);
	-- Esta es la señal que contiene los registros. El acceso es de la
	-- siguiente manera: regs(i) acceso al registro i, donde i es
	-- un entero. Para convertir del tipo std_logic_vector a entero se
	-- hace de la siguiente manera: conv_integer(slv), donde
	-- slv es un elemento de tipo std_logic_vector
	-- Registros inicializados a '0' 
	-- NOTA: no cambie el nombre de esta señal.
	signal regs : regs_t;
-----------------------------------------------
--							PRACTICA						--
-----------------------------------------------
begin
	RsOut <= regs(conv_integer(RsAddr));				-- Escritura del registro RT
	process(Clk, NRst) begin 								-- Lectura del registro RS
		if NRst = '0'	then 									-- Si el reset es 0 se asignal todo a 0
			for i in 0 to 31 loop
				regs(i) <= (others => '0');
			end loop;
		elsif rising_edge(Clk)then							-- Si hay un flanco de reloj y RtAddr /= 00000 se convierte la señal		
			if RtAddr /= "00000" then						-- RtAddr a 32 bits y se le asigna a RtIn
				regs(conv_integer(RtAddr)) <= RtIn;
			end if;
		end if;
	end process;
end Practica;