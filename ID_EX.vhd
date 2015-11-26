----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:34:13 11/20/2015 
-- Design Name: 
-- Module Name:    ID_EX - Behavioral 
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ID_EX is
    Port ( id_op : in  STD_LOGIC_VECTOR (5 downto 0);
           id_reg1 : in  STD_LOGIC_VECTOR (15 downto 0);
           id_reg2 : in  STD_LOGIC_VECTOR (15 downto 0);
			  id_immediate : in  STD_LOGIC_VECTOR (15 downto 0);
           id_w_enable : in  STD_LOGIC;
           id_w_reg : in  STD_LOGIC_VECTOR (3 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           pause : in  std_logic_vector(4 downto 0);
           ex_op : out  STD_LOGIC_VECTOR (5 downto 0);
           ex_reg1 : out  STD_LOGIC_VECTOR (15 downto 0);
           ex_reg2 : out  STD_LOGIC_VECTOR (15 downto 0);
			  ex_immediate : out  STD_LOGIC_VECTOR (15 downto 0);
           ex_w_enable : out  STD_LOGIC;
           ex_w_reg : out  STD_LOGIC_VECTOR (3 downto 0));
end ID_EX;

architecture Behavioral of ID_EX is

begin
	process(CLK,RST)
	begin
		if (RST='0') then
			ex_op<=OP_NOP;
			ex_reg1<=(others=>'0');
			ex_reg2<=(others=>'0');
			ex_immediate<=(others=>'0');
			ex_w_enable<='0';
			ex_w_reg<=(others=>'0');
		elsif(CLK'event and CLK='0')then 
			if (pause = "00000") then
				ex_op<=id_op;
			else 
				if (pause(2 downto 1)="10") then
					ex_op <=OP_NOP;
				end if;
			end if;			
			ex_reg1<=id_reg1;
			ex_reg2<=id_reg2;
			ex_immediate<=id_immediate;
			ex_w_enable <= id_w_enable;
			ex_w_reg <= id_w_reg;
		end if;
	end process;
end Behavioral;

