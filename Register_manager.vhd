----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:23:03 11/20/2015 
-- Design Name: 
-- Module Name:    Register_manager - Behavioral 
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

entity RegisterManager is
    Port ( reg1_addr : in  STD_LOGIC_VECTOR (3 downto 0);
           reg2_addr : in  STD_LOGIC_VECTOR (3 downto 0);
           w_enable : in  STD_LOGIC;
           w_addr : in  STD_LOGIC_VECTOR (3 downto 0);
           w_data : in  STD_LOGIC_VECTOR (15 downto 0);
           RST : in  STD_LOGIC;
           r_data1 : out  STD_LOGIC_VECTOR (15 downto 0);
           r_data2 : out  STD_LOGIC_VECTOR (15 downto 0));
end RegisterManager;

architecture Behavioral of RegisterManager is
type regbase is array(15 downto 0) of STD_LOGIC_VECTOR (15 downto 0);
signal regs:regbase;
begin
	process (RST,w_data,w_addr)
	begin
		if (RST='0')then
			regs(0)<=(others=>'0');
			regs(1)<=(others=>'0');
			regs(2)<=(others=>'0');
			regs(3)<=(others=>'0');
			regs(4)<=(others=>'0');
			regs(5)<=(others=>'0');
			regs(6)<=(others=>'0');
			regs(7)<=(others=>'0');
			regs(8)<=(others=>'0');
			regs(9)<=(others=>'0');
			regs(10)<=(others=>'0');
			regs(11)<=(others=>'0');
			regs(12)<=(others=>'0');
			regs(13)<=(others=>'0');
			regs(14)<=(others=>'0');
			regs(15)<=(others=>'0');
		elsif (w_enable='1') then
			regs(CONV_INTEGER(w_addr))<=w_data;
		end if;
	end process;
	r_data1<=w_data when (w_addr=reg1_addr and w_enable='1' )else
		regs(CONV_INTEGER(reg1_addr));
	r_data2<=w_data when (w_addr=reg2_addr and w_enable='1' )else
		regs(CONV_INTEGER(reg2_addr));
end Behavioral;

