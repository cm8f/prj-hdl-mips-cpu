library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.mem_pkg.all;

entity fetch is
    port(
        clk         : in  std_logic;
        en          : in  std_logic;
        reset       : in  std_logic;
        jump        : in  std_logic;
        pc_next     : in  std_logic_vector(31 downto 0);
        pc          : out std_logic_vector(31 downto 0);
        instruction : out std_logic_vector(31 downto 0)
    );
end entity fetch;

architecture structural of fetch is

    signal slv_pc : std_logic_vector(31 downto 0); 

    constant c_en : std_logic := '1';

begin

pc <= slv_pc;

pc_0 : entity work.pc
	port map (
		clk 	  => clk,
		reset 	  => reset,
		en	      => en,
		pc_out	  => slv_pc,
		ld        => jump,
		pc_in     => pc_next
	);

instr_mem_0 : entity work.instr_mem
port map (
	clk   => clk,
	data  => instruction,
	addr  => slv_pc(addrw-1+2 downto 2)
);

end architecture structural;
