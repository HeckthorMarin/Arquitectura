library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
 
ENTITY MuxRF_SEUtoALU_TB IS
END MuxRF_SEUtoALU_TB;
 
ARCHITECTURE behavior OF MuxRF_SEUtoALU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MuxRF_SEUtoALU
    PORT(
         crs2 : IN  std_logic_vector(31 downto 0);
         imm32 : IN  std_logic_vector(31 downto 0);
         i : IN  std_logic;
         data32 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal crs2 : std_logic_vector(31 downto 0) := (others => '0');
   signal imm32 : std_logic_vector(31 downto 0) := (others => '0');
   signal i : std_logic := '0';

 	--Outputs
   signal data32 : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MuxRF_SEUtoALU PORT MAP (
          crs2 => crs2,
          imm32 => imm32,
          i => i,
          data32 => data32
        );

   -- Stimulus process
   stim_proc: process
   begin		
      crs2 <= x"0000000F";
		imm32 <= x"FFFFFFF0";
		i <= '0';
      wait for 40 ns;
		i <= '1';
      wait;
   end process;

END;
