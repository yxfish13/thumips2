----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:02:38 11/28/2015 
-- Design Name: 
-- Module Name:    textControler - Behavioral 
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
use		ieee.std_logic_1164.all;
use		ieee.std_logic_unsigned.all;
use		ieee.std_logic_arith.all;
use defines.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity textControler is
	 port(			
			reset       :         in  STD_LOGIC;
			clk         :         in  STD_LOGIC;
			x           :         in integer;
			y           :         in integer;
			keycode     : 			 in STD_LOGIC_VECTOR(7 downto 0);
			fok         :         in STD_LOGIC;
			nowpixel    :         out STD_LOGIC_VECTOR(8 downto 0)
	  );
end textControler;

architecture Behavioral of textControler is
	COMPONENT font_rom
	PORT(
		clk : IN std_logic;
		addr : IN std_logic_vector(10 downto 0);          
		data : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;	
	constant MaxLine:integer := 5;
	constant MaxCol:integer := 8;
	type textType is array (0 to MaxLine * MaxCol - 1)
        of std_logic_vector(6 downto 0);
	signal text:textType;
	signal position:integer:=MaxLine * MaxCol - 1;
	signal cursor_x,cursor_y:integer:=0;
	signal addr:std_logic_vector(10 downto 0);
	signal data:std_logic_vector(0 to 7);
	signal font_x,font_y:integer;
	type status_type is (ready , keyout) ;
   signal state : status_type := ready;
	signal cursorInc:std_logic;
	signal caps :std_logic:= '1';
begin
	process (x)
	begin		
		if (x > 39 and x < MaxCol * 8 + 40 and y > 47 and y < MaxLine * 16 + 48 and data(x mod 8) = '1') then
			nowPixel<="111111111";
		else
			nowPixel<="000000000";
		end if;
	end process;
	
	 
	process (clk,reset)
	begin
		if reset='0' or (x = 0 and y = 0) then
				position <= MaxLine * MaxCol - 1;
		elsif clk'event and clk='1' and x mod 8 = 7 and x > 36 and x < MaxCol * 8 + 36 and y > 47 and y < MaxLine*16+48 then	
			if (x = 39 and y mod 16 /= 0) then
				position <= position - (MaxCol - 1);			
			else
				if (position = MaxLine * MaxCol - 1) then
					position <= 0;
				else
					position <= position + 1;
				end if;
			end if;
		end if;	 
	end process;
	addr <= text(position) & conv_std_logic_vector(y mod 16,4);
	--addr <= conv_std_logic_vector(position mod 128,7)& conv_std_logic_vector(y mod 16,4);
	Inst_font_rom: font_rom PORT MAP(
		clk => not clk,
		addr => addr,
		data => data
	);
	process (cursorInc)
	begin
		if (rising_edge(cursorInc)) then
			if (keycode = CODE_ENTER) then
				if (cursor_y = MaxLine - 1) then
					cursor_y <= 0;
				else
					cursor_y <= cursor_y + 1;
				end if;
				cursor_x <= 0;
				
			elsif (keycode = CODE_BKSP) then
				if (cursor_x > 0) then
					cursor_x <= cursor_x - 1;
				end if;
			else
				if (cursor_x = MaxCol - 1) then
					cursor_x <= 0;
					if (cursor_y = MaxLine - 1) then
						cursor_y <= 0;
					else
						cursor_y <= cursor_y + 1;
					end if;
				else
					cursor_x <= cursor_x + 1;
				end if;
			end if;
		end if;
	
	end process;
	process(fok , clk)
	begin 
		if fok = '1' and rising_edge(clk) then
			if (fok = '1') then
				if (state = ready) then
						case keycode is
							when "11110000" =>
								state <= keyout;
								cursorInc <= '0';								
							when CODE_A =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0000000";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0000000";
								end if;
								cursorInc <= '1';
							when CODE_B =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0000001";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0000001";
								end if;
								cursorInc <= '1';
							when CODE_C =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0000010";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0000010";
								end if;
								cursorInc <= '1';
							when CODE_D =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0000011";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0000011";
								end if;
								cursorInc <= '1';
							when CODE_E =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0000100";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0000100";
								end if;
								cursorInc <= '1';
							when CODE_F =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0000101";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0000101";
								end if;
								cursorInc <= '1';
							when CODE_G =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0000110";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0000110";
								end if;
								cursorInc <= '1';
							when CODE_H =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0000111";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0000111";
								end if;
								cursorInc <= '1';
							when CODE_I =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0001000";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0001000";
								end if;
								cursorInc <= '1';
							when CODE_J =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0001001";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0001001";
								end if;
								cursorInc <= '1';
							when CODE_K =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0001010";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0001010";
								end if;
								cursorInc <= '1';
							when CODE_L =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0001011";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0001011";
								end if;
								cursorInc <= '1';
							when CODE_M =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0001100";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0001100";
								end if;
								cursorInc <= '1';
							when CODE_N =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0001101";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0001101";
								end if;
								cursorInc <= '1';
							when CODE_O =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0001110";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0001110";
								end if;
								cursorInc <= '1';
							when CODE_P =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0001111";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0001111";
								end if;
								cursorInc <= '1';
							when CODE_Q =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0010000";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0010000";
								end if;
								cursorInc <= '1';
							when CODE_R =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0010001";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0010001";
								end if;
								cursorInc <= '1';
							when CODE_S =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0010010";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0010010";
								end if;
								cursorInc <= '1';
							when CODE_T =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0010011";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0010011";
								end if;
								cursorInc <= '1';
							when CODE_U =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0010100";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0010100";
								end if;
								cursorInc <= '1';
							when CODE_V =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0010101";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0010101";
								end if;
								cursorInc <= '1';
							when CODE_W =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0010110";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0010110";
								end if;
								cursorInc <= '1';
							when CODE_X =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0010111";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0010111";
								end if;
								cursorInc <= '1';
							when CODE_Y =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0011000";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0011000";
								end if;
								cursorInc <= '1';
							when CODE_Z =>
								if (caps = '1') then
									text(cursor_y * MaxCol + cursor_x) <=  "1000001" + "0011001";
								else
									text(cursor_y * MaxCol + cursor_x) <=  "1100001" + "0011001";
								end if;
								cursorInc <= '1';
							when CODE_ENTER =>
								cursorInc <= '1';
							when CODE_BKSP =>								
								text(cursor_y * MaxCol + cursor_x - 1) <= "0000000";
								cursorInc <= '1';
							when others =>
								cursorInc <= '0';
						end case;
				else
						cursorInc <= '0';
						state <= ready;
				end if;	
			else
				cursorInc <= '0';
			end if;
		end if;
	end process; 

end Behavioral;

