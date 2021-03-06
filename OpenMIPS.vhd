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
			  CLK_HAND: in std_logic;
			  digit1 : out  STD_LOGIC_VECTOR (6 downto 0);
			  digit2 : out  STD_LOGIC_VECTOR (6 downto 0);
			  led	: out  STD_LOGIC_VECTOR (15 downto 0);
           RST : in  STD_LOGIC;
			  RDN :out std_logic;
			  WRN : out std_logic;
			  TSRE : in std_logic;
			  TBRE : in std_logic;			  
			  DATA_READY : in std_logic;
			  keyboardData,keyboardclk: in std_logic;
			  r,g,b : out STD_LOGIC_vector(2 downto 0);
			  hs,vs : out STD_LOGIC; --行同步、场同步信号
			  --	flash			  
           FlashByte : out  STD_LOGIC;
           FlashVpen : out  STD_LOGIC;
           FlashCE : out  STD_LOGIC;
           FlashOE : out  STD_LOGIC;
           FlashWE : out  STD_LOGIC;
           FlashRP : out  STD_LOGIC;
           FlashAddr : out  STD_LOGIC_VECTOR (22 downto 0);
           FlashData : inout  STD_LOGIC_VECTOR (15 downto 0);
--			  
           ram1_data_inst : inout  STD_LOGIC_VECTOR (15 downto 0);
           Ram1_data_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           Ram1_OE,Ram1_WE,Ram1_EN : out  STD_LOGIC;
           ram2_data_inst : inout  STD_LOGIC_VECTOR (15 downto 0);
           Ram2_data_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           Ram2_OE,Ram2_WE,Ram2_EN : out  STD_LOGIC);
end OpenMIPS;

