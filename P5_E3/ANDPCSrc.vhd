----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Manuel Salvador
-- 
-- Create Date:    23:47:02 04/24/2017 
-- Design Name: 
-- Module Name:    ANDPCSrc - Behavioral 
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


entity ANDPCSrc is
    port ( 
				Entrada1 : in  std_logic;
				Entrada2: in std_logic;
				Salida : out  std_logic
			 );
end ANDPCSrc;

architecture Behavioral of ANDPCSrc is

begin
	
	Salida <= Entrada1 and Entrada2;

end Behavioral;

