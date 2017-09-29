--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:23:08 09/22/2017
-- Design Name:   
-- Module Name:   C:/Users/utp/Desktop/jhon garcia/primeraentrega/tb_Registro32.vhd
-- Project Name:  primeraentrega
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Registro32
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_Registro32 IS
END tb_Registro32;
 
ARCHITECTURE behavior OF tb_Registro32 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Registro32
    PORT(
         CLK : IN  std_logic;
         Rst : IN  std_logic;
         DataIn : IN  std_logic_vector(31 downto 0);
         Salida : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Rst : std_logic := '0';
   signal DataIn : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Salida : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Registro32 PORT MAP (
          CLK => CLK,
          Rst => Rst,
          DataIn => DataIn,
          Salida => Salida
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	

      Rst <= '0';
		DataIn <= x"00000001";
	   wait for 20 ns;
		Rst <= '0';
		DataIn <= x"00000002";
	   wait for 20 ns;
		Rst <= '1';
		DataIn <= x"00000003";
	   wait for 20 ns;
		
      wait;
   end process;

END;
