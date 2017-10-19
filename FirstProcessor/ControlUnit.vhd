library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ControlUnit is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           aluop : out  STD_LOGIC_VECTOR (5 downto 0) := (others => '1'));
end ControlUnit;

architecture Behavioral of ControlUnit is

begin

	process(op,op3)	
	begin 
	
		case (op) is
			when "10" =>
				
				case (op3) is
					when "000000" =>  -- Add
						aluop <= "000000";
					when "000001" =>  -- And
						aluop <= "000001";
					when "000010" =>  -- Or
						aluop <= "000010";
					when "000011" =>  -- Xor
						aluop <= "000011";
					when "000100" =>  -- Sub
						aluop <= "000100"; 
					when "000101" =>  -- AndN
						aluop <= "000101"; 
					when "000110" =>  -- OrN
						aluop <= "000110"; 
					when "000111" =>  -- XNor
						aluop <= "000111"; 
					when others =>
						aluop <= "111111";
				end case;
				
			when others =>
				
				aluop <= "111111";
				
		end case;
	
	end process;

end Behavioral;
