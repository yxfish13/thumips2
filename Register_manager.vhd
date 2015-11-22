----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:23:03 11/20/2015 
-- Design Name: 
-- Module Name:    Register_manager - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterManager is
    Port ( reg1_addr : in  STD_LOGIC_VECTOR (3 downto 0);
           reg2_addr : in  STD_LOGIC_VECTOR (3 downto 0);
           w_enable : in  STD_LOGIC;
           w_addr : in  STD_LOGIC_VECTOR (3 downto 0);
           w_data : in  STD_LOGIC_VECTOR (15 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           r_data1 : out  STD_LOGIC_VECTOR (15 downto 0);
           r_data2 : out  STD_LOGIC_VECTOR (15 downto 0));
end RegisterManager;

architecture Behavioral of RegisterManager is

begin

	r_data1<=w_data;
end Behavioral;

