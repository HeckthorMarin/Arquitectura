library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Adder is
    Port ( op_a : in  STD_LOGIC_VECTOR (31 downto 0);
           op_b : in  STD_LOGIC_VECTOR (31 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end Adder;

architecture Behavioral of Adder is

begin
	
	process(op_a,op_b)
	begin
		result <= op_a + op_b;
	end process;
	
end Behavioral;