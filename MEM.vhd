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
           RST : in  STD_LOGIC;
			  CLK : in STD_LOGIC;
           w_data_o : out  STD_LOGIC_VECTOR (15 downto 0);
           w_enble_o : out  STD_LOGIC;
           w_reg_o : out  STD_LOGIC_VECTOR (3 downto 0);
			  oe,we,en,rdn : out STD_LOGIC;
			  MEM_addr : out STD_LOGIC_VECTOR(17 downto 0);
           MEM_inst : inout  STD_LOGIC_VECTOR (15 downto 0));
end MEM;

architecture Behavioral of MEM is

begin
	w_enble_o<=w_enble_i;
	w_reg_o <= w_reg_i;
	w_data_o<=MEM_inst when(mem_op_i=OP_LW or mem_op_i=OP_LW_SP) else w_data_i;
	
	en <='0' when (mem_op_i=OP_LW or mem_op_i=OP_LW_SP or mem_op_i = OP_SW or mem_op_i = OP_SW_SP)else
		  '1';
	rdn<='1';
	MEM_addr <= "00"&mem_addr_i;
	process (mem_op_i,mem_addr_i,w_data_i)
	begin
		if (mem_op_i=OP_LW or mem_op_i=OP_LW_SP) then
			MEM_inst <= "ZZZZZZZZZZZZZZZZ";
			oe<='0';
			we<='1';
		elsif (mem_op_i = OP_SW or mem_op_i = OP_SW_SP) then
			we<=not CLK;
			oe<='1';
			MEM_inst<=w_data_i;
		else
			we<='1';
			oe<='1';
			MEM_inst <= "ZZZZZZZZZZZZZZZZ";
		end if;
	end process;
end Behavioral;

