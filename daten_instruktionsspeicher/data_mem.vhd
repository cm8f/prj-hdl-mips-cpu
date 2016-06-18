library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.mem_pkg.all;

entity data_mem is
port(
	clk  : in  std_logic;
	idata : in std_logic_vector(dwidth-1 downto 0);
	odata : out std_logic_vector(dwidth-1 downto 0);
	addr : in  std_logic_vector(addrw-1 downto 0);
	--rden	: in stD_logic;
	wren	: in stD_logic
);
end entity;

architecture behavioral of data_mem is

signal ram : rom_t := (others => (others => '0'));

begin

process(clk)
begin
	if rising_edge(clk) then
		if wren = '1' then
			ram(to_integer(unsigned(addr))) <= idata; 
		--end if;
		--if rden = '1' then
		else
			odata <= ram(to_integer(unsigned(addr)));
		end if;
	end if;
end process;

end architecture behavioral;
