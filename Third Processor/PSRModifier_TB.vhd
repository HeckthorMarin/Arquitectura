LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY PSRModifier_TB IS
END PSRModifier_TB;
 
ARCHITECTURE behavior OF PSRModifier_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSRModifier
    PORT(
         alu_op : IN  std_logic_vector(5 downto 0);
         alu_result : IN  std_logic_vector(31 downto 0);
         op1 : IN  std_logic_vector(31 downto 0);
         op2 : IN  std_logic_vector(31 downto 0);
         nzvc_out : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal alu_op : std_logic_vector(5 downto 0) := (others => '0');
   signal alu_result : std_logic_vector(31 downto 0) := (others => '0');
   signal op1 : std_logic_vector(31 downto 0) := (others => '0');
   signal op2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal nzvc_out : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSRModifier PORT MAP (
          alu_op => alu_op,
          alu_result => alu_result,
          op1 => op1,
          op2 => op2,
          nzvc_out => nzvc_out
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      alu_op <= "010000";
		op1 <= x"00000000";
		op2 <= x"00000000";
		alu_result <= x"00000000";
		
      wait for 20 ns;
		alu_op <= "010001";
		op1 <= x"FFFFFFFF";
		op2 <= x"FFFF0000";
		alu_result <= x"FFFF0000";
      wait for 20 ns;
		
		alu_op <= "011000";
		op1 <= x"70000000";
		op2 <= x"70000000";
		alu_result <= x"80000000";
      wait for 20 ns;
		
		alu_op <= "011000";
		op1 <= x"80000000";
		op2 <= x"80000000";
		alu_result <= x"70000000";
      wait for 20 ns;
		
		alu_op <= "011000";
		op1 <= x"80000000";
		op2 <= x"70000000";
		alu_result <= x"70000000";
      wait for 20 ns;
		
		alu_op <= "011000";
		op1 <= x"70000000";
		op2 <= x"80000000";
		alu_result <= x"70000000";
      wait for 20 ns;

      wait;
   end process;

END;
