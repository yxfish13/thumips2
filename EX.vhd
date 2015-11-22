----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:41:09 11/20/2015 
-- Design Name: 
-- Module Name:    EX - Behavioral 
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

entity EX is
    Port ( op : in  STD_LOGIC_VECTOR (5 downto 0);
           reg1 : in  STD_LOGIC_VECTOR (15 downto 0);
           reg2 : in  STD_LOGIC_VECTOR (15 downto 0);
           w_enbale_i : in  STD_LOGIC;
           w_reg_i : in  STD_LOGIC_VECTOR (3 downto 0);
           RST : in  STD_LOGIC;
           pause_send : out  STD_LOGIC;
           w_data : out  STD_LOGIC_VECTOR (15 downto 0);
           w_enable_o : out  STD_LOGIC;
           w_reg_o : out  STD_LOGIC_VECTOR (3 downto 0);
           mem_op : out  STD_LOGIC_VECTOR (5 downto 0);
           mem_addr : out  STD_LOGIC_VECTOR (15 downto 0);
			  load_reg : out  STD_LOGIC_VECTOR (3 downto 0);
			  load_enable : out  STD_LOGIC);
end EX;

architecture Behavioral of EX is

begin
	load_enable<=w_enbale_i;

end Behavioral;

