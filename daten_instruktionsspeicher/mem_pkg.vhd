library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package mem_pkg is
	constant dwidth : integer := 32;
	constant addrw  : integer := 8;
	
	type rom_t is array(0 to 2**addrw-1) of std_logic_vector(dwidth-1 downto 0);
	--constant c_instr : rom_t := (others => (others => '0'));

    constant reg_incr : rom_t := ( 
        x"20080018",
        x"200903e8",
        x"20190001",
        x"08000008",
        x"00000000",
        x"21280001",
        x"00000000",
        x"00000000",
        x"00000000",
        x"0109502a",
        x"1159fffa",
        others => (others => '0')
    );

    constant reg_incr2 : rom_t := (
        x"20080018",
        x"00000000",
        x"200903e8",
        x"00000000",
        x"20190001",
        x"00000000",
        x"0800000b",
        x"21080001",
        x"00000000",
        x"00000000",
        x"00000000",
        x"0109502a",
        x"00000000",
        x"1159fff9",
        x"00000000",
        others => (others => '0')
    );

    constant reg_incr3 : rom_t := (
        x"20080000",
        x"00000000",
        x"2009001c",
        x"00000000",
        x"20190001",
        x"00000000",
        x"0810000b",
        x"21080004",
        x"00000000",
        x"ad080000",
        x"00000000",
        x"0109502a",
        x"00000000",
        x"1159fff9",
        x"00000000",
        x"20080000",
        x"00000000",
        x"2009001e",
        x"00000000",
        x"08100018",
        x"8d0b0000",
        x"00000000",
        x"21080004",
        x"00000000",
        x"0109502a",
        x"00000000",
        x"1159fff9",
        x"00000000",
        others => (others => '0')
    );

    constant c_instr : rom_t := reg_incr3;
end package;
