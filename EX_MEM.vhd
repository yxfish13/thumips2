----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:46:15 11/20/2015 
-- Design Name: 
-- Module Name:    EX_MEM - Behavioral 
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

entity EX_MEM is
    Port ( ex_w_data_i : in  STD_LOGIC_VECTOR (15 downto 0);
           ex_w_enable_i : in  STD_LOGIC;
           ex_w_reg_i : in  STD_LOGIC_VECTOR (3 downto 0);
           ex_mem_op : in  STD_LOGIC_VECTOR (5 downto 0);
           ex_mem_addr : in  STD_LOGIC_VECTOR (15 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           pause : in  std_logic_vector(4 downto 0);
           mem_w_data_o : out  STD_LOGIC_VECTOR (15 downto 0);
           mem_w_enable_o : out  STD_LOGIC;
           mem_w_reg_o : out  STD_LOGIC_VECTOR (3 downto 0);
           mem_op_o : out  STD_LOGIC_VECTOR (5 downto 0);
           mem_addr_o : out  STD_LOGIC_VECTOR (15 downto 0));
end EX_MEM;

architecture Behavioral of EX_MEM is

begin

	mem_w_enable_o <= CLK;
end Behavioral;

