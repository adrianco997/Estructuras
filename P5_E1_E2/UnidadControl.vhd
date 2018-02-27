-- Fichero: UnidadControl.vhd
-- Descripción: para la memoria de programa para el MIPS
-- Fecha última modificación: 16/04/2017

-- Autores: Manuel Salvador y Adrián Caballero.
-- Asignatura: EC 1º grado
-- Grupo de Prácticas: 2191
-- Grupo de Teoría: 211/210
-- Práctica: 5
-- Ejercicio: 2


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;	


entity UnidadControl is
    Port ( OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
           Funct : in  STD_LOGIC_VECTOR (5 downto 0);
           Jump : out  STD_LOGIC;
           RegToPC : out  STD_LOGIC;
           Branch : out  STD_LOGIC;
           PcToReg : out  STD_LOGIC;
           MemToReg : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           ALUSrc : out  STD_LOGIC;
           ALUControl : out  STD_LOGIC_VECTOR (2 downto 0);
           RegDest : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           ExtCero : out  STD_LOGIC
		 );
end UnidadControl;

architecture Behavioral of UnidadControl is

begin

process(OpCode,Funct)
	begin
	
	--Caso J
		if OpCode = "000010" then
		
			Jump <= '1';
			RegToPC <= '0';
			Branch <= '0';
			PcToReg <= '0';
			MemToReg <= '0';
			MemWrite <= '0';
			ALUSrc <= '0';
			ALUControl <= "000";
			RegDest  <= '0';
			RegWrite <= '0';
			ExtCero <= '0';

		end if;
		
	--Caso Jal
		if OpCode = "000011" then
		
			Jump <= '1';
			RegToPC <= '0';
			Branch <= '0';
			PcToReg <= '1';
			MemToReg <= '0';
			MemWrite <= '0';
			ALUSrc <= '0';
			ALUControl <= "000";
			RegDest  <= '0';
			RegWrite <= '1';
			ExtCero <= '0';

		end if;
		
	--Caso beq
		if OpCode = "000100" then
		
			Jump <= '0';
			RegToPC <= '0';
			Branch <= '1';
			PcToReg <= '0';
			MemToReg <= '0';
			MemWrite <= '0';
			ALUSrc <= '0';
			ALUControl <= "110";
			RegDest  <= '0';
			RegWrite <= '0';
			ExtCero <= '0';

		end if;	
		
	--Caso addi -- MIRAR PRACTICA ANTERIOR Y ENLAZAR LOS ARCHIVOS

		if OpCode = "001000" then
		
			Jump <= '0';
			RegToPC <= '0';
			Branch <= '0';
			PcToReg <= '0';
			MemToReg <= '0';
			MemWrite <= '0';
			ALUSrc <= '1';
			ALUControl <= "010";     --YA MIRADO  
			RegDest  <= '0';
			RegWrite <= '1';
			ExtCero <= '0';

		end if;
		
		--Caso ori -- MIRAR PRACTICA ANTERIOR Y ENLAZAR LOS ARCHIVOS
		
		if OpCode = "001101" then
		
			Jump <= '0';
			RegToPC <= '0';
			Branch <= '0';
			PcToReg <= '0';
			MemToReg <= '0';
			MemWrite <= '0';
			ALUSrc <= '1';
			ALUControl <= "001";     --YA MIRADO  
			RegDest  <= '0';
			RegWrite <= '1';
			ExtCero <= '1';

		end if;
		
		--andi
		
		if OpCode = "001100" then
		
			Jump <= '0';
			RegToPC <= '0';
			Branch <= '0';
			PcToReg <= '0';
			MemToReg <= '0';
			MemWrite <= '0';
			ALUSrc <= '1';
			ALUControl <= "000";     --YA MIRADO  
			RegDest  <= '0';
			RegWrite <= '1';
			ExtCero <= '1';

		end if;
		
		--Caso lw
		if OpCode = "100011" then
		
			Jump <= '0';
			RegToPC <= '0';
			Branch <= '0';
			PcToReg <= '0';
			MemToReg <= '1';
			MemWrite <= '0';
			ALUSrc <= '1';
			ALUControl <= "010";     --YA MIRADO  
			RegDest  <= '0';
			RegWrite <= '1';
			ExtCero <= '0';

		end if;
		
		--Caso sw
		
		if OpCode = "101011" then
		
			Jump <= '0';
			RegToPC <= '0';
			Branch <= '0';
			PcToReg <= '0';
			MemToReg <= '0';
			MemWrite <= '1';
			ALUSrc <= '1';
			ALUControl <= "010";     --YA MIRADO 
			RegDest  <= '0';
			RegWrite <= '0';
			ExtCero <= '0';

		end if;
		
		--Caso slti
		
		if OpCode = "001010" then
		
			Jump <= '0';
			RegToPC <= '0';
			Branch <= '0';
			PcToReg <= '0';
			MemToReg <= '0';
			MemWrite <= '0';
			ALUSrc <= '1';
			ALUControl <= "111";     --YA MIRADO 
			RegDest  <= '0';
			RegWrite <= '1';
			ExtCero <= '0';

		end if;
		
		--A PARTIR DE AQUI SON R-type 
		
		if OpCode = "000000" then 
			
			--Caso nor
			
			if Funct = "100111" then 
			
				Jump <= '0';
				RegToPC <= '0';
				Branch <= '0';
				PcToReg <= '0';
				MemToReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '0';
				ALUControl <= "101";     --YA
				RegDest  <= '1';
				RegWrite <= '1';
				ExtCero <= '0';
				
			end if;
			
			--Caso jr
			
			if Funct = "001000" then 
			
				Jump <= '0';
				RegToPC <= '1';
				Branch <= '0';
				PcToReg <= '0';
				MemToReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '0';
				ALUControl <= "101";     --ME DA IGUÁ
				RegDest  <= '0';
				RegWrite <= '0';
				ExtCero <= '0';
				
			end if;
			
			--Caso add
			
			if Funct = "100000" then 
			
				Jump <= '0';
				RegToPC <= '0';
				Branch <= '0';
				PcToReg <= '0';
				MemToReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '0';
				ALUControl <= "010";     --SUMA
				RegDest  <= '1';
				RegWrite <= '1';
				ExtCero <= '0';
				
			end if;
			
			--Caso resta			
			
			if Funct = "100010" then 
			
				Jump <= '0';
				RegToPC <= '0';
				Branch <= '0';
				PcToReg <= '0';
				MemToReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '0';
				ALUControl <= "110";     --RESTA
				RegDest  <= '1';
				RegWrite <= '1';
				ExtCero <= '0';
				
			end if;
			
			--Caso or
			
			if Funct = "100101" then 
			
				Jump <= '0';
				RegToPC <= '0';
				Branch <= '0';
				PcToReg <= '0';
				MemToReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '0';
				ALUControl <= "001";     --OR
				RegDest  <= '1';
				RegWrite <= '1';
				ExtCero <= '0';
				
			end if;	
				
			--Caso and

			if Funct = "100100" then 
			
				Jump <= '0';
				RegToPC <= '0';
				Branch <= '0';
				PcToReg <= '0';
				MemToReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '0';
				ALUControl <= "000";     --AND
				RegDest  <= '1';
				RegWrite <= '1';
				ExtCero <= '0';
				
			end if;		
			
			--Caso slt
			
			if Funct = "101010" then 
			
				Jump <= '0';
				RegToPC <= '0';
				Branch <= '0';
				PcToReg <= '0';
				MemToReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '0';
				ALUControl <= "111";     
				RegDest  <= '1';
				RegWrite <= '1';
				ExtCero <= '0';
				
			end if;	
				
		end if;							
		
	end process;	

end Behavioral;