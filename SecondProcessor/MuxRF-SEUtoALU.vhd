library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity MuxRF_SEUtoALU is
    Port ( crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           imm32 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i : in STD_LOGIC;
           data32 : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end MuxRF_SEUtoALU;

architecture Behavioral of MuxRF_SEUtoALU is

begin

	process(crs2,imm32,i)
	begin
	
		if (i = '0') then
			data32 <= crs2;
		elsif (i = '1') then
			data32 <= imm32;
		end if;
		
	end process;

end Behavioral;

