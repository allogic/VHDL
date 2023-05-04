library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is

	port (
		mrst  : in  std_logic;
		leds : out std_logic_vector(7 downto 0)
	);

end entity;

architecture counter_arch of counter is

	component osch is

		generic (
			nom_freq : string
		);
		port (
			stdby : in  std_logic;
			osc   : out std_logic
		);

	end component;

	component clock_div_int is
	
		generic (
			divider : integer
		);
	
		port (
			rst : in  std_logic;
			osc : in  std_logic;
			clk : out std_logic
		);
	
	end component;

	signal osc : std_logic;
	signal clk : std_logic;
	signal acc : std_logic_vector(7 downto 0);

begin

	osch_inst : osch
		generic map (
			nom_freq => "2.08"
		)
		port map (
			stdby => '0',
			osc => osc
		);

	clock_div_int_inst : clock_div_int
		generic map (
			divider => 208000
		)
		port map (
			rst => mrst,
			osc => osc,
			clk => clk
		);

	process (rst, clk)
	begin
		
		if (rising_edge(clk)) then
			acc <= std_logic_vector(unsigned(acc) + 1);
		end if;

		if (mrst = '1') then
			acc <= (others => '0');
		end if;

	end process;

	leds <= not acc;

end architecture;