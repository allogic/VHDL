library machxo2;
library ieee;

use machxo2.all;

use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity counter is

	port (
		rst : in  std_logic;
		cnt : out std_logic_vector(7 downto 0)
	);

end entity;

architecture rtl of counter is

	component osch

		generic (nom_freq : string);
		port (stdby : in std_logic; osc : out std_logic);

	end component;

	signal clk   : std_logic := '0';
	signal clk2  : std_logic := '0';
	signal clk4  : std_logic := '0';
	signal clk8  : std_logic := '0';
	signal clk16 : std_logic := '0';
	signal acc   : std_logic_vector(7 downto 0) := (others => '0');

begin

	osch_inst : osch
		generic map (nom_freq => "2.08")
		port map (stdby => '0', osc => clk);

	clk_div_pow2_inst : entity work.clock_div_pow2(rtl)
		port map (clk => clk, rst => rst, clk2 => clk2, clk4 => clk4, clk8 => clk8, clk16 => clk16);

	accumulator : process (rst, clk16)
	begin
		
		if (rising_edge(clk16)) then
			acc <= std_logic_vector(unsigned(acc) + 1);
		end if;

		if (rst = '1') then
			acc <= (others => '0');
		end if;

	end process;

	cnt <= not acc;

end architecture;