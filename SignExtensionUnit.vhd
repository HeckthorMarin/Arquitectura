library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity SignExtensionUnit is
    Port ( data13 : in  STD_LOGIC_VECTOR (12 downto 0);
           data32 : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end SignExtensionUnit;

architecture Behavioral of SignExtensionUnit is

begin

	process(data13)
	begin
		if (data13(12) = '0') then
			data32(31 downto 13) <= (others => '0');
			data32(12 downto 0) <= data13;
		elsif (data13(12) = '1') then
			data32(31 downto 13) <= (others => '1');
			data32(12 downto 0) <= data13;
		end if;
	end process;

end Behavioral;