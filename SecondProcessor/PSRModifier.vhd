library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSRModifier is
    Port ( alu_op : in  STD_LOGIC_VECTOR (5 downto 0);
           alu_result : in  STD_LOGIC_VECTOR (31 downto 0);
           op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0) :=  "0000" );
end PSRModifier;

architecture Behavioral of PSRModifier is
 
begin
	
	process(alu_op, alu_result, op1, op2)
	begin
		
		if ((alu_op = "010000") or (alu_op = "011000")) then     -- Addcc -- AddXcc
			--- Bit N ---
			nzvc(3) <= alu_result(31);
			--- Bit Z ---
			if (alu_result = x"00000000") then 
				nzvc(2) <= '1';
			else
				nzvc(2) <= '0';
			end if;
			--- Bit V ---
			nzvc(1) <= (op1(31) and op2(31) and not alu_result(31)) or (not op1(31) and not op2(31) and alu_result(31));
			--- Bit C --- or
			nzvc(0) <= (op1(31) and op2(31)) or (not alu_result(31) and (op1(31) or op2(31)));
			
		elsif ((alu_op = "010100") or (alu_op = "011100")) then  -- Subcc -- SubXcc
			--- Bit N ---
			nzvc(3) <= alu_result(31);
			--- Bit Z --- 
			if (alu_result = x"00000000") then 
				nzvc(2) <= '1';
			else
				nzvc(2) <= '0';
			end if;
			--- Bit V ---
			nzvc(1) <= (op1(31) and not op2(31) and not alu_result(31)) or (not op1(31) and op2(31) and alu_result(31));
			--- Bit C ---
			nzvc(0) <= (not op1(31) and op2(31)) or (alu_result(31) and (not op1(31) or op2(31)));
			
		elsif (alu_op = "010001" or alu_op = "010101" or alu_op = "010010" or alu_op = "010110" or alu_op = "010011" or alu_op = "010111") then -- Andcc	-- AndNcc -- Orcc -- OrNcc -- Xorcc -- XNorcc
			nzvc(3) <= alu_result(31);
			if (alu_result = x"00000000") then 
				nzvc(2) <= '1';
			else 
				nzvc(2) <= '0';
			end if;
			nzvc(1 downto 0) <= "00";
		else
			nzvc <= "0000";
		end if; 
	
	end process;

end Behavioral;