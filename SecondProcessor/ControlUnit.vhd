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
					when "000001" =>  -- And
						aluop <= "000001";
					when "010001" =>  -- Andcc
						aluop <= "010001";
					when "000101" =>  -- AndN
						aluop <= "000101";
					when "010101" =>  -- AndNcc
						aluop <= "010101";
	
					when "000010" =>  -- Or
						aluop <= "000010";
					when "010010" =>  -- Orcc
						aluop <= "010010";
					when "000110" =>  -- OrN
						aluop <= "000110"; 
					when "010110" =>  -- OrNcc
						aluop <= "010110";

					when "000011" =>  -- Xor
						aluop <= "000011";
					when "010011" =>  -- Xorcc
						aluop <= "010011";
					when "000111" =>  -- XNor
						aluop <= "000111"; 
					when "010111" =>  -- XNorcc
						aluop <= "010111";

					when "000000" =>  -- Add
						aluop <= "000000";		
					when "010000" =>  -- Addcc
						aluop <= "010000";
					when "001000" =>  -- AddX
						aluop <= "001000";
					when "011000" =>  -- AddXcc
						aluop <= "011000";

					when "000100" =>  -- Sub
						aluop <= "000100"; 
					when "010100" =>  -- Subcc
						aluop <= "010100";
					when "001100" =>  -- SubX
						aluop <= "001100";
					when "011100" =>  -- SubXcc
						aluop <= "011100";
					when others =>
						aluop <= "111111";
				end case;
				
			when others =>
				
				aluop <= "111111";
				
		end case;
	
	end process;

end Behavioral;