architecture Behavioral of OpenMIPS is
	COMPONENT MemControler
	PORT(
		data_ready : IN std_logic;
		tsre : IN std_logic;
		tbre: in std_logic;
		Mem_addr : IN std_logic_vector(15 downto 0);
		Mem_data_in : IN std_logic_vector(15 downto 0);
		Mem_op : IN std_logic_vector(1 downto 0);
		IF_addr : IN std_logic_vector(15 downto 0);
		IF_data_out : out std_logic_vector(15 downto 0);
		CLK : IN std_logic;    
		ram1_data : INOUT std_logic_vector(15 downto 0);
		ram2_data : INOUT std_logic_vector(15 downto 0);      
		ram1_oe : OUT std_logic;
		ram1_we : OUT std_logic;
		ram1_en : OUT std_logic;
		ram1_addr : OUT std_logic_vector(17 downto 0);
		ram2_oe : OUT std_logic;
		ram2_we : OUT std_logic;
		ram2_en : OUT std_logic;
		ram2_addr : OUT std_logic_vector(17 downto 0);
		rdn : OUT std_logic;
		wrn : OUT std_logic;
		Memc_pause : OUT std_logic;
		--	flash			  
           FlashByte : out  STD_LOGIC;
           FlashVpen : out  STD_LOGIC;
           FlashCE : out  STD_LOGIC;
           FlashOE : out  STD_LOGIC;
           FlashWE : out  STD_LOGIC;
           FlashRP : out  STD_LOGIC;
           FlashAddr : out  STD_LOGIC_VECTOR (22 downto 0);
           FlashData : inout  STD_LOGIC_VECTOR (15 downto 0);
--			  
			  RST_in : in std_logic;
			  RST_out : out std_logic;
		Mem_data_out : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
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
		IF_ram2_data : IN std_logic_vector(15 downto 0);          
		pc_out1 : OUT std_logic_vector(15 downto 0);
		IF_ram2_addr : OUT std_logic_vector(15 downto 0);
		IF_inst : OUT std_logic_vector(15 downto 0)
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
		id_immediate : out  STD_LOGIC_VECTOR (15 downto 0);
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
		id_immediate : IN std_logic_vector(15 downto 0);
		id_w_enable : IN std_logic;
		id_w_reg : IN std_logic_vector(3 downto 0);
		RST : IN std_logic;
		CLK : IN std_logic;
		pause : IN std_logic_vector(4 downto 0);          
		ex_op : OUT std_logic_vector(5 downto 0);
		ex_reg1 : OUT std_logic_vector(15 downto 0);
		ex_reg2 : OUT std_logic_vector(15 downto 0);
		ex_immediate : OUT std_logic_vector(15 downto 0);
		ex_w_enable : OUT std_logic;
		ex_w_reg : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	COMPONENT EX
	PORT(
		op : IN std_logic_vector(5 downto 0);
		reg1 : IN std_logic_vector(15 downto 0);
		reg2 : IN std_logic_vector(15 downto 0);
		ex_immediate : in  STD_LOGIC_VECTOR (15 downto 0);
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
		MEM_dataget_mc : IN std_logic_vector(15 downto 0);          
		w_data_o : OUT std_logic_vector(15 downto 0);
		w_enble_o : OUT std_logic;
		w_reg_o : OUT std_logic_vector(3 downto 0);
		MEM_addr_mc : OUT std_logic_vector(15 downto 0);
		MEM_data_mc : OUT std_logic_vector(15 downto 0);
		MEM_data_op : OUT std_logic_vector(1 downto 0)
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
		CLK : IN std_logic;
		r_data1 : OUT std_logic_vector(15 downto 0);
		r_data2 : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT PauseManager
	PORT(
		pause_from_id : IN std_logic;
		pause_from_ex : IN std_logic;
		pause_from_mc : in  STD_LOGIC;
		RST : IN std_logic;          
		pause_IF : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;
	COMPONENT vga640480
	PORT(
		reset : IN std_logic;
		clk : IN std_logic;
		nowpixel : IN std_logic_vector(8 downto 0);          
		hs : OUT std_logic;
		vs : OUT std_logic;
		x_out : OUT integer;
		y_out : OUT integer;
		r : OUT std_logic_vector(2 downto 0);
		g : OUT std_logic_vector(2 downto 0);
		b : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;
	COMPONENT Keyboard
	PORT(
		datain : IN std_logic;
		clkin : IN std_logic;
		fclk : IN std_logic;
		rst : IN std_logic;          
		fok1 : OUT std_logic;
		scancode : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	COMPONENT textControler
	PORT(
		reset : IN std_logic;
		clk : IN std_logic;
		x : IN integer;
		y : IN integer;
		keycode : IN std_logic_vector(7 downto 0);
		fok : IN std_logic;          
		nowpixel : OUT std_logic_vector(8 downto 0)
		);
	END COMPONENT;

signal CLK: STD_LOGIC;

signal pause_manager: std_logic_vector(4 downto 0);
signal pc_next : std_logic_vector(15 downto 0);
signal PC_IF_in :std_logic_vector(15 downto 0);
signal pc_in: std_logic_vector(15 downto 0);
signal pc_enable: STD_LOGIC;
signal if_pc: std_logic_vector(15 downto 0);
signal if_inst_out : std_logic_vector(15 downto 0);
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


signal memc_pause:std_logic;
signal mc_mem_addr,id_immediate,ex_immediate:std_logic_vector(15 downto 0);
signal mc_mem_data_in:std_logic_vector(15 downto 0);
signal mc_mem_data_out:std_logic_vector(15 downto 0);
signal mc_mem_op:std_logic_vector(1 downto 0);
signal mc_if_addr:std_logic_vector(15 downto 0);
signal mc_if_data_out:std_logic_vector(15 downto 0);
signal digitnum1,digitnum2:std_logic_vector(2 downto 0);
signal rrdn,wwrn,ddata_ready,ttsre:std_logic;
signal yx_1:std_logic;
signal yx_2:std_logic_vector(17 downto 0);
signal vga_x,vga_y:integer;
signal CLK5,CLK25,CLK2,CLK_D:std_logic;
signal scanCode:std_logic_vector(7 downto 0);
signal fok,RST1:std_logic;
signal nowPixel:std_logic_vector(8 downto 0);
--signal a,b,c:std_logic;
--signal d,e,f,g:std_logic_vector(15 downto 0);
--attribute box_type : string;
--attribute box_type of system : component is "user_black_box";
begin	
   --CLK <= CLK50;
   mem_w_data_id <= mem_w_data_i;
   mem_w_enable_id <= mem_w_enable_i;
   mem_w_reg_id <= mem_reg_i;
   ex_w_data_id <= ex_w_data_i;
   ex_w_enable_id <= ex_w_enable_i;
   ex_w_reg_id <= ex_w_reg_i;
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
		rst => RST1,
		clk => CLK,
		pause => pause_manager,
		pc => PC_IF_in
	);
	--Inst_IF_inst_t: IF_inst_t PORT MAP(
	--	pc_in => PC_IF_in,
	--	pc_out1 => if_pc,
	--	IF_ram2_addr =>,
	--	IF_ram2_data =>,
	--	IF_inst => ram1_data_inst
	--);
	Inst_IF_inst_t: IF_inst_t PORT MAP(
		pc_in => PC_IF_in,
		pc_out1 => if_pc,
		IF_ram2_addr => mc_if_addr,
		IF_ram2_data => mc_if_data_out,
		IF_inst => if_inst_out
	);
	Inst_PC_MUX: PC_MUX PORT MAP(
		PC_inF => if_pc,
		PC_enable => pc_enable,
		PC_ID => pc_in,
		next_PC => pc_next
	);
	
	Inst_IF_ID: IF_ID PORT MAP(
		CLK => CLK,
		RST => RST1,
		pause => pause_manager,
		if_pc => if_pc,
		if_inst => if_inst_out,
		id_pc => id_pc,
		id_inst => id_inst
	);
	Inst_ID: ID PORT MAP(
		RST => RST1,
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
		id_immediate => id_immediate,
		reg1_a => reg1_a,
		reg2_a => reg2_a,
		w_enbale => id_w_enable,
		w_reg => id_w_reg
	);	
	Inst_ID_EX: ID_EX PORT MAP(
		id_op => id_op,
		id_reg1 => id_reg1,
		id_reg2 => id_reg2,
		id_immediate => id_immediate,
		id_w_enable => id_w_enable,
		id_w_reg => id_w_reg,
		RST => RST1,
		CLK => CLK,
		pause => pause_manager,
		ex_op => ex_op,
		ex_reg1 => ex_reg1,
		ex_reg2 => ex_reg2,
		ex_immediate => ex_immediate,
		ex_w_enable => ex_w_enable,
		ex_w_reg => ex_w_reg
	);
	Inst_EX: EX PORT MAP(
		op => ex_op,
		reg1 => ex_reg1,
		reg2 => ex_reg2,
		ex_immediate => ex_immediate,
		w_enbale_i => ex_w_enable,
		w_reg_i => ex_w_reg,
		RST => RST1,
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
		RST => RST1,
		CLK => CLK,
		pause => pause_manager,
		mem_w_data_o => mem_w_data_o,
		mem_w_enable_o => mem_w_enable_o,
		mem_w_reg_o => mem_w_reg_o,
		mem_op_o => mem_op_o,
		mem_addr_o => mem_addr_o
	);
--	Inst_MEM: MEM PORT MAP(
--		w_data_i => mem_w_data_o,
--		w_enble_i => mem_w_enable_o,
--		w_reg_i => mem_w_reg_o,
--		mem_op_i => mem_op_o,
--		mem_addr_i => mem_addr_o,
--		RST => RST,
--		CLK => CLK,
--		w_data_o => mem_w_data_i,
--		w_enble_o => mem_w_enable_i,
--		w_reg_o => mem_reg_i,
--		oe => ram2_oe,
--		we => ram2_we,
--		en => ram2_en,
--		rdn => RDN,
--		MEM_addr => ram2_data_addr,
--		MEM_inst =>ram2_data_inst 
--	);
	Inst_MEM: MEM PORT MAP(
		w_data_i => mem_w_data_o,
		w_enble_i => mem_w_enable_o,
		w_reg_i => mem_w_reg_o,
		mem_op_i => mem_op_o,
		mem_addr_i => mem_addr_o,
		w_data_o => mem_w_data_i,
		w_enble_o => mem_w_enable_i,
		w_reg_o => mem_reg_i,
		MEM_addr_mc => mc_mem_addr,
		MEM_data_mc => mc_mem_data_in,
		MEM_data_op => mc_mem_op,
		MEM_dataget_mc => mc_mem_data_out
	);
	Inst_MEM_WB: MEM_WB PORT MAP(
		mem_w_data => mem_w_data_i,
		mem_w_enable => mem_w_enable_i,
		mem_reg => mem_reg_i,
		RST => RST1,
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
		RST => RST1,
		CLK => CLK,
		r_data1 => rdata1,
		r_data2 => rdata2
	);
	Inst_PauseManager: PauseManager PORT MAP(
		pause_from_id => pause_from_id,
		pause_from_ex => pause_from_ex,
		pause_from_mc => memc_pause,
		RST =>RST1,
		pause_IF => pause_manager
		);
	Inst_MemControler: MemControler PORT MAP(
		ram1_oe => Ram1_OE,
		ram1_we => Ram1_WE,
		ram1_en => Ram1_EN,
		ram1_data => ram1_data_inst,
		ram1_addr => Ram1_data_addr,
		ram2_oe => Ram2_OE,
		ram2_we => yx_1, 
		ram2_en => Ram2_EN,
		ram2_data => ram2_data_inst,
		ram2_addr => yx_2,
		rdn => rrdn,
		wrn => wwrn,
		data_ready => ddata_ready,
		tsre => ttsre,
		tbre => TBRE,
		Memc_pause => memc_pause,
		Mem_addr => mc_mem_addr,
		Mem_data_in => mc_mem_data_in,
		Mem_data_out => mc_mem_data_out,
		Mem_op => mc_mem_op,
		IF_addr => mc_if_addr,
		IF_data_out => mc_if_data_out,
		--	flash			  
           FlashByte=>FlashByte,
           FlashVpen =>FlashVpen,
           FlashCE =>FlashCE,
           FlashOE => FlashOE,
           FlashWE => FlashWE,
           FlashRP => FlashRP ,
           FlashAddr => FlashAddr,
           FlashData => FlashData,
--			  
			  RST_in => RST,
			  RST_out => RST1,
		CLK => CLK
	);
	Inst_SubClk: SubClk PORT MAP(
		clk_fast => CLK50,
		rst => RST,
		clk_slow => CLK25
	);
	Inst_SubClk1: SubClk PORT MAP(
		clk_fast => CLK25,
		rst => RST,
		clk_slow => CLK5
	);
	Inst_SubClk2: SubClk PORT MAP(
		clk_fast => CLK25,
		rst => RST,
		clk_slow => CLK2
	);
	Inst_vga640480: vga640480 PORT MAP(
		reset => RST,
		clk => CLK25,
		nowPixel => nowPixel,
		hs => hs,
		vs => vs,
		x_out => vga_x,
		y_out => vga_y,
		r => r,
		g => g,
		b => b
	);
	Inst_Keyboard: Keyboard PORT MAP(
		datain => keyboardData,
		clkin => keyboardclk,
		fclk => CLK25,
		rst => RST,
		fok1 => fok,
		scancode => scanCode
	);
	Inst_textControler: textControler PORT MAP(
		reset => RST,
		clk => CLK25,
		x => vga_x,
		y => vga_y,
		keycode => scanCode,
		fok => fok,
		nowpixel => nowPixel
	);
	CLK<=CLK25;
	--CLK_D<=CLK;
	RDN<=rrdn;WRN<=wwrn;ddata_ready<=DATA_READY;ttsre<=TSRE;
	--led<=PC_IF_in;
	Ram2_WE<=yx_1;Ram2_data_addr<=yx_2;
	led(15)<=yx_1;led(14)<=wwrn;led(13)<=ddata_ready;led(12)<=ttsre;
	led(11 downto 8)<=yx_2(3 downto 0);
	led(7 downto 0)<=scanCode;--mc_mem_data_out(7 downto 0);
	digitnum1 <= id_op(5 downto 3);
	digitnum2 <= id_op(2 downto 0);
	process (digitnum1,digitnum2)
	begin
		 case digitnum2 is
			when "000"=>digit1<="1111110";
			when "001"=>digit1<="0110000";
			when "010"=>digit1<="1101101";
			when "011"=>digit1<="1111001";
			when "100"=>digit1<="0110011";
			when "101"=>digit1<="1011011";
			when "110"=>digit1<="0011111";
			when "111"=>digit1<="1110000";
			when others =>digit1<="1111111";
			
		end case;
		case digitnum1 is
			when "000"=>digit2<="1111110";
			when "001"=>digit2<="0110000";
			when "010"=>digit2<="1101101";
			when "011"=>digit2<="1111001";
			when "100"=>digit2<="0110011";
			when "101"=>digit2<="1011011";
			when "110"=>digit2<="0011111";
			when "111"=>digit2<="1110000";
			when others =>digit1<="1111111";
		end case;
	end process;
end Behavioral;

