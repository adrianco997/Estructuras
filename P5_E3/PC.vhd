----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Manuel Salvador
-- 
-- Create Date:    23:49:07 04/24/2017 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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


entity PC is
    port ( 
				Entrada : in  std_logic_vector(31 downto 0);
				Clk: in std_logic;
				NRst: in std_logic;
				Salida : out  std_logic_vector(31 downto 0)
			 );
end PC;

architecture Behavioral of PC is
begin

process(Clk)
	begin	
		if NRst = '0' then 
			Salida <= X"00000000";	
		elsif Clk = '1' and rising_edge(Clk) then 
			Salida <= Entrada;
		end if;	
end process;

end Behavioral;

