LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MuxWM_15toRF_TB IS
END MuxWM_15toRF_TB;
 
ARCHITECTURE behavior OF MuxWM_15toRF_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MuxWM_15toRF
    PORT(
         rd : IN  std_logic_vector(5 downto 0);
         reg : IN  std_logic_vector(5 downto 0);
         rfd : IN  std_logic;
         nrd : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rd : std_logic_vector(5 downto 0) := (others => '0');
   signal reg : std_logic_vector(5 downto 0) := (others => '0');
   signal rfd : std_logic := '0';

 	--Outputs
   signal nrd : std_logic_vector(5 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MuxWM_15toRF PORT MAP (
          rd => rd,
          reg => reg,
          rfd => rfd,
          nrd => nrd
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      rd <= "000100";
		reg <= "001111";
      wait for 20 ns;	
		rfd <= '1';
      wait;
   end process;

END;
