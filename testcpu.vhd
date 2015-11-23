--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:25:45 11/23/2015
-- Design Name:   
-- Module Name:   C:/thumips/testcpu.vhd
-- Project Name:  thumips
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: OpenMIPS
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
 
ENTITY testcpu IS
END testcpu;
 
ARCHITECTURE behavior OF testcpu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT OpenMIPS
    PORT(
         CLK50 : IN  std_logic;
         CLK11 : IN  std_logic;
         RST : IN  std_logic;
         RDN : OUT  std_logic;
         ram1_data_inst : INOUT  std_logic_vector(15 downto 0);
         ram1_data_addr : OUT  std_logic_vector(17 downto 0);
         ram1_OE : OUT  std_logic;
         ram1_WE : OUT  std_logic;
         ram1_EN : OUT  std_logic;
         ram2_data_inst : INOUT  std_logic_vector(15 downto 0);
         ram2_data_addr : OUT  std_logic_vector(17 downto 0);
         ram2_OE : OUT  std_logic;
         ram2_WE : OUT  std_logic;
         ram2_EN : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK50 : std_logic := '0';
   signal CLK11 : std_logic := '0';
   signal RST : std_logic := '0';

	--BiDirs
   signal ram1_data_inst : std_logic_vector(15 downto 0);
   signal ram2_data_inst : std_logic_vector(15 downto 0);

 	--Outputs
   signal RDN : std_logic;
   signal ram1_data_addr : std_logic_vector(17 downto 0);
   signal ram1_OE : std_logic;
   signal ram1_WE : std_logic;
   signal ram1_EN : std_logic;
   signal ram2_data_addr : std_logic_vector(17 downto 0);
   signal ram2_OE : std_logic;
   signal ram2_WE : std_logic;
   signal ram2_EN : std_logic;

   -- Clock period definitions
   constant CLK50_period : time := 10 ns;
   constant CLK11_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: OpenMIPS PORT MAP (
          CLK50 => CLK50,
          CLK11 => CLK11,
          RST => RST,
          RDN => RDN,
          ram1_data_inst => ram1_data_inst,
          ram1_data_addr => ram1_data_addr,
          ram1_OE => ram1_OE,
          ram1_WE => ram1_WE,
          ram1_EN => ram1_EN,
          ram2_data_inst => ram2_data_inst,
          ram2_data_addr => ram2_data_addr,
          ram2_OE => ram2_OE,
          ram2_WE => ram2_WE,
          ram2_EN => ram2_EN
        );

   -- Clock process definitions
   CLK50_process :process
   begin
		CLK50 <= '0';
		wait for CLK50_period/2;
		CLK50 <= '1';
		wait for CLK50_period/2;
   end process;
 
   CLK11_process :process
   begin
		CLK11 <= '0';
		wait for CLK11_period/2;
		CLK11 <= '1';
		wait for CLK11_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK50_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
