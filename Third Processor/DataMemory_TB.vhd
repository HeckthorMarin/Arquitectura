LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY DataMemory_TB IS
END DataMemory_TB;
 
ARCHITECTURE behavior OF DataMemory_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DataMemory
    PORT(
         cRD : IN  std_logic_vector(31 downto 0);
         AluResult : IN  std_logic_vector(31 downto 0);
         WEn : IN  std_logic;
         REn : IN  std_logic;
         rst : IN  std_logic;
         Data : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal cRD : std_logic_vector(31 downto 0) := (others => '0');
   signal AluResult : std_logic_vector(31 downto 0) := (others => '0');
   signal WEn : std_logic := '0';
   signal REn : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal Data : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DataMemory PORT MAP (
          cRD => cRD,
          AluResult => AluResult,
          WEn => WEn,
          REn => REn,
          rst => rst,
          Data => Data
        );

   -- Stimulus process
   stim_proc: process
   begin		
      AluResult <= x"00000001";
		cRD <= x"00000010";
      wait for 20 ns;	
		WEn <= '1';
      wait for 20 ns;
		WEn <= '0';
		REn <= '1';		
      wait for 60 ns;
		rst <= '1';

      wait;
   end process;

END;
