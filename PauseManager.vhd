----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:22:48 11/20/2015 
-- Design Name: 
-- Module Name:    PauseManager - Behavioral 
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

entity PauseManager is
    Port ( pause_from_id : in  STD_LOGIC;
           pause_from_ex : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           pause_IF : out  STD_LOGIC_vector(4 downto 0));
end PauseManager;

architecture Behavioral of PauseManager is

begin

	pause_IF <= "00000";
end Behavioral;

