library ieee;

use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity clock_div_pow2 is

	port (
		clk   : in  std_logic;
		rst   : in  std_logic;
		clk2  : out std_logic;
		clk4  : out std_logic;
		clk8  : out std_logic;
		clk16 : out std_logic
	);

end entity;

architecture rtl of clock_div_pow2 is

	signal acc : std_logic_vector(3 downto 0) := (others => '0');

begin

	accumulator : process (clk, rst)
	begin
		
		if (rising_edge(clk)) then
			acc <= std_logic_vector(unsigned(acc) + 1);
		end if;

		if (rst = '1') then
			acc <= (others => '0');
		end if;

	end process;

	clk2  <= acc(0);
	clk4  <= acc(1);
	clk8  <= acc(2);
	clk16 <= acc(3);

end architecture;