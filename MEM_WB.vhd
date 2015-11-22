----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:20:05 11/20/2015 
-- Design Name: 
-- Module Name:    MEM_WB - Behavioral 
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

entity MEM_WB is
    Port ( mem_w_data : in  STD_LOGIC_VECTOR (15 downto 0);
           mem_w_enable : in  STD_LOGIC;
           mem_reg : in  STD_LOGIC_VECTOR (3 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           pause : in  std_logic_vector(4 downto 0);
           wb_w_data : out  STD_LOGIC_VECTOR (15 downto 0);
           wb_w_enable : out  STD_LOGIC;
           wb_reg : out  STD_LOGIC_VECTOR (3 downto 0));
end MEM_WB;

architecture Behavioral of MEM_WB is

begin

	wb_w_enable <= RST;
end Behavioral;

