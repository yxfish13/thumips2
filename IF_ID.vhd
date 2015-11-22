----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:02:48 11/19/2015 
-- Design Name: 
-- Module Name:    IF_ID - Behavioral 
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

entity IF_ID is
    Port ( CLK : in  STD_LOGIC;
	        RST : in  STD_LOGIC;
			  pause : in std_logic_vector(4 downto 0);
			  if_pc : in  STD_LOGIC_VECTOR (15 downto 0);
           if_inst : in  STD_LOGIC_VECTOR (15 downto 0);
           id_pc : out  STD_LOGIC_VECTOR (15 downto 0);
           id_inst : out  STD_LOGIC_VECTOR (15 downto 0));
end IF_ID;

architecture Behavioral of IF_ID is

begin
	id_inst<=if_pc;

end Behavioral;

