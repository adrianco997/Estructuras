----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Manuel Salvador
-- 
-- Create Date:    18:47:10 04/22/2017 
-- Design Name: 
-- Module Name:    MicroMIPS - Behavioral 
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
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;


entity MicroMIPS is
	port (
		--ENTRADAS
		NRst : in std_logic; 									--Reset activo a nivel bajo
		Clk : in std_logic; 									-- Reloj (CLK)
		MemProgData : in std_logic_vector(31 downto 0); 		-- Entrada de memoria del programa
		MemDataDataRead: in std_logic_vector(31 downto 0); 		-- Entrada de la memoria de datos
		--SALIDAS
		MemDataWE: out std_logic; 								-- Señal que habilita la escritura en la memoria de datos
		MemProgAddr: out std_logic_vector(31 downto 0); 		--Direccion de memoria del programa
		MemDataAddr: out std_logic_vector(31 downto 0); 		--Direccion de la memoria de datos
		MemDataDataWrite: out std_logic_vector(31 downto 0) 	--Bus de escritura en la memoria
	);
end MicroMIPS;
	
architecture behavioral of MicroMIPS is
	
-------------------------------------
----------UNIDAD DE CONTROL----------
-------------------------------------
component UnidadControl
		port(
			OPCode: std_logic_vector(5 downto 0);
			Funct: in std_logic_vector(5 downto 0);
			MemToReg: out std_logic;
			MemWrite: out std_logic;
			Branch: out std_logic;
			ALUControl: out std_logic_vector(2 downto 0);
			ALUSrc: out std_logic;
			RegDest: out std_logic;
			RegWrite: out std_logic;
			RegToPC: out std_logic;
			ExtCero: out std_logic;
			Jump: out std_logic;
			PCToReg: out std_logic	
		);
end component;


--------------------------------------
----------BANCO DE REGISTROS----------
--------------------------------------
component RegsMIPS
	port (
			Clk : in std_logic; 								-- Reloj
			NRst : in std_logic; 							-- Reset asíncrono a nivel bajo
			A1 : in std_logic_vector(4 downto 0); 		-- Dirección para el puerto Rd1
			Rd1 : out std_logic_vector(31 downto 0); 	-- Dato del puerto Rd1
			A2 : in std_logic_vector(4 downto 0); 		-- Dirección para el puerto Rd2
			Rd2 : out std_logic_vector(31 downto 0); 	-- Dato del puerto Rd2
			A3 : in std_logic_vector(4 downto 0); 		-- Dirección para el puerto Wd3
			Wd3 : in std_logic_vector(31 downto 0); 	-- Dato de entrada Wd3
			We3 : in std_logic						-- Habilitación del banco de registros
		);
end component;


-----------------------
----------ALU----------
-----------------------
component ALUMIPS
	port (
			Op1 : in std_logic_vector (31 downto 0);
         Op2 : in std_logic_vector (31 downto 0);
         ALUControl : in std_logic_vector (2 downto 0);
         Res : out std_logic_vector(31 downto 0);
         Z : out std_logic
       );
end component;

---------------------------------
----------MULTIPLEXORES----------
---------------------------------

--Multiplexores: 4 y 5
component Mux_2_1_5
	port (
		Control: in std_logic;
		Entrada1: in std_logic_vector(4 downto 0);
		Entrada2: in std_logic_vector(4 downto 0);
		Salida: out std_logic_vector(4 downto 0)
		);
end component;

--Multiplexores: 1, 2, 3, 6, 7, 8, 9
component Mux_2_1_32
	port (
		Control: in std_logic;
		Entrada1: in std_logic_vector(31 downto 0);
		Entrada2: in std_logic_vector(31 downto 0);
		Salida: out std_logic_vector(31 downto 0)
		);
end component;

-----------------------------
----------SUMADORES----------
-----------------------------

--Sumador que suma 4 al PC
component SumadorPC
	port (
		Entrada: in std_logic_vector(31 downto 0);
		Salida: out std_logic_vector(31 downto 0)
		);
