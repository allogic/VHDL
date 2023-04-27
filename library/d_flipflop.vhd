library ieee;

use ieee.std_logic_1164.all;

entity d_flipflop is

	port (
		rst : in  std_logic;
		osc : in  std_logic;
		d   : in  std_logic;
		q   : out std_logic
	);

end entity;

architecture rtl of d_flipflop is
begin

	process (rst, osc)
	begin
	
		if (rising_edge(osc)) then
			q <= d;
		end if;
	
		if (rst = '1') then
			q <= '0';
		end if;
	
	end process;

end architecture;