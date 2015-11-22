----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:18:15 11/20/2015 
-- Design Name: 
-- Module Name:    MEM - Behavioral 
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

entity MEM is
    Port ( w_data_i : in  STD_LOGIC_VECTOR (15 downto 0);
           w_enble_i : in  STD_LOGIC;
           w_reg_i : in  STD_LOGIC_VECTOR (3 downto 0);
           mem_op_i : in  STD_LOGIC_VECTOR (5 downto 0);
           mem_addr_i : in  STD_LOGIC_VECTOR (15 downto 0);
           RST : in  STD_LOGIC;
           w_data_o : out  STD_LOGIC_VECTOR (15 downto 0);
           w_enble_o : out  STD_LOGIC;
           w_reg_o : out  STD_LOGIC_VECTOR (3 downto 0));
end MEM;

architecture Behavioral of MEM is

begin
	w_enble_o<=RST;

end Behavioral;

