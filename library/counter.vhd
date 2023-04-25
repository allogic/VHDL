library ieee;

use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity counter is

	generic (
		max : integer
	);

	port (
		rst : in  std_logic;
		clk : in  std_logic;
		cnt : out std_logic_vector(7 downto 0)
	);

end entity;

architecture rtl of counter is

	signal div : integer range 0 to max;
	signal acc : std_logic_vector(7 downto 0) := (others => '0');

begin

	accumulator : process (rst, clk)
	begin
		
		if (rising_edge(clk)) then
			if (div = max) then
				div <= 0;
				acc <= std_logic_vector(unsigned(acc) + 1);
			else
				div <= div + 1;
			end if;
		end if;

		if (rst = '1') then
			div <= 0;
			acc <= (others => '0');
		end if;

	end process;

	cnt <= not acc;

end architecture;