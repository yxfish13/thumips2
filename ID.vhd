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
USE IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use defines.ALL;

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
			  
           pc_enable : out  STD_LOGIC;-- jmp only
           pc : out  STD_LOGIC_VECTOR (15 downto 0);--jmp only
           pause_send : out  STD_LOGIC;
			  
           op : out  STD_LOGIC_VECTOR (5 downto 0);-- every
           reg1_o : out  STD_LOGIC_VECTOR (15 downto 0);--use Only
           reg2_o : out  STD_LOGIC_VECTOR (15 downto 0);--use Only
           reg1_a : out  STD_LOGIC_VECTOR (3 downto 0);-- constant
           reg2_a : out  STD_LOGIC_VECTOR (3 downto 0);-- constant
           w_enbale : out  STD_LOGIC; -- unused
           w_reg : out  STD_LOGIC_VECTOR (3 downto 0));-- write only
end ID;

architecture Behavioral of ID is
	COMPONENT IDRegisterFilter
	PORT(
		reg1_data : IN std_logic_vector(15 downto 0);
		reg2_data : IN std_logic_vector(15 downto 0);
		mem_w_data : IN std_logic_vector(15 downto 0);
		mem_w_enable : IN std_logic;
		mem_w_reg : IN std_logic_vector(3 downto 0);
		ex_w_data : IN std_logic_vector(15 downto 0);
		ex_w_enable : IN std_logic;
		ex_w_reg : IN std_logic_vector(3 downto 0);
		load_reg : IN std_logic_vector(3 downto 0);
		load_enable : IN std_logic;
		reg1 : IN std_logic_vector(3 downto 0);
		reg2 : IN std_logic_vector(3 downto 0);
		reg1_enable : IN std_logic;
		reg2_enable : IN std_logic;          
		regFilter_data1 : OUT std_logic_vector(15 downto 0);
		regFilter_data2 : OUT std_logic_vector(15 downto 0);
		pause_send : OUT std_logic
		);
	END COMPONENT;
