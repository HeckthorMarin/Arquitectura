library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
 
ENTITY Adder_TB IS
END Adder_TB;
 
ARCHITECTURE behavior OF Adder_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Adder
    PORT(
         op_a : IN  std_logic_vector(31 downto 0);
         op_b : IN  std_logic_vector(31 downto 0);
         result : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op_a : std_logic_vector(31 downto 0) := (others => '0');
   signal op_b : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Adder PORT MAP (
          op_a => op_a,
          op_b => op_b,
          result => result
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      op_a <= x"00000008";
		op_b <= x"00000005";
      wait for 40 ns;
		op_a <= x"FFFFFFF5";
		op_b <= x"00000008";
      wait for 40 ns;
		op_a <= x"90000000";
		op_b <= x"90000000";
      wait for 40 ns;
      wait;
   end process;

END;