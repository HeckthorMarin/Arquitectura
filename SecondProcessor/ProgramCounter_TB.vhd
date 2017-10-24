LIBRARY ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
 
ENTITY ProgramCounter_TB IS
END ProgramCounter_TB;
 
ARCHITECTURE behavior OF ProgramCounter_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ProgramCounter
    PORT(
         address_in : IN  std_logic_vector(31 downto 0);
         CLK : IN  std_logic;
			rst : IN std_logic;
         address_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal address_in : std_logic_vector(31 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
	signal rst : std_logic := '0';

 	--Outputs
   signal address_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ProgramCounter PORT MAP (
          address_in => address_in,
          CLK => CLK,
			 rst => rst,
          address_out => address_out
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
      address_in <= x"00000001";
      wait for 30 ns;
		address_in <= x"00000002";
      wait for 20 ns;	
		address_in <= x"00000003";
      wait for 20 ns;	
		address_in <= x"00000004";
      wait for 20 ns;	
      wait;
   end process;

END;
