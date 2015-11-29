----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:56:06 11/27/2015 
-- Design Name: 
-- Module Name:    vga640480 - Behavioral 
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
library	ieee;
use		ieee.std_logic_1164.all;
use		ieee.std_logic_unsigned.all;
use		ieee.std_logic_arith.all;

entity vga640480 is
	 port(			
			reset       :         in  STD_LOGIC;
			clk         :         in  STD_LOGIC; --25M时钟输入
			nowpixel    :         in STD_LOGIC_VECTOR(8 downto 0);
			hs,vs       :         out STD_LOGIC; --行同步、场同步信号
			x_out       :         out integer;
			y_out       :         out integer;
			r,g,b       :         out STD_LOGIC_vector(2 downto 0)
	  );
end vga640480;

architecture behavior of vga640480 is	
	signal r1,g1,b1   : std_logic_vector(2 downto 0);					
	signal hs1,vs1    : std_logic;
	signal qq : std_logic_vector(7 DOWNTO 0);
	signal x:integer:=0;
	signal y:integer:=0;	
begin
	 x_out<=x;
	 y_out<=y;
	 process(clk,reset)	--行区间像素数（含消隐区）
	 begin
	  	if reset='0' then
	   		x <= 0;
	  	elsif clk'event and clk='1' then					
	   		if x=799 then
	    		x <= 0;
	   		else
	    		x <= x + 1;
	   		end if;
	  	end if;
	 end process;

  -----------------------------------------------------------------------
	 process(clk,reset)	--场区间行数（含消隐区）
	 begin
	  	if reset='0' then
	   		y <= 0;
	  	elsif clk'event and clk='1' then
	   		if x=799 then
	    		if y=524 then
	     			y <= 0;	     			
	    		else	
	     			y <= y + 1;
	    		end if;
	   		end if;
	  	end if;
	 end process;
 
  -----------------------------------------------------------------------
	 process(clk,reset) --行同步信号产生（同步宽度96，前沿16）
	 begin
		  if reset='0' then
		   hs1 <= '1';
		  elsif clk'event and clk='1' then
		   	if x>=656 and x<752 then
		    	hs1 <= '0';
		   	else
		    	hs1 <= '1';
		   	end if;
		  end if;
	 end process;
 
 -----------------------------------------------------------------------
	 process(clk,reset) --场同步信号产生（同步宽度2，前沿10）
	 begin
	  	if reset='0' then
	   		vs1 <= '1';
	  	elsif clk'event and clk='1' then
	   		if y>=490 and y<492 then
	    		vs1 <= '0';
	   		else
	    		vs1 <= '1';
	   		end if;
	  	end if;
	 end process;
 -----------------------------------------------------------------------
	 process(clk,reset) --行同步信号输出
	 begin
	  	if reset='0' then
	   		hs <= '0';
	  	elsif clk'event and clk='1' then
	   		hs <=  hs1;
	  	end if;
	 end process;

 -----------------------------------------------------------------------
	 process(clk,reset) --场同步信号输出
	 begin
	  	if reset='0' then
	   		vs <= '0';
	  	elsif clk'event and clk='1' then
	   		vs <=  vs1;
	  	end if;
	 end process;
	
 -----------------------------------------------------------------------	
	process(reset,clk,x,y) -- XY坐标定位控制
	begin
		if reset='0' then
			      r1  <= "000";
					g1	<= "000";
					b1	<= "000";	
		elsif(clk'event and clk='1')then		
			if x < 640 and y < 480 then				
				b1 <= nowPixel(8 DOWNTO 6);
				g1 <= nowPixel(5 DOWNTO 3);
				r1 <= nowPixel(2 DOWNTO 0);
			else 
					r1  <= "000";
					g1	<= "000";
					b1	<= "000";
			end if;
		end if;		 
	end process;	
	
	-----------------------------------------------------------------------
	process (hs1, vs1, r1, g1, b1)	--色彩输出
	begin
		if hs1 = '1' and vs1 = '1' then
		
			r	<= r1;
			g	<= g1;
			b	<= b1;
		else
			r	<= (others => '0');
			g	<= (others => '0');
			b	<= (others => '0');
		end if;
	end process;
end behavior;
