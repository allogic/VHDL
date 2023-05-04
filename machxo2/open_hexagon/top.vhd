library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity open_hexagon is

	port (
		mrst  : in  std_logic;
		hsync : out std_logic;
		vsync : out std_logic
	);

end entity;

architecture open_hexagon_arch of open_hexagon is

	component osch is
	
		generic (
			nom_freq : string
		);
		port (
			stdby : in  std_logic;
			osc   : out std_logic
		);
	
	end component;

	component pll is
    
		port (
			clki  : in  std_logic; 
			rst   : in  std_logic; 
			clkop : out std_logic; 
			lock  : out std_logic
		);
		
	end component;

	component vga_driver is

		port (
			rst   : in  std_logic;
			clk   : in  std_logic;
			hsync : out std_logic;
			vsync : out std_logic
		);

	end component;

	signal rst  : std_logic;
	signal osc  : std_logic;
	signal clk  : std_logic;
	signal lock : std_logic;

begin

	osch_inst : osch
		generic map (
			nom_freq => "38.00"
		)
		port map (
			stdby => '0',
			osc => osc
		);

	pll_inst : pll
		port map (
			clki => osc,
			rst => mrst,
			clkop => clk,
			lock => lock
		);

	vga_driver_inst : vga_driver
		port map (
			rst => rst,
			clk => clk,
			hsync => hsync,
			vsync => vsync
		);

	rst <= not lock;

end architecture;