LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ControlUnit_TB IS
END ControlUnit_TB;
 
ARCHITECTURE behavior OF ControlUnit_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ControlUnit
    PORT(
         op : IN  std_logic_vector(1 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         aluop : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal aluop : std_logic_vector(5 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ControlUnit PORT MAP (
          op => op,
          op3 => op3,
          aluop => aluop
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      op <= "00";	
      wait for 20 ns;
		op <= "10";
		op3 <= "000000";
      wait for 20 ns;
		op3 <= "000001";
      wait for 20 ns;
		op3 <= "000010";
      wait for 20 ns;
		op3 <= "000011";
      wait for 20 ns;
		op3 <= "000100";
      wait for 20 ns;
		op3 <= "000101";
      wait for 20 ns;
		op3 <= "000110";
      wait for 20 ns;
		op3 <= "000111";
      wait for 20 ns;
		op3 <= "001000";
      wait for 20 ns;
      wait;
   end process;

END;
