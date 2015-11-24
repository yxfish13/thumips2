----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:56:31 11/24/2015 
-- Design Name: 
-- Module Name:    MemControler - Behavioral 
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
use defines.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MemControler is
    Port ( ram1_oe : out  STD_LOGIC;
           ram1_we : out  STD_LOGIC;
           ram1_en : out  STD_LOGIC;
           ram1_data : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram1_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram2_oe : out  STD_LOGIC;
           ram2_we : out  STD_LOGIC;
           ram2_en : out  STD_LOGIC;
           ram2_data : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram2_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           rdn : out  STD_LOGIC;
           wrn : out  STD_LOGIC;
           data_ready : in  STD_LOGIC;
           tsre : in  STD_LOGIC;
           Memc_pause : out  STD_LOGIC;
           Mem_addr : in  STD_LOGIC_VECTOR (15 downto 0);
           Mem_data_in : in  STD_LOGIC_VECTOR (15 downto 0);
           Mem_data_out : out  STD_LOGIC_VECTOR (15 downto 0);
           Mem_op : in  STD_LOGIC_VECTOR (1 downto 0);
           IF_addr : in  STD_LOGIC_VECTOR (15 downto 0);
           IF_data_out : out  STD_LOGIC_VECTOR (15 downto 0);
           CLK : in  STD_LOGIC);
end MemControler;

architecture Behavioral of MemControler is
signal tmp:std_logic_vector(15 downto 0);
begin
	--rdn <= '0' when(Mem_op(1) = '1' and Mem_addr(15 downto 1) = "101111110000000" )else
		--	'1';
	Memc_pause<='1' when(Mem_op(1) = '1' and Mem_addr(15)='0') else
					'0';
	ram2_addr<="00"&Mem_addr when(Mem_op(1)='1' and Mem_addr(15)='0') else
				"00"&IF_addr;
	ram2_en<='0';
	ram2_oe<='1' when (Mem_op="11" and Mem_addr(15)='0')else
				'0';
	ram2_we<=not CLK when(Mem_op="11" and Mem_addr(15)='0') else
				'1';
	process(Mem_addr,Mem_data_in,Mem_op,IF_addr,CLK)
	begin
		if (Mem_op="11" and Mem_addr(15)='0') then
			ram2_data<=Mem_data_in;
		else--if (CLK'event and CLK='0') then
				ram2_data<=(others=>'Z');
		end if;
		if (mem_op="11" and mem_addr(15)='1') then
			ram1_data<=Mem_data_in;
		else--if (CLK'event and CLK='0') then
				ram1_data<=(others=>'Z');
		end if;
		if (Mem_op(1)='1' and Mem_addr(15)='1') then
			if (Mem_addr(15 downto 0)="1011111100000000") then
				ram1_en<='1';
				if (Mem_op(0)='1') then
					rdn<='1';
					wrn<=CLK;
				else
					rdn<= not CLK;
					wrn<='1';
				end if;
			else
				rdn<='1';
				wrn<='1';
				ram1_en<='0';
				ram1_addr<="00"&Mem_addr;
				if (Mem_op(0)='1') then
					ram1_oe<='1';
					ram1_we<=not CLK;
				--	ram1_data<=Mem_data_in;
				else--if (CLK='0') then
					ram1_oe<='0';
					ram1_we<='1';
				--	ram1_data<=(others=>'Z');
				end if;
			end if;
		else
			ram1_en<='1';
			rdn<='1';
			wrn<='1';
			ram1_we<='1';
			ram1_oe<='1';
		end if;
	end process;
	IF_data_out<=ram2_data;
	Mem_data_out<=ram2_data when(Mem_op="10" and Mem_addr(15)='0') else
					  "00000000000000"&data_ready&tsre when(Mem_addr="1011111100000001")else
					  ram1_data;
end Behavioral;

