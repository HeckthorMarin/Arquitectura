library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
 
ENTITY ArithmeticLogicUnit_TB IS
END ArithmeticLogicUnit_TB;
 
ARCHITECTURE behavior OF ArithmeticLogicUnit_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ArithmeticLogicUnit
    PORT(
         aluop : IN  std_logic_vector(5 downto 0);
         op_a : IN  std_logic_vector(31 downto 0);
         op_b : IN  std_logic_vector(31 downto 0);
			carry : IN std_logic;
         result : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal aluop : std_logic_vector(5 downto 0) := (others => '0');
   signal op_a : std_logic_vector(31 downto 0) := (others => '0');
   signal op_b : std_logic_vector(31 downto 0) := (others => '0');
	signal carry : std_logic := '0';

 	--Outputs
   signal result : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ArithmeticLogicUnit PORT MAP (
          aluop => aluop,
          op_a => op_a,
          op_b => op_b,
			 carry => carry,
          result => result
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      op_a <= x"00000005";
		op_b <= x"00000010";
      wait for 40 ns;
		aluop <= "000000";
		wait for 40 ns;
		aluop <= "000001";
		wait for 40 ns;
		aluop <= "000010";
		wait for 40 ns;
		aluop <= "000011";
		wait for 40 ns;
		aluop <= "000100";
		wait for 40 ns;
		aluop <= "000101";
		wait for 40 ns;
		aluop <= "000110";
		wait for 40 ns;
		aluop <= "000111";
		wait for 40 ns;
		aluop <= "001000";
		wait for 40 ns;
		op_a <= x"00000001";
		op_b <= x"00000003";
		aluop <= "100101";
		wait for 40 ns;
		op_a <= x"00000010";
		op_b <= x"00000003";
		aluop <= "100110";
		wait for 40 ns;
		wait;
   end process;

END;