signal reg1,reg2:STD_LOGIC_VECTOR (3 downto 0);--useOnly
signal reg1_enable,reg2_enable:STD_LOGIC;-- every
signal regFilter_data1,regFilter_data2:STD_LOGIC_VECTOR (15 downto 0);
signal Sign_extend:STD_LOGIC_VECTOR (15 downto 0);
begin      	
	--w_reg<=ex_w_reg;
	reg1_a <= reg1;
	reg2_a <= reg2;
	Sign_extend	<= SXT(inst(7 downto 0), 16);
	process (RST,pc_input,inst,regFilter_data1,regFilter_data2,Sign_extend)
	begin
		if (RST = RstEnable) then
		
		else
			pc_enable <= '0';
			case inst(15 downto 11) is
				when Inst_ADDIU =>
					op <= OP_ADDIU;
					reg1_enable <= '1';
					reg2_enable <= '0';
					reg1 <= '0' & inst(10 downto 8);
					w_reg <= '0' & inst(10 downto 8);
				   reg1_o <= regFilter_data1;
					reg2_o <= Sign_extend; 
					--imediate
				when Inst_ADDIU3 =>					
					op <= OP_ADDIU3;
					reg1_enable <= '1';
					reg2_enable <= '0';
					reg1 <= '0' & inst(10 downto 8);
					w_reg <= '0' & inst(7 downto 5);
				   reg1_o <= regFilter_data1;
					reg2_o <= SXT(inst(3 downto 0), 16);
				when Inst_ADDSP3 =>					
					op <= OP_ADDSP3;
					reg1_enable <= '1';
					reg2_enable <= '0';
					reg1 <= REG_SP;
					w_reg <= '0' & inst(10 downto 8);
				   reg1_o <= regFilter_data1;
					reg2_o <= Sign_extend;
				when Inst_ALUU =>
					if (inst(1 downto 0) = ALUU_ADDU) then
						op <= OP_ADDU;
					else
						op <= OP_SUBU;
					end if;
					reg1_enable <= '1';
					reg2_enable <= '1';
					reg1 <= '0' & inst(10 downto 8);
					reg2 <= '0' & inst(7 downto 5);
					w_reg <= '0' & inst(4 downto 2);
				   reg1_o <= regFilter_data1;
					reg2_o <= regFilter_data2;
				when Inst_ALU =>
					if (inst(4 downto 0) = "0000") then
						if (inst(6) = '1') then-- MFPC
							op <= OP_MFPC;
							reg1_enable <= '0';
							reg2_enable <= '0';
							w_reg <= '0' & inst(10 downto 8);
							reg1_o <= pc_input;
						else
							op <= OP_JR;
							reg1_enable <= '1';
							reg2_enable <= '0';							
							reg1 <= '0' & inst(10 downto 8);
							pc_enable <= '1';	
							pc <= regFilter_data1;
						end if;
					else
						reg1 <= '0' & inst(10 downto 8);
						reg2 <= '0' & inst(7 downto 5);								
						reg1_o <= regFilter_data1;
						reg2_o <= regFilter_data2;
						case inst(4 downto 0) is
							when ALU_AND=>
								op <= OP_AND;
								reg1_enable <= '1';
								reg2_enable <= '1';
								w_reg <= '0' & inst(10 downto 8);								
							when ALU_NOT=>
								op <= OP_NOT;
								reg1_enable <= '0';
								reg2_enable <= '1';
								w_reg <= '0' & inst(10 downto 8);	
							when ALU_SLLV=>
								op <= OP_SLLV;
								reg1_enable <= '1';
								reg2_enable <= '1';
								w_reg <= '0' & inst(7 downto 5);	
							when ALU_OR=>
								op <= OP_OR;
								reg1_enable <= '1';
								reg2_enable <= '1';
								w_reg <= '0' & inst(10 downto 8);	
							when ALU_NEG=>
								reg1_enable <= '0';
								reg2_enable <= '1';
								w_reg <= '0' & inst(10 downto 8);	
								op <= OP_NEG;
							when ALU_CMP=>
								op <= OP_CMP;
								reg1_enable <= '1';
								reg2_enable <= '1';
								w_reg <= REG_T;								
							when others=>
								op <= OP_NOP;
								reg1_enable <= '0';
								reg2_enable <= '0';
						end case;
					end if;
					
				when Inst_SLL_SRA =>
					if (inst(1 downto 0) = Sub_SLL) then
						op <= OP_SLL;
					else
						op <= OP_SRA;
					end if;
					reg1_enable <= '1';
					reg2_enable <= '0';
					reg1 <= '0' & inst(7 downto 5); 
					w_reg <= '0' & inst(10 downto 8);
					reg1_o <= regFilter_data1;
					reg2_o <= "0000000000000" & inst(4 downto 2);
				when Inst_CMPI =>
					op <= OP_CMP;
					reg1_enable <= '1';
					reg2_enable <= '0';
					w_reg <= REG_T;
					reg1 <='0' & inst(10 downto 8);
					reg1_o <= regFilter_data1;
					reg2_o <= Sign_extend;
				when Inst_MFIH_MTIH =>
					if (inst(0) = '0') then -- MFIH
						op <= OP_MFIH;
						reg1 <= REG_IH;
						w_reg <= '0' & inst(10 downto 8);
					else
						op <= OP_MTIH;
						reg1 <= '0' & inst(10 downto 8);
						w_reg <= REG_IH;
					end if;
					reg1_enable <= '1';
					reg2_enable <= '0';
					reg1_o <= regFilter_data1;
				when Inst_EXTEND =>
					case inst(10 downto 8) is 
						when EXTEND_ADDSP=>
							op <= OP_ADDSP;
							reg1_enable <= '1';
							reg2_enable <= '0';
							reg1 <= REG_SP;
							w_reg <= REG_SP;
							reg1_o <= regFilter_data1;
							reg2_o <= Sign_extend;
						when EXTEND_BTEQZ=>
							op <= OP_BTEQZ;
							reg1_enable <= '1';
							reg2_enable <= '0';							
							reg1 <= REG_T;
							if (regFilter_data1 = ZERO) then
								pc_enable <= '1';	
								pc <= pc_input + Sign_extend;	  
							else
								pc_enable <= '0';
							end if;
						when EXTEND_MTSP=>
							op <= OP_MTSP;
							reg1_enable <= '1';
							reg2_enable <= '0';
							reg1 <= '0' & inst(10 downto 8);
							w_reg <= REG_SP;
							reg1_o <= regFilter_data1;
						when others=>
							op <= OP_NOP;
							reg1_enable <= '0';
							reg2_enable <= '0';
					end case;
				when Inst_B =>					
					op <= OP_B;
					reg1_enable <= '0';
					reg2_enable <= '0';				
					pc_enable <= '1';	
					pc <= pc_input + SXT(inst(10 downto 0),16);
				when Inst_BEQZ =>
					op <= OP_BEQZ;
					reg1_enable <= '1';
					reg2_enable <= '0';							
					reg1 <= '0' & inst(10 downto 8);
					if (regFilter_data1 = ZERO) then
						pc_enable <= '1';	
						pc <= pc_input + Sign_extend;	  
					else
						pc_enable <= '0';
					end if;
				when Inst_BNEZ =>
					op <= OP_BNEZ;
					reg1_enable <= '1';
					reg2_enable <= '0';							
					reg1 <= '0' & inst(10 downto 8);
					if (regFilter_data1 = ZERO) then
						pc_enable <= '0';  
					else
						pc_enable <= '1';	
						pc <= pc_input + Sign_extend;	
					end if;
				when Inst_LI =>
					op <= OP_LI;
					reg1_enable <= '0';
					reg2_enable <= '0';
					w_reg <= '0' & inst(10 downto 8);
				   reg1_o <= Sign_extend;
				when Inst_LW =>
				   op <= OP_LW;
					reg1_enable <= '1';
					reg2_enable <= '0';
					reg1 <= '0' & inst(10 downto 8);
					w_reg <= '0' & inst(7 downto 5);
				   reg1_o <= regFilter_data1;
					reg2_o <= SXT(inst(4 downto 0), 16);
				when Inst_LW_SP =>
					op <= OP_LW_SP;
					reg1_enable <= '1';
					reg2_enable <= '0';
					reg1 <= REG_SP;
					w_reg <= '0' & inst(10 downto 8);
				   reg1_o <= regFilter_data1;
					reg2_o <= Sign_extend; 
				
					
				when Inst_NOP =>
					op <= OP_NOP;
					reg1_enable <= '0';
					reg2_enable <= '0';
				
	  
				when Inst_SW =>
				when Inst_SW_SP =>
				
				
				when others =>
			end case;
		end if;
	end process;
	Inst_IDRegisterFilter: IDRegisterFilter PORT MAP(
		reg1_data => reg1_data,
		reg2_data => reg2_data,
		mem_w_data => mem_w_data,
		mem_w_enable => mem_w_enable,
		mem_w_reg => mem_w_reg,
		ex_w_data => ex_w_data,
		ex_w_enable => ex_w_enable,
		ex_w_reg => ex_w_reg,
		load_reg => load_reg,
		load_enable => load_enable,
		reg1 => reg1,
		reg2 => reg2,
		reg1_enable => reg1_enable,
		reg2_enable => reg2_enable,
		regFilter_data1 => regFilter_data1,
		regFilter_data2 => regFilter_data2,
		pause_send => pause_send
	);
end Behavioral;

