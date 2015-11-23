----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:41:09 11/20/2015 
-- Design Name: 
-- Module Name:    EX - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use defines.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EX is
    Port ( op : in  STD_LOGIC_VECTOR (5 downto 0);
           reg1 : in  STD_LOGIC_VECTOR (15 downto 0);
           reg2 : in  STD_LOGIC_VECTOR (15 downto 0);
           w_enbale_i : in  STD_LOGIC;
           w_reg_i : in  STD_LOGIC_VECTOR (3 downto 0);
           RST : in  STD_LOGIC;
           pause_send : out  STD_LOGIC; -- pause only
           w_data : out  STD_LOGIC_VECTOR (15 downto 0);--every
           w_enable_o : out  STD_LOGIC;--every
           w_reg_o : out  STD_LOGIC_VECTOR (3 downto 0); -- constant
           mem_op : out  STD_LOGIC_VECTOR (5 downto 0);-- constant
           mem_addr : out  STD_LOGIC_VECTOR (15 downto 0);--mem only
			  load_reg : out  STD_LOGIC_VECTOR (3 downto 0);-- constant
			  load_enable : out  STD_LOGIC);-- load only
end EX;

architecture Behavioral of EX is
begin
	w_reg_o <= w_reg_i;
	load_reg <= w_reg_i;
	mem_op <= op;
	process (op,reg1,reg2,w_enbale_i,w_reg_i,RST)
	begin
		if (RST = RstEnable) then
			
		else
			pause_send <= '0';
			load_enable <= '0';
			case op is
				when OP_ADDIU | OP_ADDIU3 | OP_ADDSP | OP_ADDU | OP_ADDSP3=>
					w_enable_o<= '1';
					w_data <= reg1 + reg2;
				when OP_AND =>
					w_enable_o<= '1';
					w_data <= reg1 and reg2;
				when OP_OR =>
					w_enable_o<= '1';
					w_data <= reg1 or reg2;
				when OP_SLL =>
					w_enable_o<= '1';
					if (reg2 = ZERO) then
						w_data <= TO_STDLOGICVECTOR(TO_BITVECTOR(reg1) sll 8);
					else
						w_data <= TO_STDLOGICVECTOR(TO_BITVECTOR(reg1) sll CONV_INTEGER(reg2));
					end if;
				when OP_SRA =>
					w_enable_o<= '1';
					if (reg2 = ZERO) then
						w_data <= TO_STDLOGICVECTOR(TO_BITVECTOR(reg1) sra 8);
					else
						w_data <= TO_STDLOGICVECTOR(TO_BITVECTOR(reg1) sra CONV_INTEGER(reg2));
					end if;
				when OP_SUBU =>
					w_enable_o<= '1';
					w_data <= reg1 - reg2;
				when OP_CMP | OP_CMPI =>
					w_enable_o<= '1';
					if (reg1 = reg2) then
						w_data <= "0000000000000000";
					else
						w_data <= "0000000000000001";
					end if;
				when OP_NEG =>
					w_enable_o<= '1';
					w_data <="0000000000000000" - reg2;
				when OP_NOT =>
					w_enable_o<= '1';
					w_data <=not reg2;				
				when OP_SLLV =>
					w_enable_o<= '1';
					w_data <= TO_STDLOGICVECTOR(TO_BITVECTOR(reg2) sll CONV_INTEGER(reg1));					
				when OP_LW | OP_LW_SP=>
					w_enable_o<= '0';
					mem_addr <= reg1 + reg2;
					load_enable <= '1';					
				when OP_SW | OP_SW_SP=>
					w_enable_o<= '0';
					mem_addr <= reg1 + reg2;
				when OP_MFIH | OP_MFPC | OP_MTIH | OP_MTSP | OP_LI=>
					w_enable_o<= '1';
					w_data <= reg1;			
				when OP_B | OP_BEQZ | OP_BNEZ | OP_BTEQZ | OP_JR=>
					w_enable_o<= '0';
				when OP_NOP =>
					w_enable_o<= '0';
				when others =>
					w_enable_o<= '0';
					
			end case;
		end if;
	end process;
	
	

end Behavioral;