end component;

--Sumador2: Suma la salida del sumador 1 y la extension de signo despues de la multiplicacion
component Sumador2
	port (
			Entrada1: in std_logic_vector(31 downto 0);
			Entrada2: in std_logic_vector(31 downto 0);
			Salida: out std_logic_vector(31 downto 0)
			);
end component;

----------------------
----------PC----------
----------------------

-- PC
component PC
	port (
			Clk: in std_logic; 									--Reloj
			Nrst: in std_logic; 									--Reset activo a nivel bajo
			Entrada: in std_logic_vector(31 downto 0);
			Salida:out std_logic_vector(31 downto 0)
		);
end component;

-----------------------------------
----------MULTIPLICADORES----------
-----------------------------------

--Multiplicador 26 bits (Multiplica por 2 los 26 bits menos significativos)
component Multiplicador26
	port (
			Entrada: in std_logic_vector(25 downto 0);
			Salida: out std_logic_vector(27 downto 0)
		);
end component;

--Multiplicador 32 bits
component Multiplicador31
	port (
			Entrada: in std_logic_vector(31 downto 0);
			Salida: out std_logic_vector(31 downto 0)
		);
end component;

----------------------------
----------EXTENSOR----------
----------------------------

--Extensor de Signo
component ExtSigno
	port (
			Entrada: in std_logic_vector(15 downto 0);
			Salida: out std_logic_vector(31 downto 0)
		);
end component;

--Extensor de Cero
component ExtCero
	port (
			Entrada: in std_logic_vector(15 downto 0);
			Salida: out std_logic_vector(31 downto 0)
		);
end component;

----------------------------
----------ANDPCSrc----------
----------------------------
--Puerta and que calcula la señal de control PCSrc a partir de la señal
component ANDPCSrc
	port (
			Entrada1: in std_logic; 		--Entra el Branch
			Entrada2: in std_logic;			--La bandera Z de la ALU
			Salida: out std_logic
		);
end component;


--------------------------------------
----------SEÑALES AUXILIARES----------					He contado 37 pero hay que revisar por si he repetido alguna
--------------------------------------					Recuento me da de 35, al escribirlas en el programa ver si esta bien

--Señales de la Unidad Control
signal MemToRegSignal: std_logic;
signal MemWriteSignal: std_logic;
signal BranchSignal: std_logic;
signal ALUControlSignal: std_logic_vector(2 downto 0);
signal ALUSrcSignal: std_logic;
signal RegDestSignal: std_logic;
signal RegWriteSignal: std_logic;
signal RegToPCSignal: std_logic;
signal ExtCeroSignal: std_logic;
signal JumpSignal: std_logic;
signal PCToRegSignal: std_logic;
 

--Bandera Z que sale de la ALU y entra a la ANPCSrc
signal ZSignal: std_logic;

--Señal de la salida de la puerta ANDPCSrc
signal PCSrcSignal: std_logic;


	--Mul26 es el Multiplicador 26 de bits
	--Mul32 es el Multiplicador de 32 bits



----------MULTIPLEXORES DE 32 BITS----------
--Señales para los multiplexores de 32 bits, (todos menos el 4 y 5)
--La primera palabra indica a que multiplexor pertenece y la segunda indica a donde se dirige 
signal Mux1_Mux2: std_logic_vector(31 downto 0);
signal Mux2_Mux3: std_logic_vector(31 downto 0);
signal Mux3_PC: std_logic_vector(31 downto 0);
signal Mux6_Mux7: std_logic_vector(31 downto 0);
signal Mux7_ALU: std_logic_vector(31 downto 0);
signal Mux8_Mux9: std_logic_vector(31 downto 0);
signal Mux9_Wd3: std_logic_vector(31 downto 0);


----------MULTIPLEXORES DE 5 BITS----------
--Señales que conectan las salidas de los multiplexores de 5 bits con sus repectivos
signal Mux4_Mux5: std_logic_vector(4 downto 0);
signal Mux5_A3: std_logic_vector(4 downto 0);

