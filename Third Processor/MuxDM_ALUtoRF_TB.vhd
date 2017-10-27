LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY MuxDM_ALUtoRF_TB IS
END MuxDM_ALUtoRF_TB;
 
ARCHITECTURE behavior OF MuxDM_ALUtoRF_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MuxDM_ALUtoRF
    PORT(
         DM : IN  std_logic_vector(31 downto 0);
         AluResult : IN  std_logic_vector(31 downto 0);
         PC : IN  std_logic_vector(31 downto 0);
         RFs : IN  std_logic_vector(1 downto 0);
         Data : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DM : std_logic_vector(31 downto 0) := (others => '0');
   signal AluResult : std_logic_vector(31 downto 0) := (others => '0');
   signal PC : std_logic_vector(31 downto 0) := (others => '0');
   signal RFs : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Data : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MuxDM_ALUtoRF PORT MAP (
          DM => DM,
          AluResult => AluResult,
          PC => PC,
          RFs => RFs,
          Data => Data
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      DM <= x"00000001";
		AluResult <= x"00000010";
		PC <= x"00000100";
		RFs <= "11";
      wait for 20 ns;	
		RFs <= "00";
		wait for 20 ns;
		RFs <= "01";
		wait for 20 ns;
		RFs <= "10";
		
		
      wait;
   end process;

END;
