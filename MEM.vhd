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


use defines.all;
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
           w_data_o : out  STD_LOGIC_VECTOR (15 downto 0);
           w_enble_o : out  STD_LOGIC;
           w_reg_o : out  STD_LOGIC_VECTOR (3 downto 0);
			  MEM_addr_mc : out STD_LOGIC_VECTOR(15 downto 0);
			  MEM_data_mc : out STD_LOGIC_VECTOR(15 downto 0);
			  MEM_data_op : out STD_LOGIC_VECTOR(1 downto 0);
			  MEM_dataget_mc:in STD_LOGIC_VECTOR(15 downto 0));
--			  MEM_inst : out  STD_LOGIC_VECTOR (15 downto 0));
end MEM;

architecture Behavioral of MEM is

begin
	w_data_o<=MEM_dataget_mc when(mem_op_i=OP_LW or mem_op_i=OP_LW_SP)else
				w_data_i;
	w_enble_o<=w_enble_i;
	w_reg_o<=w_reg_i;
	MEM_addr_mc<=mem_addr_i;
	MEM_data_mc<=w_data_i;
	MEM_data_op<="10" when(mem_op_i=OP_LW or mem_op_i=OP_LW_SP) else
					 "11" when (mem_op_i=OP_SW or mem_op_i=OP_SW_SP)else
					 "00";
end Behavioral;

