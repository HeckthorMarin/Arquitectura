LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY SEU22_TB IS
END SEU22_TB;
 
ARCHITECTURE behavior OF SEU22_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SEU22
    PORT(
         Data22 : IN  std_logic_vector(21 downto 0);
         Data32 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Data22 : std_logic_vector(21 downto 0) := (others => '0');

 	--Outputs
   signal Data32 : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SEU22 PORT MAP (
          Data22 => Data22,
          Data32 => Data32
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      Data22 <= "1000000000000000000011";
      wait for 20 ns;	
		Data22 <= "0000000000000000000011";
      wait;
   end process;

END;
