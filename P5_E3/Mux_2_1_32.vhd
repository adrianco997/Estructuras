----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Manuel Salvador
-- 
-- Create Date:    23:15:53 04/24/2017 
-- Design Name: 
-- Module Name:    Mux_2_1_32 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;

entity Mux_2_1_32 is
    Port ( 
				Entrada1: in std_logic_vector(31 downto 0);
				Entrada2: in std_logic_vector(31 downto 0);
				Salida: out std_logic_vector(31 downto 0);
				Control: in std_logic
			 );
end Mux_2_1_32;

architecture Behavioral of Mux_2_1_32 is
begin

process (Control, entrada1, Entrada2)
	begin
		
		if (Control = '0') then 			--Según lo que valga la entrada Control el multiplexor
			Salida <= Entrada1;			--elige entre la primera entrada o
		elsif Control = '1' then 
			Salida <= Entrada2;			--la segunda entrada
		end if;
	end process;

end Behavioral;

