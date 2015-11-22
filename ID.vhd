----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:32:06 11/19/2015 
-- Design Name: 
-- Module Name:    ID - Behavioral 
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

entity ID is
    Port ( RST : in  STD_LOGIC;
	        pc_input : in  STD_LOGIC_VECTOR (15 downto 0);
           inst : in  STD_LOGIC_VECTOR (15 downto 0);
           reg1_data : in  STD_LOGIC_VECTOR (15 downto 0);
           reg2_data : in  STD_LOGIC_VECTOR (15 downto 0);
           mem_w_data : in  STD_LOGIC_VECTOR (15 downto 0);
           mem_w_enable : in  STD_LOGIC;
           mem_w_reg : in  STD_LOGIC_VECTOR (3 downto 0);
           ex_w_data : in  STD_LOGIC_VECTOR (15 downto 0);
           ex_w_enable : in  STD_LOGIC;
           ex_w_reg : in  STD_LOGIC_VECTOR (3 downto 0);
			  load_reg : in  STD_LOGIC_VECTOR (3 downto 0);
			  load_enable : in  STD_LOGIC; 
           pc_enable : out  STD_LOGIC;
           pc : out  STD_LOGIC_VECTOR (15 downto 0);
           pause_send : out  STD_LOGIC;
           op : out  STD_LOGIC_VECTOR (5 downto 0);
           reg1_o : out  STD_LOGIC_VECTOR (15 downto 0);
           reg2_o : out  STD_LOGIC_VECTOR (15 downto 0);
           reg1_a : out  STD_LOGIC_VECTOR (3 downto 0);
           reg2_a : out  STD_LOGIC_VECTOR (3 downto 0);
           w_enbale : out  STD_LOGIC;
           w_reg : out  STD_LOGIC_VECTOR (3 downto 0));
end ID;

architecture Behavioral of ID is

begin

	w_reg<=ex_w_reg;
end Behavioral;

