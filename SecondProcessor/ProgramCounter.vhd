library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ProgramCounter is
    Port ( address_in : in  STD_LOGIC_VECTOR (31 downto 0);
           CLK : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           address_out : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end ProgramCounter;

architecture Behavioral of ProgramCounter is

begin

	process(CLK,address_in,rst)
	begin
		
		if ( rst = '1') then
			address_out <= (others => '0');
		else
		
			if rising_edge(CLK) then
				address_out <= address_in;
			end if;
			
		end if;
		
	end process;

end Behavioral;