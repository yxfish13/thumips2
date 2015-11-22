
-- VHDL Instantiation Created from source file SubClk.vhd -- 21:23:32 11/22/2015
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT SubClk
	PORT(
		clk_fast : IN std_logic;
		rst : IN std_logic;          
		clk_slow : OUT std_logic
		);
	END COMPONENT;

	Inst_SubClk: SubClk PORT MAP(
		clk_fast => ,
		rst => ,
		clk_slow => 
	);


