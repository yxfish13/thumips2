----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:19:53 11/23/2015 
-- Design Name: 
-- Module Name:    IDRegisterFilter - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IDRegisterFilter is
    Port ( reg1_data : in  STD_LOGIC_VECTOR (15 downto 0);
           reg2_data : in  STD_LOGIC_VECTOR (15 downto 0);
           mem_w_data : in  STD_LOGIC_VECTOR (15 downto 0);
           mem_w_enable : in  STD_LOGIC;
           mem_w_reg : in  STD_LOGIC_VECTOR (3 downto 0);
           ex_w_data : in  STD_LOGIC_VECTOR (15 downto 0);
           ex_w_enable : in  STD_LOGIC;
           ex_w_reg : in  STD_LOGIC_VECTOR (3 downto 0);
			  load_reg : in  STD_LOGIC_VECTOR (3 downto 0);
			  load_enable : in  STD_LOGIC;
			  reg1 : in  STD_LOGIC_VECTOR (3 downto 0);
           reg2 : in  STD_LOGIC_VECTOR (3 downto 0);
			  reg1_enable,reg2_enable: in  STD_LOGIC;
			  regFilter_data1,regFilter_data2: out STD_LOGIC_VECTOR (15 downto 0);
			  pause_send : out  STD_LOGIC);
end IDRegisterFilter;

architecture Behavioral of IDRegisterFilter is

begin
	process (reg1_data,reg2_data,mem_w_data,mem_w_enable,mem_w_reg,ex_w_data,ex_w_enable,ex_w_reg,load_reg,load_enable,reg1,reg2,reg1_enable,reg2_enable)
	begin
		pause_send <= '0';
		if (reg1_enable = '1') then
			if (ex_w_enable = '1' and ex_w_reg = reg1) then
				regFilter_data1 <= ex_w_data;			
			else if (mem_w_enable = '1' and mem_w_reg = reg1) then
				regFilter_data1 <= mem_w_data;
			else
				regFilter_data1 <= reg1_data;
			end if; end if;
			
			if (load_enable = '1' and load_reg = reg1) then 
				pause_send <= '1';
			end if;			
			
		end if;
		if (reg2_enable = '1') then
			if (ex_w_enable = '1' and ex_w_reg = reg2) then
				regFilter_data2 <= ex_w_data;			
			else if (mem_w_enable = '1' and mem_w_reg = reg2) then
				regFilter_data2 <= mem_w_data;
			else
				regFilter_data2 <= reg2_data;
			end if; end if;
			
			if (load_enable = '1' and load_reg = reg2) then 
				pause_send <= '1';
			end if;	
		end if;
	end process;

end Behavioral;

