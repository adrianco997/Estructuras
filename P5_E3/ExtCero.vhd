----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Manuel Salvador
-- 
-- Create Date:    10:13:19 04/25/2017 
-- Design Name: 
-- Module Name:    ExtCero - Behavioral 
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

entity ExtCero is
    port ( 
				Entrada : in  std_logic_vector(15 downto 0);
				Salida : out  std_logic_vector(31 downto 0)
			 );
end ExtCero;

architecture Behavioral of ExtCero is
begin

	Salida(31 downto 16) <= (others => '0');
	Salida(15 downto 0) <= Entrada(15 downto 0);
	
end Behavioral;

