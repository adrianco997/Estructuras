-----------------------------------------------
-----------------------------------------------
-- Fichero:  		MicroSuma.vhd                              
-- Descripción:	Microprocesador                             
--                                                                                                                           
-- Última modificación:  2017-03-14                                                                                                                                                                                                                                                                                           
-- Pareja:6                                                                                            
-- Autores: Manuel Salvador   
--                                                                                                                                   
-- Asignatura: E.C. 1º grado                                     
-- Grupo de Prácticas:    2101                                                                                     
-- Grupo de Teoría: 210-211                                                                                   
-- Práctica:   3                                                                                                                                                             
-----------------------------------------------
-----------------------------------------------
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.ALL;
 
entity ALUMIPS is
	port (
         Op1 : in std_logic_vector (31 downto 0);
         Op2 : in std_logic_vector (31 downto 0);
         ALUControl : in std_logic_vector (2 downto 0);
         Res : out std_logic_vector (31 downto 0);
         Z : out std_logic
                );
end ALUMIPS;
-----------------------------------------------
--PRACTICA                                            
-----------------------------------------------
architecture Practica of ALUMIPS is

signal sltAux : std_logic_vector(31 downto 0);
signal resOUT : std_logic_vector(31 downto 0);
signal rest : std_logic_vector(31 downto 0);

begin
rest <= (Op1 - Op2);
 
procesoSLT: process (Op1, Op2, rest)
	begin  
		if (Op1(31) = '0' and Op2(31) = '1') then 				-- Proceso en el que realizamos
			sltAux <= x"00000000";			--comparando los bits mas significativos del
		elsif (Op1(31) = '1' and Op2(31) = '0') then			-- y según el valor de cada 
			sltAux <= x"00000001";
		else
			if rest(31) = '1' then 
				sltAux <= x"00000001";
				else 
					sltAux <= x"00000000";
				end if;
			end if;
	end process;   

	
  with ALUControl select
  resOUT <=		(Op1 + Op2)				when "010", -- Asignamos la señal a la diferente operacion segun el valor de ALUcontrol
					(Op1 - Op2)				when "110", -- Asignamos la señal a la diferente operacion segun el valor de ALUcontrol
					(Op1 and Op2)			when "000", -- Asignamos la señal a la diferente operacion segun el valor de ALUcontrol
					(Op1 or Op2)			when "001", -- Asignamos la señal a la diferente operacion segun el valor de ALUcontrol
					(Op1 nor Op2)			when "101", -- Asignamos la señal a la diferente operacion segun el valor de ALUcontrol
					 sltAux					when "111", -- Asignamos la señal a la diferente operacion segun el valor de ALUcontrol
					 x"00000000"			when others;
					 
					 
	Res <= resOUT;				 
	Z <= '1' when (resOUT = x"000000000") else '0';	
--                                  -----------------
--                                  |       |  op2  |
--                                  | resta |-------|
--                                  |       | + | - |
--                                  |-------|---|---|
--                                  |   | + |res| 0 |
--                                  |op1|---|---|---|
--                                  |   | - | 1 |res|
--                                  |---------------|            
end Practica;
