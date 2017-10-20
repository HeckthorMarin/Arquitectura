LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY WindowsManager_TB IS
END WindowsManager_TB;
 
ARCHITECTURE behavior OF WindowsManager_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT WindowsManager
    PORT(
         op : IN  std_logic_vector(1 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         rs1 : IN  std_logic_vector(4 downto 0);
         rs2 : IN  std_logic_vector(4 downto 0);
         rd : IN  std_logic_vector(4 downto 0);
         CWP : IN  std_logic;
         Nrs1 : OUT  std_logic_vector(5 downto 0);
         Nrs2 : OUT  std_logic_vector(5 downto 0);
         Nrd : OUT  std_logic_vector(5 downto 0);
         nCWP : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');
   signal rs1 : std_logic_vector(4 downto 0) := (others => '0');
   signal rs2 : std_logic_vector(4 downto 0) := (others => '0');
   signal rd : std_logic_vector(4 downto 0) := (others => '0');
   signal CWP : std_logic := '0';

 	--Outputs
   signal Nrs1 : std_logic_vector(5 downto 0);
   signal Nrs2 : std_logic_vector(5 downto 0);
   signal Nrd : std_logic_vector(5 downto 0);
   signal nCWP : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: WindowsManager PORT MAP (
          op => op,
          op3 => op3,
          rs1 => rs1,
          rs2 => rs2,
          rd => rd,
          CWP => CWP,
          Nrs1 => Nrs1,
          Nrs2 => Nrs2,
          Nrd => Nrd,
          nCWP => nCWP
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
		CWP <= '0';
      rs1 <= "00000";
		rs2 <= "01000";
		rd <= "10000";
      wait for 40 ns;
		
		op <= "10";
		op3 <= "111100";
		
		wait for 20 ns;
		
		op <= "10";
		op3 <= "111101";
		CWP <= '1';
		wait for 20 ns;
		
		rs1 <= "01000";
		rs2 <= "10000";
		rd <= "11000";
		op <= "10";
		op3 <= "111101";
		
		wait for 20 ns; 
		
		CWP <= '0';
		op <= "10";
		op3 <= "111100";
		
		wait for 20 ns;

      wait;
   end process;

END;