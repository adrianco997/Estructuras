-- Fichero:					MicroSuma.vhd			--
-- Descripción: 			Microprocesador 		--
--								(MIPS) simplificado	--
-- Última modificación:	2017-02-25				--
--															--
-- Pareja:					6  						--
-- Autores: 			*	Adrian Caballero		--
--							*	Manuel Salvador		--
-- Asignatura: 			E.C. 1º grado			--
-- Grupo de Prácticas: 	2101						--
-- Grupo de Teoría: 		210						--
-- Práctica: 				2							--
-- Ejercicio:				1							--
-----------------------------------------------
-----------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
entity RegsMIPS is port (
		Clk : in std_logic; -- Reloj
		NRst : in std_logic; -- Reset asíncrono a nivel bajo
		A1 : in std_logic_vector(4 downto 0); -- Dirección para el puerto Rd1
		Rd1 : out std_logic_vector(31 downto 0); -- Dato del puerto Rd1
		A2 : in std_logic_vector(4 downto 0); -- Dirección para el puerto Rd2
		Rd2 : out std_logic_vector(31 downto 0); -- Dato del puerto Rd2
		A3 : in std_logic_vector(4 downto 0); -- Dirección para el puerto Wd3
		Wd3 : in std_logic_vector(31 downto 0); -- Dato de entrada Wd3
		We3 : in std_logic ); -- Habilitación del banco de registros
end RegsMIPS; 

 architecture Practica of RegMIPS is
	-- Tipo para almacenar los registros
	type regs_t is array (0 to 31) of std_logic_vector(31 downto 0);
	-- Esta es la señal que contiene los registros. El acceso es de la
	-- siguiente manera: regs(i) acceso al registro i, donde i es
	-- un entero. Para convertir del tipo std_logic_vector a entero se
	-- hace de la siguiente manera: conv_integer(slv), donde
	-- slv es un elemento de tipo std_logic_vector
	-- Registros inicializados a '0' 
	-- NOTA: no cambie el nombre de esta señal.
	signal regs : regs_t;
-----------------------------------------------
--							PRACTICA						--
-----------------------------------------------
begin
	Rd1 <= regs(conv_integer(A1));				-- Lectura asincrona
	Rd2 <= regs(conv_integer(A2));  				-- de los dos puertos
	process(Clk, NRst) begin 						-- Proceso en la escritura sincrona del registro
		if NRst = '0'	then 							-- Si el reset es 0 se asignan todas la señales a 0
			for i in 0 to 31 loop
				regs(i) <= (others => '0');
			end loop;
		elsif rising_edge(Clk)then	 -- Cuando hay un flanco de reloj y el write enable está activado,
			if Wd3 /= 0 then
				if We3 = '1' then					-- se permite la escritura sincrona en el registro	
				regs(conv_integer(A3)) <= Wd3;
			end if;
		end if;
		end if;
	end process;
end Practica;
