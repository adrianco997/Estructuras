----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Manuel Salvador
-- 
-- Create Date:    10:06:56 04/25/2017 
-- Design Name: 
-- Module Name:    Multiplicador26 - Behavioral 
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

entity Multiplicador26 is
    port ( 
				Entrada : in  std_logic_vector(25 downto 0);
				Salida : out  std_logic_vector(27 downto 0)
			 );
end Multiplicador26;

architecture Behavioral of Multiplicador26 is
begin

	Salida <= Entrada(25 downto 0) & "00";

end Behavioral;

