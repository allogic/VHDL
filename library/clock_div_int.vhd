library ieee;

use ieee.std_logic_1164.all;

entity clock_div_int is

	generic (
		divider : integer
	);

	port (
		rst : in  std_logic;
		osc : in  std_logic;
		clk : out std_logic
	);

end entity;

architecture clock_div_int_arch of clock_div_int is

	signal acc   : integer range 0 to divider;
	signal state : std_logic;

begin

	process (rst, osc)
	begin
		
		if (rising_edge(osc)) then
			if (acc = divider) then
				acc <= 0;
				state <= not state;
			else
				acc <= acc + 1;
			end if;
		end if;

		if (rst = '1') then
			acc <= 0;
			state <= '0';
		end if;

	end process;

	clk <= state;

end architecture;