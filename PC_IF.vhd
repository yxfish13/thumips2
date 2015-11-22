----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:15:01 11/22/2015 
-- Design Name: 
-- Module Name:    PC_IF - Behavioral 
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

entity PC_IF is
    Port ( PC_in : in  STD_LOGIC_vector(15 downto 0);
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           pause : in  STD_LOGIC_vector(4 downto 0);
           pc : out  STD_LOGIC_vector(15 downto 0));
end PC_IF;

architecture Behavioral of PC_IF is

begin
	process (clk)
	begin
		if (rst='0')then
			pc<="0000000000000000";
		elsif(clk'event and clk='0') then
			pc <= PC_in;
		end if;
	end process;
end Behavioral;

