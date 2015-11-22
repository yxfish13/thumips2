----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:37:06 11/15/2015 
-- Design Name: 
-- Module Name:    PC_REG - Behavioral 
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
USE ieee.std_logic_signed.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC_REG is
    Port ( RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           pause : in  STD_LOGIC;
           pc_in : in  STD_LOGIC_VECTOR (15 downto 0);
			  pc_enable : in  STD_LOGIC;
           inst : out  STD_LOGIC_VECTOR (15 downto 0);           
           pc_out : out  STD_LOGIC_VECTOR (15 downto 0));
end PC_REG;

architecture Behavioral of PC_REG is
signal pc:STD_LOGIC_VECTOR (15 downto 0);
begin
	process (CLK)
	Begin
		if (RST = RstEnable) then 
			pc <= (others => '0');
		else
			pc_out <= pc + 1;
		end if;
	end process;

end Behavioral;

