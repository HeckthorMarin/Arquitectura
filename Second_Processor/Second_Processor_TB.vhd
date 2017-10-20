LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Second_Processor_TB IS
END Second_Processor_TB;
 
ARCHITECTURE behavior OF Second_Processor_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SecondProcessor
    PORT(
         CLK : IN  std_logic;
         rst : IN  std_logic;
         aluresult : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal aluresult : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SecondProcessor PORT MAP (
          CLK => CLK,
          rst => rst,
          aluresult => aluresult
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait;
   end process;

END;
