--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:30:22 09/22/2017
-- Design Name:   
-- Module Name:   C:/Users/utp/Desktop/jhon garcia/primeraentrega/tb_suma32.vhd
-- Project Name:  primeraentrega
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Suma32
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY tb_suma32 IS
END tb_suma32;
 
ARCHITECTURE behavior OF tb_suma32 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Suma32
    PORT(
         a : IN  std_logic_vector(31 downto 0);
         b : IN  std_logic_vector(31 downto 0);
         Suma32Salida : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(31 downto 0) := (others => '0');
   signal b : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Suma32Salida : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Suma32 PORT MAP (
          a => a,
          b => b,
          Suma32Salida => Suma32Salida
        );

 

   -- Stimulus process
   stim_proc: process
   begin	
		a <= "00000000000000000000000000000010"
		b <= "00000000000000000000000000000111"
      wait for 100 ns;	

      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
