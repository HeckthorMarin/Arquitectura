library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.all;

entity WindowsManager is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           CWP : in  STD_LOGIC;
           Nrs1 : out  STD_LOGIC_VECTOR (5 downto 0) := "000000";
           Nrs2 : out  STD_LOGIC_VECTOR (5 downto 0) := "000000";
           Nrd : out  STD_LOGIC_VECTOR (5 downto 0) := "000000";
           nCWP : out  STD_LOGIC := '0');
end WindowsManager;

architecture Behavioral of WindowsManager is

	signal int_rs1, int_rs2, int_rd: integer range 0 to 39;

begin
	process(op, op3, rs1, rs2, rd, CWP)
	begin		
		
		if (op = "10" and op3 = "111100") then   -- Save
			nCWP <= '0';
			if((rd >= 0) and (rd <= 7)) then
				int_rd <= conv_integer(rd);
			elsif((rd >= 8) and (rd <= 23)) then
				int_rd <= conv_integer(rd) + ((conv_integer(CWP)-1) * 16);
			elsif((rd >= 24) and (rd <= 31)) then
				int_rd <= conv_integer(rd) - ((conv_integer(CWP)-1) * 16);
			end if;	
			
		elsif(op = "10" and op3 = "111101") then -- Restore
			nCWP <= '1';
			if((rd >= 0) and (rd <= 7)) then
				int_rd <= conv_integer(rd);
			elsif((rd >= 8) and (rd <= 23)) then
				int_rd <= conv_integer(rd) + ((conv_integer(CWP)+1) * 16);
			elsif((rd >= 24) and (rd <= 31)) then
				int_rd <= conv_integer(rd) - ((conv_integer(CWP)+1) * 16);
			end if;	
			
		else
			if((rd >= 0) and (rd <= 7)) then
				int_rd <= conv_integer(rd);
			elsif((rd >= 8) and (rd <= 23)) then
				int_rd <= conv_integer(rd) + (conv_integer(CWP) * 16);
			elsif((rd >= 24) and (rd <= 31)) then
				int_rd <= conv_integer(rd) - (conv_integer(CWP) * 16);
			end if;
		
		end if;
		
		if((rs1 >= 0) and (rs1 <= 7)) then
			int_rs1 <= conv_integer(rs1);
		elsif((rs1 >= 8) and (rs1 <= 23)) then
			int_rs1 <= conv_integer(rs1) + (conv_integer(CWP) * 16);
		elsif((rs1 >= 24) and (rs1 <= 31)) then
			int_rs1 <= conv_integer(rs1) + (conv_integer(CWP) * 16);
		end if;
		
		if((rs2 >= 0) and (rs2 <= 7)) then
			int_rs2 <= conv_integer(rs2);
		elsif((rs2 >= 8) and (rs2 <= 23)) then
			int_rs2 <= conv_integer(rs2) + (conv_integer(CWP) * 16);
		elsif((rs2 >= 24) and (rs2 <= 31)) then
			int_rs2 <= conv_integer(rs2) - (conv_integer(CWP) * 16);
		end if;
		
			
		
	end process;
	
	nrs1 <= conv_std_logic_vector(int_rs1, 6);
	nrs2 <= conv_std_logic_vector(int_rs2, 6);
	nrd <= conv_std_logic_vector(int_rd, 6);
	
end Behavioral;

