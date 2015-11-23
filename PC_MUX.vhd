----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:22:44 11/22/2015 
-- Design Name: 
-- Module Name:    PC_MUX - Behavioral 
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

entity PC_MUX is
    Port ( PC_inF : in  STD_LOGIC_VECTOR (15 downto 0);
           PC_enable : in  STD_LOGIC;
           PC_ID : in  STD_LOGIC_VECTOR (15 downto 0);
           next_PC : out  STD_LOGIC_VECTOR (15 downto 0));
end PC_MUX;

architecture Behavioral of PC_MUX is

begin
	--process(PC_inF,PC_ID)
	--begin
	--case PC_enable is
	--when '1' =>
		--next_PC<=PC_ID;
	--when others =>
		--next_PC <= PC_inF;
	--end case;
	--end process;
	next_PC<=PC_ID when(PC_enable='1')else PC_inF;
end Behavioral;

