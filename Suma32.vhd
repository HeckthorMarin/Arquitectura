----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:23:40 09/22/2017 
-- Design Name: 
-- Module Name:    Suma32 - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Suma32 is
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           Suma32Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Suma32;

architecture Suma32_Arq of Suma32 is

begin

process (a, b)
	begin
		
		Suma32Salida <= a + b;

end process;

end Suma32_Arq;

