----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:22:34 11/22/2015 
-- Design Name: 
-- Module Name:    SubClk - Behavioral 
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

entity SubClk is
    Port ( clk_fast : in  STD_LOGIC;
				rst		:in STD_LOGIC;
           clk_slow : out  STD_LOGIC);
end SubClk;

architecture Behavioral of SubClk is
signal temp:STD_LOGIC;
begin
	process(clk_fast)
	begin
		if (rst='0')then
			temp<='1';
		elsif(clk_fast'event and clk_fast='0')then
			temp<= not temp;
		end if;
	end process;
	clk_slow<=temp;
end Behavioral;