----------ALU----------
--Señal que conecta la ALU con el multiplexor 8
signal MemDataAddrSignal: std_logic_vector(31 downto 0);



----------BANCO DE REGISTROS----------
--Señales de salida del banco de registro
signal Rd1_ALU_Mux3: std_logic_vector(31 downto 0);
signal Rd2_Mux7_MemDataDataWrite: std_logic_vector(31 downto 0);


----------MULTIPLICADORES----------
--Señal Multiplicador de 26 bits, Mul26 es el de 26 bits
signal Mul26_Mux2: std_logic_vector(27 downto 0);
 
--Señal Multiplicador de 32 bits, Mul32 es el de 32 bits
signal Mul32_Sumador2: std_logic_vector(31 downto 0);


----------SUMADORES----------
--Señal del sumadorPC:
signal SumaPC_Suma2_Mux1_Mux9: std_logic_vector(31 downto 0);

--Señal del sumador 2 
signal Suma2_Mux1: std_logic_vector(31 downto 0);


----------EXTENSION DE CERO----------
--Señal Extension de Cero
signal ExtCero_Mux6: std_logic_vector(31 downto 0);


----------EXTENSION DE SIGNO----------
--Señal Extension de Signo
signal ExtSigno_Mul31_Mux6: std_logic_vector(31 downto 0);


----------PC----------
--Señal de PC. La misma señal que le entra al primer sumador S1 por lo que no la ponemos
signal MemProgAddrSignal: std_logic_vector(31 downto 0);



begin
			--Ahora es cuando empezamos a instanciar cada componente y le asignamos sus respectivas señales 
			--Los Multiplexores estan numerados de izquierda a derecha segun el mapa

		
-----UNIDAD DE CONTROL-----		
UC: UnidadControl
	port map(
		     OpCode => MemProgData(31 downto 26),
           Funct => MemProgData(5 downto 0),
			  MemToReg => MemToRegSignal,
			  MemWrite => MemWriteSignal,
			  Branch => BranchSignal,
			  ALUControl => ALUControlSignal,
			  ALUSrc => ALUSrcSignal,
			  RegDest => RegDestSignal,
			  RegWrite => RegWriteSignal,
			  RegToPC => RegToPCSignal,
			  ExtCero => ExtCeroSignal,
			  Jump => JumpSignal,
           PcToReg => PcToRegSignal       
	);
	
-----REGISTRO-----		
Registro: RegsMIPS
	port map(
		Clk => Clk,
		NRst => NRst,
		A1 => MemProgData(25 downto 21),
		Rd1 => Rd1_ALU_Mux3,
		A2 => MemProgData(20 downto 16),
		Rd2 => Rd2_Mux7_MemDataDataWrite,
		A3 => Mux5_A3,
		Wd3 => Mux9_Wd3,
		We3 => RegWriteSignal	
	);

-----ALU-----
ALU: ALUMIPS
	port map(
		Op1 => Rd1_ALU_Mux3,
		Op2 => Mux7_ALU,
		ALUControl => ALUControlSignal,
		Res =>  MemDataAddrSignal,
		Z => ZSignal
	);

	--Los multiplexores estan ordenados de izquierda a derecha desde el mapa del procesador
	
Multiplexor1: Mux_2_1_32
	port map(
		Entrada1 => SumaPC_Suma2_Mux1_Mux9,
		Entrada2 => Suma2_Mux1, 						--Sumador 2
		Salida => Mux1_Mux2,
		Control => PCSrcSignal
	);
	
Multiplexor2: Mux_2_1_32
	port map(
		Entrada1 => Mux1_Mux2,
		Entrada2(31 downto 28) => SumaPC_Suma2_Mux1_Mux9(31 downto 28),
		Entrada2(27 downto 0) => Mul26_Mux2,		--Multiplicador 26 bits 
		Salida => Mux2_Mux3,
		Control => JumpSignal
	);

