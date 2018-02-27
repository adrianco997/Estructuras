----------------------------------------------------------------------
-- Fichero: MemDataVectores.vhd
-- Descripci�n: Plantilla para la memoria de datos para el MIPS
-- Fecha �ltima modificaci�n: 2017-03-27

-- Autores: Manuel Salvador y Adri�n Caballero
-- Asignatura: EC. 1� grado
-- Grupo de Pr�cticas: 
-- Grupo de Teor�a: 211/210
-- Pr�ctica: 5
-- Ejercicio: 1
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MemDataVectores is
	port (
		Clk : in std_logic;
		NRst : in std_logic;
		MemDataAddr : in std_logic_vector(31 downto 0);
		MemDataDataWrite : in std_logic_vector(31 downto 0);
		MemDataWE : in std_logic;
		MemDataDataRead : out std_logic_vector(31 downto 0)
	);
end MemDataVectores;

architecture Simple of MemDataVectores is

  -- 4 GB son 1 gigapalabras, pero el simulador no deja tanta memoria
  -- Dejamos 64 kB (16 kpalabras), usamos los 16 LSB
  type Memoria is array (0 to (2**14)-1) of std_logic_vector(31 downto 0);
  signal memData : Memoria;

begin

	EscrituraMemProg: process(Clk, NRst)
	begin
	if NRst = '0' then
		-- Se inicializa a ceros, salvo los valores de las direcciones que
		-- tengan un valor inicial distinto de cero (datos ya cargados en
		-- memoria de datos desde el principio)
		for i in 0 to (2**14)-1 loop
			memData(i) <= (others => '0');
		end loop;
		-- Cada palabra ocupa 4 bytes
	-------------------------------------------------------------
			memData(conv_integer(X"00002000")/4) <= X"00000006";	-- N:  6
			memData(conv_integer(X"00002004")/4) <= X"00000002";	-- A:  2
			memData(conv_integer(X"00002008")/4) <= X"00000004";	-- A:  4
			memData(conv_integer(X"0000200c")/4) <= X"00000006";	-- A:  6
			memData(conv_integer(X"00002010")/4) <= X"00000008";	-- A:  8
			memData(conv_integer(X"00002014")/4) <= X"0000000a";	-- A: 10
			memData(conv_integer(X"00002018")/4) <= X"0000000c";	-- A: 12
			memData(conv_integer(X"0000201c")/4) <= X"ffffffff";	-- B: -1
			memData(conv_integer(X"00002020")/4) <= X"fffffffb";	-- B: -5
			memData(conv_integer(X"00002024")/4) <= X"00000004";	-- B:  4
			memData(conv_integer(X"00002028")/4) <= X"0000000a";	-- B: 10
			memData(conv_integer(X"0000202c")/4) <= X"00000001";	-- B:  1
			memData(conv_integer(X"00002030")/4) <= X"fffffffb";	-- B: -5
		
	---------------------------------------------------------------------	
	elsif rising_edge(Clk) then
		-- En este caso se escribe por flanco de bajada para que sea
		-- a mitad de ciclo y todas las se�ales est�n estables
		if MemDataWE = '1' then
			memData(conv_integer(MemDataAddr)/4) <= MemDataDataWrite;
		end if;
	end if;
	end process EscrituraMemProg;

	-- Lectura combinacional siempre activa
	-- Cada vez se devuelve una palabra completa, que ocupa 4 bytes
	LecturaMemProg: process(MemDataAddr, memData)
	begin
		-- Parte baja de la memoria s� est�, se lee tal cual
		if MemDataAddr(31 downto 16)=X"0000" then
			MemDataDataRead <= MemData(conv_integer(MemDataAddr)/4);
		else -- Parte alta no existe, se leen ceros
			MemDataDataRead <= (others => '0');
		end if;
	end process LecturaMemProg;

end Simple;

