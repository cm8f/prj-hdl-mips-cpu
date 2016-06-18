library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package mem_pkg is
	constant dwidth : integer := 32;
	constant addrw  : integer := 5;
	
	type rom_t is array(0 to 2**addrw-1) of std_logic_vector(dwidth-1 downto 0);
	--constant c_instr : rom_t := (others => (others => '0'));

    constant reg_incr : rom_t := ( 
        x"20080024",
        x"200903e8",
        x"20190001",
        x"08100005",
        x"21080001",
        x"0109502a",
        x"1159fffd",
        others => (others => '0')
    );

    constant c_instr : rom_t := reg_incr;
end package;
