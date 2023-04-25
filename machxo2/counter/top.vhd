library machxo2;
library ieee;

use machxo2.all;

use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity top is

	port (
		leds : out std_logic_vector(7 downto 0)
	);

end entity;

architecture rtl of top is

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
			clkop : out std_logic;
			lock  : out std_logic
		);
	
	end component;

	component counter is
	
		generic (
			max : integer
		);
	
		port (
			rst : in  std_logic;
			clk : in  std_logic;
			cnt : out std_logic_vector(7 downto 0)
		);
	
	end component;

	signal rst  : std_logic := '1';
	signal osc  : std_logic := '0';
	signal clk  : std_logic := '0';
	signal lock : std_logic := '1';

begin

	osch_inst : osch
		generic map (
			nom_freq => "2.08"
		)
		port map (
			stdby => '0',
			osc => osc
		);

	--pll_inst : pll
	--	port map (
	--		clki => osc,
	--		clkop => clk,
	--		lock => lock
	--	);

	counter_inst : counter
		generic map (
			max => 200000
		)
		port map (
			rst => rst,
			clk => osc,
			cnt => leds
		);

	rst <= not lock;

end architecture;