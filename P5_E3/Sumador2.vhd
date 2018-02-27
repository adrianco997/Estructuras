----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Manuel Salvador
-- 
-- Create Date:    10:03:42 04/25/2017 
-- Design Name: 
-- Module Name:    Sumador2 - Behavioral 
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

entity Sumador2 is
    port ( 
				Entrada1: in std_logic_vector(31 downto 0);
				Entrada2: in std_logic_vector(31 downto 0);
				Salida : out std_logic_vector(31 downto 0) 
			 );
end Sumador2;

architecture Behavioral of Sumador2 is
begin

	Salida <= Entrada1 + Entrada2;

end Behavioral;