Multiplexor3: Mux_2_1_32
	port map(
		Entrada1 => Mux2_Mux3,
		Entrada2 => Rd1_ALU_mux3,
		Salida => Mux3_PC,
		Control => RegToPCSignal
	);
	
Multiplexor4: Mux_2_1_5
	port map(
		Entrada1 => MemProgData(20 downto 16),
		Entrada2 => MemProgData(15 downto 11),
		Salida => Mux4_Mux5,
		Control => RegDestSignal
	);

Multiplexor5: Mux_2_1_5
	port map(
		Entrada1 => Mux4_Mux5,
		Entrada2 => "11111",
		Salida => Mux5_A3,
		Control => PCToRegSignal
	);

Multiplexor6: Mux_2_1_32
	port map(
		Entrada1 => ExtSigno_Mul31_Mux6,
		Entrada2 => ExtCero_Mux6,
		Salida => Mux6_Mux7,
		Control => ExtCeroSignal
	);
	
Multiplexor7: Mux_2_1_32
	port map(
		Entrada1 => Rd2_Mux7_MemDataDataWrite,
		Entrada2 => Mux6_Mux7,
		Salida => Mux7_ALU,
		Control => ALUSrcSignal
	);
	
Multiplexor8: Mux_2_1_32
	port map(
		Entrada1 => MemDataAddrSignal,
		Entrada2 => MemDataDataRead,
		Salida => Mux8_Mux9,
		Control => MemToRegSignal
	);

Multiplexor9: Mux_2_1_32
	port map(
		Entrada1 => Mux8_Mux9,
		Entrada2 => SumaPC_Suma2_Mux1_Mux9,
		Salida => Mux9_Wd3,
		Control => PCToRegSignal
	);
	
PCs: PC
	port map(
		Entrada => Mux3_PC,
		Clk => Clk,
		NRst => Nrst,
		Salida => MemProgAddrSignal
	);
	
AndPC: ANDPCSrc
	port map(
			Entrada1 => BranchSignal,
			Entrada2 => ZSignal,
			Salida => PCSrcSignal
	);

S1: SumadorPC
	port map(
		Entrada => MemProgAddrSignal,
		Salida => SumaPC_Suma2_Mux1_Mux9 
	);	
	
	
S2: Sumador2
	port map(
		Entrada1 => Mul32_Sumador2,
		Entrada2 => SumaPC_Suma2_Mux1_Mux9,
		Salida => Suma2_Mux1
	);
	
	
ExtC: ExtCero
	port map(
		Entrada => MemProgData(15 downto 0),
		Salida => ExtCero_Mux6
	);
	
ExtS: ExtSigno
	port map(
		Entrada => MemProgData(15 downto 0),
		Salida => ExtSigno_Mul31_Mux6
	);
	
M26: Multiplicador26
	port map(
		Entrada => MemProgData(25 downto 0),
		Salida => Mul26_Mux2
	);
	

	
M31: Multiplicador31
	port map(
		Entrada => ExtSigno_Mul31_Mux6,
		Salida => Mul32_Sumador2
	);
	
	
	--CONECTAMOS LAS ENTRADAS DEL MICRO CON LAS SALIDAS DEL MICROMIPS
	
	--Conectamos la salida del PC a la entrada de la Memoria de Instrucciones y al SumadorPC
	MemProgAddr <= MemProgAddrSignal;
	
	--Conectamos la salida de la ALU a la entrada de la memoria de datos y el Multiplexor 8
	MemDataAddr <= MemDataAddrSignal;
	
	--Conectamos la salida Rd2 del Banco de Registros a la entrada de la Memoria de Datos
	MemDataDataWrite <= Rd2_Mux7_MemDataDataWrite;
	
	--Conectamos la señal de salida MemDataWe con la señal correspondiente que sale de la Unidad de Control
	MemDataWE <= MemWriteSignal;

end behavioral;
