----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:29:00 11/15/2015 
-- Design Name: 
-- Module Name:    OpenMIPS - Behavioral 
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


entity OpenMIPS is
    Port ( CLK50 : in  STD_LOGIC;
           CLK11 : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  RDN :out std_logic;
           ram1_data_inst : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram1_data_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram1_OE,ram1_WE,ram1_EN : out  STD_LOGIC;
           ram2_data_inst : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram2_data_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram2_OE,ram2_WE,ram2_EN : out  STD_LOGIC);
end OpenMIPS;

architecture Behavioral of OpenMIPS is
	COMPONENT SubClk
	PORT(
		clk_fast : IN std_logic;
		rst : IN std_logic;          
		clk_slow : OUT std_logic
		);
	END COMPONENT;

	COMPONENT PC_IF
	PORT(
		PC_in : IN std_logic_vector(15 downto 0);
		rst : IN std_logic;
		clk : IN std_logic;
		pause : IN std_logic_vector(4 downto 0);          
		pc : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT IF_inst_t
	PORT(
		pc_in : IN std_logic_vector(15 downto 0);
		clk : IN std_logic;    
		IF_addr : OUT std_logic_vector(17 downto 0);
		IF_inst : INOUT std_logic_vector(15 downto 0);      
		pc_out1 : OUT std_logic_vector(15 downto 0);
		oe : OUT std_logic;
		we : OUT std_logic;
		en : OUT std_logic
		);
	END COMPONENT;
	COMPONENT PC_MUX
	PORT(
		PC_inF : IN std_logic_vector(15 downto 0);
		PC_enable : IN std_logic;
		PC_ID : IN std_logic_vector(15 downto 0);          
		next_PC : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	COMPONENT IF_ID
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		pause : IN std_logic_vector(4 downto 0);
		if_pc : IN std_logic_vector(15 downto 0);
		if_inst : IN std_logic_vector(15 downto 0);          
		id_pc : OUT std_logic_vector(15 downto 0);
		id_inst : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT ID
	PORT(
		RST : IN std_logic;
		pc_input : IN std_logic_vector(15 downto 0);
		inst : IN std_logic_vector(15 downto 0);
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
		pc_enable : OUT std_logic;
		pc : OUT std_logic_vector(15 downto 0);
		pause_send : OUT std_logic;
		op : OUT std_logic_vector(5 downto 0);
		reg1_o : OUT std_logic_vector(15 downto 0);
		reg2_o : OUT std_logic_vector(15 downto 0);
		reg1_a : OUT std_logic_vector(3 downto 0);
		reg2_a : OUT std_logic_vector(3 downto 0);
		w_enbale : OUT std_logic;
		w_reg : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	COMPONENT ID_EX
	PORT(
		id_op : IN std_logic_vector(5 downto 0);
		id_reg1 : IN std_logic_vector(15 downto 0);
		id_reg2 : IN std_logic_vector(15 downto 0);
		id_w_enable : IN std_logic;
		id_w_reg : IN std_logic_vector(3 downto 0);
		RST : IN std_logic;
		CLK : IN std_logic;
		pause : IN std_logic_vector(4 downto 0);          
		ex_op : OUT std_logic_vector(5 downto 0);
		ex_reg1 : OUT std_logic_vector(15 downto 0);
		ex_reg2 : OUT std_logic_vector(15 downto 0);
		ex_w_enable : OUT std_logic;
		ex_w_reg : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	COMPONENT EX
	PORT(
		op : IN std_logic_vector(5 downto 0);
		reg1 : IN std_logic_vector(15 downto 0);
		reg2 : IN std_logic_vector(15 downto 0);
		w_enbale_i : IN std_logic;
		w_reg_i : IN std_logic_vector(3 downto 0);
		RST : IN std_logic;          
		pause_send : OUT std_logic;
		w_data : OUT std_logic_vector(15 downto 0);
		w_enable_o : OUT std_logic;
		w_reg_o : OUT std_logic_vector(3 downto 0);
		mem_op : OUT std_logic_vector(5 downto 0);
		mem_addr : OUT std_logic_vector(15 downto 0);
		load_reg : OUT std_logic_vector(3 downto 0);
		load_enable : OUT std_logic
		);
	END COMPONENT;
	COMPONENT EX_MEM
	PORT(
		ex_w_data_i : IN std_logic_vector(15 downto 0);
		ex_w_enable_i : IN std_logic;
		ex_w_reg_i : IN std_logic_vector(3 downto 0);
		ex_mem_op : IN std_logic_vector(5 downto 0);
		ex_mem_addr : IN std_logic_vector(15 downto 0);
		RST : IN std_logic;
		CLK : IN std_logic;
		pause : IN std_logic_vector(4 downto 0);          
		mem_w_data_o : OUT std_logic_vector(15 downto 0);
		mem_w_enable_o : OUT std_logic;
		mem_w_reg_o : OUT std_logic_vector(3 downto 0);
		mem_op_o : OUT std_logic_vector(5 downto 0);
		mem_addr_o : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT MEM
	PORT(
		w_data_i : IN std_logic_vector(15 downto 0);
		w_enble_i : IN std_logic;
		w_reg_i : IN std_logic_vector(3 downto 0);
		mem_op_i : IN std_logic_vector(5 downto 0);
		mem_addr_i : IN std_logic_vector(15 downto 0);
		RST : IN std_logic;
		CLK : IN std_logic;    
		MEM_inst : INOUT std_logic_vector(15 downto 0);      
		w_data_o : OUT std_logic_vector(15 downto 0);
		w_enble_o : OUT std_logic;
		w_reg_o : OUT std_logic_vector(3 downto 0);
		oe : OUT std_logic;
		we : OUT std_logic;
		en : OUT std_logic;
		rdn : OUT std_logic;
		MEM_addr : OUT std_logic_vector(17 downto 0)
		);
	END COMPONENT;
	COMPONENT MEM_WB
	PORT(
		mem_w_data : IN std_logic_vector(15 downto 0);
		mem_w_enable : IN std_logic;
		mem_reg : IN std_logic_vector(3 downto 0);
		RST : IN std_logic;
		CLK : IN std_logic;
		pause : IN std_logic_vector(4 downto 0);          
		wb_w_data : OUT std_logic_vector(15 downto 0);
		wb_w_enable : OUT std_logic;
		wb_reg : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	COMPONENT RegisterManager
	PORT(
		reg1_addr : IN std_logic_vector(3 downto 0);
		reg2_addr : IN std_logic_vector(3 downto 0);
		w_enable : IN std_logic;
		w_addr : IN std_logic_vector(3 downto 0);
		w_data : IN std_logic_vector(15 downto 0);
		RST : IN std_logic;          
		r_data1 : OUT std_logic_vector(15 downto 0);
		r_data2 : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT PauseManager
	PORT(
		pause_from_id : IN std_logic;
		pause_from_ex : IN std_logic;
		RST : IN std_logic;          
		pause_IF : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;

signal CLK: STD_LOGIC;

signal pause_manager: std_logic_vector(4 downto 0);
signal pc_next : std_logic_vector(15 downto 0);
signal PC_IF_in :std_logic_vector(15 downto 0);
signal pc_in: std_logic_vector(15 downto 0);
signal pc_enable: STD_LOGIC;
signal if_pc: std_logic_vector(15 downto 0);
--signal if_inst:std_logic_vector(15 downto 0);
signal id_pc: std_logic_vector(15 downto 0);
signal id_inst:std_logic_vector(15 downto 0);
signal rdata1:std_logic_vector(15 downto 0);
signal rdata2:std_logic_vector(15 downto 0);
signal mem_w_data_id:std_logic_vector(15 downto 0);
signal mem_w_enable_id:std_logic;
signal mem_w_reg_id:std_logic_vector(3 downto 0);
signal ex_w_data_id:std_logic_vector(15 downto 0);
signal ex_w_enable_id:std_logic;
signal ex_w_reg_id:std_logic_vector(3 downto 0);
signal load_reg:std_logic_vector(3 downto 0);
signal load_enable:std_logic;
signal pause_from_id:std_logic;
signal pause_from_ex:std_logic;
signal id_op:std_logic_vector(5 downto 0);
signal id_reg1:std_logic_vector(15 downto 0);
signal id_reg2:std_logic_vector(15 downto 0);
signal id_w_enable:std_logic;
signal id_w_reg : std_logic_vector(3 downto 0);
signal reg1_a : std_logic_vector(3 downto 0);
signal reg2_a : std_logic_vector(3 downto 0);
signal ex_op:std_logic_vector(5 downto 0);
signal ex_reg1:std_logic_vector(15 downto 0);
signal ex_reg2:std_logic_vector(15 downto 0);
signal ex_w_enable:std_logic;
signal ex_w_reg : std_logic_vector(3 downto 0);

signal ex_w_data_i : STD_LOGIC_VECTOR (15 downto 0);
signal ex_w_enable_i : STD_LOGIC;
signal ex_w_reg_i : STD_LOGIC_VECTOR (3 downto 0);
signal ex_mem_op : STD_LOGIC_VECTOR (5 downto 0);
signal ex_mem_addr : STD_LOGIC_VECTOR (15 downto 0);
signal mem_w_data_o : STD_LOGIC_VECTOR (15 downto 0);
signal mem_w_enable_o : STD_LOGIC;
signal mem_w_reg_o : STD_LOGIC_VECTOR (3 downto 0);
signal mem_op_o : STD_LOGIC_VECTOR (5 downto 0);
signal mem_addr_o : STD_LOGIC_VECTOR (15 downto 0);

signal mem_w_data_i :std_logic_vector(15 downto 0);
signal mem_w_enable_i :std_logic;
signal mem_reg_i :std_logic_vector(3 downto 0);       
signal wb_w_data_o :std_logic_vector(15 downto 0);
signal wb_w_enable_o :std_logic;
signal wb_reg_o :std_logic_vector(3 downto 0);

signal a,b,c:std_logic;
signal d,e,f,g:std_logic_vector(15 downto 0);
--attribute box_type : string;
--attribute box_type of system : component is "user_black_box";
begin
   --CLK <= CLK50;
   mem_w_data_id <= ex_w_data_i;
   mem_w_enable_id <= ex_w_enable_i;
   mem_w_reg_id <= ex_w_reg_i;
   ex_w_data_id <= mem_w_data_i;
   ex_w_enable_id <= mem_w_enable_i;
   ex_w_reg_id <= mem_reg_i;
	--Inst_PC_REG: PC_REG PORT MAP(
		--RST => RST,
		--CLK => CLK,
		--pause => pause_IF,
		--pc_in => pc_in,
		--pc_enable => pc_enable,
		--inst => if_inst,
		--pc_out => if_pc
	--);
	Inst_PC_IF: PC_IF PORT MAP(
		PC_in => pc_next,
		rst => RST,
		clk => CLK,
		pause => pause_manager,
		pc => PC_IF_in
	);
	Inst_IF_inst_t: IF_inst_t PORT MAP(
		pc_in => PC_IF_in,
		clk => CLK,
		pc_out1 => if_pc,
		oe => Ram1_OE,
		we => Ram1_WE,
		en => Ram1_EN,
		IF_addr => ram1_data_addr,
		IF_inst => ram1_data_inst
	);

	Inst_PC_MUX: PC_MUX PORT MAP(
		PC_inF => if_pc,
		PC_enable => pc_enable,
		PC_ID => pc_in,
		next_PC => pc_next
	);
	
	Inst_IF_ID: IF_ID PORT MAP(
		CLK => CLK,
		RST => RST,
		pause => pause_manager,
		if_pc => if_pc,
		if_inst => ram1_data_inst,
		id_pc => id_pc,
		id_inst => id_inst
	);
	Inst_ID: ID PORT MAP(
		RST => RST,
		pc_input => id_pc,
		inst => id_inst,
		reg1_data => rdata1,
		reg2_data => rdata2,
		mem_w_data => mem_w_data_id,
		mem_w_enable => mem_w_enable_id,
		mem_w_reg => mem_w_reg_id,
		ex_w_data => ex_w_data_id,
		ex_w_enable => ex_w_enable_id,
		ex_w_reg => ex_w_reg_id,
		load_reg => load_reg,
		load_enable => load_enable,
		pc_enable => pc_enable,
		pc => pc_in,
		pause_send => pause_from_id,
		op => id_op,
		reg1_o => id_reg1,
		reg2_o => id_reg2,
		reg1_a => reg1_a,
		reg2_a => reg2_a,
		w_enbale => id_w_enable,
		w_reg => id_w_reg
	);
	Inst_ID_EX: ID_EX PORT MAP(
		id_op => id_op,
		id_reg1 => id_reg1,
		id_reg2 => id_reg2,
		id_w_enable => id_w_enable,
		id_w_reg => id_w_reg,
		RST => RST,
		CLK => CLK,
		pause => pause_manager,
		ex_op => ex_op,
		ex_reg1 => ex_reg1,
		ex_reg2 => ex_reg2,
		ex_w_enable => ex_w_enable,
		ex_w_reg => ex_w_reg
	);
	Inst_EX: EX PORT MAP(
		op => ex_op,
		reg1 => ex_reg1,
		reg2 => ex_reg2,
		w_enbale_i => ex_w_enable,
		w_reg_i => ex_w_reg,
		RST => RST,
		pause_send => pause_from_ex,
		w_data => ex_w_data_i,
		w_enable_o => ex_w_enable_i,
		w_reg_o => ex_w_reg_i,
		mem_op => ex_mem_op,
		mem_addr => ex_mem_addr,
		load_reg => load_reg,
		load_enable => load_enable
	);
	Inst_EX_MEM: EX_MEM PORT MAP(
		ex_w_data_i => ex_w_data_i,
		ex_w_enable_i => ex_w_enable_i,
		ex_w_reg_i => ex_w_reg_i,
		ex_mem_op => ex_mem_op,
		ex_mem_addr => ex_mem_addr,
		RST => RST,
		CLK => CLK,
		pause => pause_manager,
		mem_w_data_o => mem_w_data_o,
		mem_w_enable_o => mem_w_enable_o,
		mem_w_reg_o => mem_w_reg_o,
		mem_op_o => mem_op_o,
		mem_addr_o => mem_addr_o
	);
	Inst_MEM: MEM PORT MAP(
		w_data_i => mem_w_data_o,
		w_enble_i => mem_w_enable_o,
		w_reg_i => mem_w_reg_o,
		mem_op_i => mem_op_o,
		mem_addr_i => mem_addr_o,
		RST => RST,
		CLK => CLK,
		w_data_o => mem_w_data_i,
		w_enble_o => mem_w_enable_i,
		w_reg_o => mem_reg_i,
		oe => ram2_oe,
		we => ram2_we,
		en => ram2_en,
		rdn => RDN,
		MEM_addr => ram2_data_addr,
		MEM_inst =>ram2_data_inst 
	);
	Inst_MEM_WB: MEM_WB PORT MAP(
		mem_w_data => mem_w_data_i,
		mem_w_enable => mem_w_enable_i,
		mem_reg => mem_reg_i,
		RST => RST,
		CLK => CLK,
		pause => pause_manager,
		wb_w_data => wb_w_data_o,
		wb_w_enable => wb_w_enable_o,
		wb_reg => wb_reg_o
	);
	Inst_RegisterManager: RegisterManager PORT MAP(
		reg1_addr => reg1_a,
		reg2_addr => reg2_a,
		w_enable => wb_w_enable_o,
		w_addr => wb_reg_o,
		w_data => wb_w_data_o,
		RST => RST,
		r_data1 => rdata1,
		r_data2 => rdata2
	);
	Inst_PauseManager: PauseManager PORT MAP(
		pause_from_id => pause_from_id,
		pause_from_ex => pause_from_ex,
		RST => RST,
		pause_IF => pause_manager
		);
	Inst_SubClk: SubClk PORT MAP(
		clk_fast => CLK50,
		rst => RST,
		clk_slow => CLK
	);

--rom_ce_o<=CLK;



end Behavioral;

