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
         rfs : OUT  std_logic_vector(1 downto 0);
         DMwen : OUT  std_logic;
         DMren : OUT  std_logic;
         RFwen : OUT  std_logic;
         aluop : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal rfs : std_logic_vector(1 downto 0);
   signal DMwen : std_logic;
   signal DMren : std_logic;
   signal RFwen : std_logic;
   signal aluop : std_logic_vector(5 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ControlUnit PORT MAP (
          op => op,
          op3 => op3,
          rfs => rfs,
          DMwen => DMwen,
          DMren => DMren,
          RFwen => RFwen,
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
		op <= "11";
		op3 <= "000000";
      wait for 20 ns;
		op <= "11";
		op3 <= "000100";
      wait for 20 ns;
		op <= "11";
		op3 <= "001100";
      wait for 20 ns;

      wait;
   end process;

END;
