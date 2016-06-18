library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package mem_pkg is
	constant dwidth : integer := 32;
	constant addrw  : integer := 5;
	
	type rom_t is array(0 to 2**addrw-1) of std_logic_vector(dwidth-1 downto 0);
	constant c_instr : rom_t := (others => (others => '0'));
end package;
