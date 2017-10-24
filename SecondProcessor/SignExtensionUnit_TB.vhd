library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
 
ENTITY SignExtensionUnit_TB IS
END SignExtensionUnit_TB;
 
ARCHITECTURE behavior OF SignExtensionUnit_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SignExtensionUnit
    PORT(
         data13 : IN  std_logic_vector(12 downto 0);
         data32 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal data13 : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal data32 : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SignExtensionUnit PORT MAP (
          data13 => data13,
          data32 => data32
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      data13 <= "0000000000101";
      wait for 40 ns;	
		data13 <= "1111111111011";
      wait for 40 ns;
      wait;
   end process;

END;
