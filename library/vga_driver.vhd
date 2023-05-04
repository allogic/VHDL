-- SVGA 800 x 600 @ 60Hz
-- Vertical Refresh 37.9kHz
-- Pixel Frequency  40.0MHz

-- display_area =   0 -  800 = 20.000탎
--  front_porch = 800 -  840 =  1.000탎
--   sync_pulse = 840 -  968 =  3.200탎
--   back_porch = 968 - 1056 = 26.400탎

-- display_area =   0 -  600 = 15.840탎
--  front_porch = 600 -  601 =  0.026탎
--   sync_pulse = 601 -  605 =  0.105탎
--   back_porch = 605 -  628 = 16.579탎

--                0.7V = 3.3V * ( 75.0Z / ( R + 75.0Z ) )
-- ( 0.7V * R ) + 52.5 = 247.5
--        ( 0.7V * R ) = 195.0
--                   R = 278.6

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_driver is

	port (
		rst   : in  std_logic;
		clk   : in  std_logic;
		hsync : out std_logic;
		vsync : out std_logic
	);

end entity;

architecture vga_driver_arch of vga_driver is

	constant h_front_porch : integer := 800;
	constant h_sync_pulse  : integer := 840;
	constant h_back_porch  : integer := 968;
	constant h_end         : integer := 1056;

	constant v_front_porch : integer := 600;
	constant v_sync_pulse  : integer := 601;
	constant v_back_porch  : integer := 605;
	constant v_end         : integer := 628;

	signal hcnt : std_logic_vector(9 downto 0);
	signal vcnt : std_logic_vector(9 downto 0);

begin

	process (rst, clk)
	begin

	if (rising_edge(clk)) then
		if (unsigned(hcnt) < h_end) then
			hcnt <= std_logic_vector(unsigned(hcnt) + 1);
		else
			hcnt <= (others => '0');
			if (unsigned(vcnt) < v_end) then
				vcnt <= std_logic_vector(unsigned(vcnt) + 1);
			else
				vcnt <= (others => '0');
			end if;
		end if;
	end if;
	
	if (rst = '1') then
		hcnt <= (others => '0');
		vcnt <= (others => '0');
	end if;

	end process;

	hsync <= '1' when ((unsigned(hcnt) >= h_sync_pulse) and (unsigned(hcnt) < h_back_porch)) else '0';
	vsync <= '1' when ((unsigned(vcnt) >= v_sync_pulse) and (unsigned(vcnt) < v_back_porch)) else '0';

end architecture;