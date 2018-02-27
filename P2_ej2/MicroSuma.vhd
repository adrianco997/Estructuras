--------------------------------------------------------
--------------------------------------------------------
-- Fichero:								MicroSuma.vhd			--
-- Descripción: 						Microprocesador 		--
--											(MIPS) simplificado	--
-- Fecha última modificación: 	2017-03-02				--
--																		--
-- Pareja:								6  						--
-- Autores: 							Adrian Caballero		--
--											Manuel Salvador		--
-- Asignatura: 						E.C. 1º grado			--
-- Grupo de Prácticas: 				2101						--
-- Grupo de Teoría: 					210						--
-- Práctica: 							2							--
-- Ejercicio:							2							--
--------------------------------------------------------
--------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.ALL;


entity MicroSuma is
	port (
		Clk 			: in  std_logic; 							-- Reloj (Clock)
		NRst 			: in  std_logic; 							-- Reset activo a nivel bajo
		MemProgAddr : out std_logic_vector(31 downto 0);-- Dirección para la memoria de programa
		MemProgData : in  std_logic_vector(31 downto 0) -- Código de operación
	);
end MicroSuma;


architecture Practica of MicroSuma is

------------------------------------------------------
--                SEÑALES AUXILIARES                --
------------------------------------------------------
	signal S1 : std_logic_vector(31 downto 0);      	--Señal auxiliar asignada al Operando 1	
	signal S2 : std_logic_vector(31 downto 0);       	--Señal auxiliar asignada al Operando 2
	signal S3 : std_logic_vector(31 downto 0);		 	--Señal auxiliar asignada a RtIn (Valor que toma el registro)
	signal S4 : std_logic_vector(31 downto 0);			--Señal auxiliar asignada a MemProgData(15) desde (31 downto 15) y desde (15 downto 0) S4 es igual a MemProgData(15 downto 0)
	
------------------------------------------------------
--                    COMPONENTES                   --
------------------------------------------------------
	component ALUSuma is
		port (
			Op1 	: in  std_logic_vector(31 downto 0); 	-- Operando
			Op2 	: in  std_logic_vector(31 downto 0); 	-- Operando
			Res 	: out std_logic_vector(31 downto 0)  	-- Resultado
		);			
	end component;
	
	component Regs is
		port (	
			Clk 	: in  std_logic; 								-- Reloj
			NRst 	: in  std_logic; 								-- Reset asíncrono a nivel bajo
			RtIn 	: in  std_logic_vector (31 downto 0); 	-- Dato de entrada RT
			RtAddr: in  std_logic_vector (4  downto 0); 	-- Dirección RT
			RsAddr: in  std_logic_vector (4 downto 0); 	-- Dirección RS
			RsOut : out std_logic_vector(31 downto 0) 	-- Salida RS
		); 
	end component;
	
------------------------------------------------------
--                     PRACTICA                     --
------------------------------------------------------
begin

	PortALUSuma: ALUSuma											-- Instanciamos el componente ALUSuma
		port map (
			Op1	=> S1,											-- Asignamos al operando 1 la señal auxiliar S1
			Op2	=> S2, 											-- Asignamos al operando 2 la señal auxiliar S2
			Res	=> S3);											-- Asignamos al Resultado  la señal auxiliar S3
			
	PortRegs: Regs													-- Instanciamos el componente Regs 
		port map (
			Clk	=> Clk, 											-- Se le asigna al Reloj(CLK) la señal Clk
			NRst	=> NRst,											-- A NRst (Reset) se le asigna la señal NRst 
			RtIn	=> S3,											-- A RtIn le asignamos la señal S3 
			RsOut	=> S1,											-- A RsOut (Salida del registro) se le asigna la señal S1 
			RtAddr=> MemProgData(20 downto 16),				-- Asignamos los 5 bits (20 downto 16) de MemProgData a RtAdress para la escritura sincrona
			RsAddr=> MemProgData(25 downto 21));			-- Se asigna a RsAddr los bits (25 downto 21) de MemProgData, da la dirección del registro	


	s4(31 downto 16)<=(others => MemProgData(15));		-- A los bits (31 downto 16) de la señal S4 se le asigna el bit más significativo de MemProgData
	s4(15 downto 0) <= MemProgData(15 downto 0);			-- Los bits(15 downto 0) de la señal S4 se les asignan los bits (15 downto 0) de MemProgData
------------------------------------------------------
--                     PROCESOS                     --
------------------------------------------------------
	process (Clk, NRst)
	begin	
		if NRst = '0'	then 										-- Si el reset es 0 ponemos todo a 0
			MemProgAddr <= (others => '0');
		elsif rising_edge(Clk) then 							-- En caso contrario si hay flanco de reloj asignamos a MemProgData S4+4
			MemProgAddr <= (S4 + 4);
		end if;
	end process;
end Practica;