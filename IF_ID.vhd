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
use defines.ALL;
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
	process(CLK,RST)
	begin
		if (RST='0') then
			id_pc<="0000000000000000";
			id_inst <= ZERO;
		elsif (pause(3 downto 2)="11") then
		
		elsif (pause(3 downto 2)="10") then
			id_pc<=ZERO;
			id_inst<=ZERO;
		elsif(CLK'event and CLK = '0') then
			id_pc<=if_pc;
			id_inst<=if_inst;
		end if;
	end process;
end Behavioral;

