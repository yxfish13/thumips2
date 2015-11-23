--
	--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package defines is

-- global defines
	constant RstEnable :std_logic := '0';
	constant RstDisable :std_logic := '1';
	constant WriteEnable :std_logic := '1';
	constant WriteDisable :std_logic := '0';
	constant ChipEnable :std_logic := '1';
	constant ChipDisable :std_logic := '0';
	constant ReadEnable :std_logic := '1';
	constant ReadDisable :std_logic := '0';
	constant InstValid :std_logic := '0';
	constant InstInvalid :std_logic := '1';
	constant Zero :std_logic_vector(15 downto 0) := "0000000000000000";

--abount inst
	constant Inst_ADDIU :std_logic_vector(4 downto 0) := "01001";
	constant Inst_ADDIU3 :std_logic_vector(4 downto 0) := "01000";
	constant Inst_ADDSP3 :std_logic_vector(4 downto 0) := "00000";
	
	constant Inst_ALUU :std_logic_vector(4 downto 0) := "11100";
	constant ALUU_ADDU :std_logic_vector(1 downto 0) := "01";
	constant ALUU_SUBU :std_logic_vector(1 downto 0) := "11";
	
	constant Inst_ALU :std_logic_vector(4 downto 0) := "11101";	
	constant ALU_AND :std_logic_vector(4 downto 0) := "01100";
	constant ALU_NOT :std_logic_vector(4 downto 0) := "01111";
	constant ALU_SLLV :std_logic_vector(4 downto 0) := "00100";
	constant ALU_OR :std_logic_vector(4 downto 0) := "01101";
	constant ALU_NEG :std_logic_vector(4 downto 0) := "01011";
	constant ALU_CMP :std_logic_vector(4 downto 0) := "01010";
	constant ALU_JR_MFPC :std_logic_vector(4 downto 0) := "00000";
	constant ALU_JR :std_logic_vector(7 downto 0) := "00000000";
	constant ALU_MFPC :std_logic_vector(7 downto 0) := "01000000";
	
	constant Inst_B :std_logic_vector(4 downto 0) := "00010";
	constant Inst_BEQZ :std_logic_vector(4 downto 0) := "00100";
	constant Inst_BNEZ :std_logic_vector(4 downto 0) := "00101";
	
	constant Inst_LI :std_logic_vector(4 downto 0) := "01101";
	constant Inst_LW :std_logic_vector(4 downto 0) := "10011";
	constant Inst_LW_SP :std_logic_vector(4 downto 0) := "10010";
	constant Inst_MFIH_MTIH :std_logic_vector(4 downto 0) := "11110";
	
	constant Inst_NOP :std_logic_vector(4 downto 0) := "00001";
	
	constant Inst_SLL_SRA :std_logic_vector(4 downto 0) := "00110";
	constant Sub_SLL :std_logic_vector(1 downto 0) := "00";
	constant Sub_SRA :std_logic_vector(1 downto 0) := "11";
	
	constant Inst_SW :std_logic_vector(4 downto 0) := "11011";
	constant Inst_SW_SP :std_logic_vector(4 downto 0) := "11010";
	
	
	constant Inst_CMPI :std_logic_vector(4 downto 0) := "01110";
	
	constant Inst_EXTEND :std_logic_vector(4 downto 0) := "01100";
	constant EXTEND_ADDSP :std_logic_vector(2 downto 0) := "011";
	constant EXTEND_BTEQZ :std_logic_vector(2 downto 0) := "000";
	constant EXTEND_MTSP :std_logic_vector(2 downto 0) := "100";
	
--about ALU id
	constant OP_ADDIU :std_logic_vector(5 downto 0) := "000000";
	constant OP_ADDIU3 :std_logic_vector(5 downto 0) := "000001";
	constant OP_ADDSP :std_logic_vector(5 downto 0) := "000010";
	constant OP_ADDU :std_logic_vector(5 downto 0) := "000011";
	constant OP_AND :std_logic_vector(5 downto 0) := "000100";
	constant OP_B :std_logic_vector(5 downto 0) := "000101";
	constant OP_BEQZ :std_logic_vector(5 downto 0) := "000110";
	constant OP_BNEZ :std_logic_vector(5 downto 0) := "000111";
	constant OP_BTEQZ :std_logic_vector(5 downto 0) := "001000";
	constant OP_CMP :std_logic_vector(5 downto 0) := "001001";
	constant OP_JR :std_logic_vector(5 downto 0) := "001010";
	constant OP_LI :std_logic_vector(5 downto 0) := "001011";
	constant OP_LW :std_logic_vector(5 downto 0) := "001100";
	constant OP_LW_SP :std_logic_vector(5 downto 0) := "001101";
	constant OP_MFIH :std_logic_vector(5 downto 0) := "001110";
	constant OP_MFPC :std_logic_vector(5 downto 0) := "001111";
	constant OP_MTIH :std_logic_vector(5 downto 0) := "010000";
	constant OP_MTSP :std_logic_vector(5 downto 0) := "010001";
	constant OP_NOP :std_logic_vector(5 downto 0) := "010010";
	constant OP_OR :std_logic_vector(5 downto 0) := "010011";
	constant OP_SLL :std_logic_vector(5 downto 0) := "010100";
	constant OP_SRA :std_logic_vector(5 downto 0) := "010101";
	constant OP_SUBU :std_logic_vector(5 downto 0) := "010110";
	constant OP_SW :std_logic_vector(5 downto 0) := "010111";
	constant OP_SW_SP :std_logic_vector(5 downto 0) := "011000";
	constant OP_NOT :std_logic_vector(5 downto 0) := "011001";
	constant OP_SLLV :std_logic_vector(5 downto 0) := "011010";
	constant OP_ADDSP3 :std_logic_vector(5 downto 0) := "011011";
	constant OP_CMPI :std_logic_vector(5 downto 0) := "011100";
	constant OP_NEG :std_logic_vector(5 downto 0) := "011101";

-- type <new_type> is
--  record
--    <type_name>        : std_logic_vector( 7 downto 0);
--    <type_name>        : std_logic;
-- end record;
--
-- Declare constants
--
-- constant <constant_name>		: time := <time_unit> ns;
-- constant <constant_name>		: integer := <value;
--
-- Declare functions and procedure
--
-- function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--

end defines;

package body defines is

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end defines;
