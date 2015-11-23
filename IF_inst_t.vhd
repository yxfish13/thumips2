----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:04:31 11/22/2015 
-- Design Name: 
-- Module Name:    IF_inst - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IF_inst_t is
    Port ( pc_in : in  STD_LOGIC_VECTOR (15 downto 0);
			  clk:in STD_LOGIC;
			  pc_out1 : out  STD_LOGIC_VECTOR (15 downto 0);
			  oe,we,en : out STD_LOGIC;
			  IF_addr : out STD_LOGIC_VECTOR(17 downto 0);
           IF_inst : inout  STD_LOGIC_VECTOR (15 downto 0));
end IF_inst_t;

architecture Behavioral of IF_inst_t is

begin
	pc_out1<=pc_in+'1';
	process(clk)
	begin
		if (clk'event and clk='0') then
			IF_inst <="ZZZZZZZZZZZZZZZZ";
			oe <= '1';
			we <= '1';
			en <= '0';
		end if;
	end process;
	IF_addr(17 downto 16) <="00";
	IF_addr(15 downto 0) <= pc_in;
end Behavioral;

