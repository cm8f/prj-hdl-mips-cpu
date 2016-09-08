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
    
    constant reg_incr4: rom_t := ( 
        x"20080000",    -- addi $8,  $0,  0x00000000
        x"20090001",    -- addi $9,  $0,  0x00000001
        x"200a000a",    -- addi $10, $0,  0x0000000a
        x"200b0000",    -- addi $11, $0,  0x00000000
        x"08000007",    -- j 0x0000001c
        x"01094020",    -- add  $8,  $8,  $9
        x"216b0001",    -- addi $11, $11, 0x00000001
        x"014bc82a",    -- slt  $25, $10, $11
        x"20010001",    -- addi $1,  $0,  0x00000001
        x"1039fffb",    -- beq  $1,  $25, 0xfffffffb
        others => (others => '0')
    );

    constant c_instr : rom_t := reg_incr4;
end package;
