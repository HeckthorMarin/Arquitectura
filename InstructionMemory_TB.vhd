library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use STD.TEXTIO.all;
 
ENTITY InstructionMemory_TB IS
END InstructionMemory_TB;
 
ARCHITECTURE behavior OF InstructionMemory_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InstructionMemory
    PORT(
         address : IN  std_logic_vector(31 downto 0);
         rst : IN  std_logic;
         instruction : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal address : std_logic_vector(31 downto 0) := (others => '0');
   signal rst : std_logic := '0';

 	--Outputs
   signal instruction : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InstructionMemory PORT MAP (
          address => address,
          rst => rst,
          instruction => instruction
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      address <= x"00000000";
      wait for 40 ns;
		address <= x"00000001";
      wait for 40 ns;
		address <= x"00000002";
      wait for 40 ns;
		address <= x"00000003";
      wait for 40 ns;
		address <= x"00000004";
      wait for 40 ns;
		address <= x"00000005";
      wait for 40 ns;
      wait;
   end process;

END;