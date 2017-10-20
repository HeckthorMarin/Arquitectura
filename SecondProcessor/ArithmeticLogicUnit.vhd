library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ArithmeticLogicUnit is
    Port ( aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           op_a : in  STD_LOGIC_VECTOR (31 downto 0);
           op_b : in  STD_LOGIC_VECTOR (31 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end ArithmeticLogicUnit;

architecture Behavioral of ArithmeticLogicUnit is

begin

	process(aluop,op_a,op_b)
	begin
	
		case (aluop) is
			when "000000" =>  -- Add
				result <= op_a + op_b;
			when "000001" =>  -- And
				result <= op_a and op_b;
			when "000010" =>  -- Or
				result <= op_a or op_b;
			when "000011" =>  -- Xor
				result <= op_a xor op_b;
			when "000100" =>  -- Sub
				result <= op_a - op_b; 
			when "000101" =>  -- AndN
				result <= op_a and (not op_b); 
			when "000110" =>  -- OrN
				result <= op_a or (not op_b); 
			when "000111" =>  -- XNor
				result <= op_a xnor op_b; 
			when others =>
				result <= (others=>'0');			
		end case;
		
	end process;

end Behavioral;

