library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.mem_pkg.all;

entity instr_mem is
port(
	clk  : in  std_logic;
	data : out std_logic_vector(dwidth-1 downto 0);
	addr : in  std_logic_vector(addrw-1 downto 0)
);
end entity;

architecture behavioral of instr_mem is

signal rom : rom_t := c_instr;

begin

process(clk)
begin
	if rising_edge(clk) then
		data <= rom(to_integer(unsigned(addr)));
	end if;
end process;

end architecture behavioral;
