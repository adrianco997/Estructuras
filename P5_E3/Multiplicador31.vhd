----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Manuel Salvador
-- 
-- Create Date:    10:10:51 04/25/2017 
-- Design Name: 
-- Module Name:    Multiplicador31 - Behavioral 
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
----------------------------------------------------------------------------------library IEEE;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;

entity Multiplicador31 is
    port ( 
				Entrada : in  std_logic_vector(31 downto 0);
				Salida : out  std_logic_vector(31 downto 0)
			 );
end Multiplicador31;

architecture Behavioral of Multiplicador31 is
begin

	Salida <= Entrada(29 downto 0) & "00";

end Behavioral;

