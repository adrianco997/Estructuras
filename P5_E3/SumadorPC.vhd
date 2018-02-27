----------------------------------------------------------------------------------
-- Company:  
-- Engineer: Manuel Salvador
-- 
-- Create Date:    23:56:19 04/24/2017 
-- Design Name: 
-- Module Name:    SumadorPC - Behavioral 
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


entity SumadorPC is
    Port ( 
				Entrada : in  std_logic_vector(31 downto 0);
				Salida : out  std_logic_vector(31 downto 0)
			 );
end SumadorPC;

architecture Behavioral of SumadorPC is
begin

	Salida <= Entrada + X"4";

end Behavioral;

