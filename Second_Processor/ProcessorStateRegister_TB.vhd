LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ProcessorStateRegister_TB IS
END ProcessorStateRegister_TB;
 
ARCHITECTURE behavior OF ProcessorStateRegister_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ProcessorStateRegister
    PORT(
         nzvc : IN  std_logic_vector(3 downto 0);
         CLK : IN  std_logic;
         rst : IN  std_logic;
         Carry : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal nzvc : std_logic_vector(3 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal Carry : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ProcessorStateRegister PORT MAP (
          nzvc => nzvc,
          CLK => CLK,
          rst => rst,
          Carry => Carry
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
	
      nzvc <= "1001";
		wait for 20 ns;
		
      rst <= '1';
      wait for 20 ns;
		
		rst <= '0';
		wait for 20 ns; 
		
		nzvc <= "1000";
		wait for 20 ns;

      wait;
   end process;

END;
