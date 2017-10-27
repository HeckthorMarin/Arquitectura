LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ThirdProcessor_TB IS
END ThirdProcessor_TB;
 
ARCHITECTURE behavior OF ThirdProcessor_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ThirdProcessor
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
   uut: ThirdProcessor PORT MAP (
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

      wait;
   end process;

END;
