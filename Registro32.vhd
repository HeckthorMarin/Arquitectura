----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:51:32 09/22/2017 
-- Design Name: 
-- Module Name:    Registro32 - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;


entity Registro32 is
    Port ( CLK : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Registro32;

architecture Registro32_Arq of Registro32 is
begin
process(CLK, Rst, DataIn)
	begin
		if (Rst = '1') then
			salida <= (others => '0');
		else
			if(rising_edge(CLK)) then
				salida <= DataIn;
			end if;
		end if;
end process;

end Registro32_Arq;

