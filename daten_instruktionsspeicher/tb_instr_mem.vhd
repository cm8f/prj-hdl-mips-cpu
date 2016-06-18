library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.mem_pkg.all;

entity tb_instr_mem is
end entity;

architecture testbench of tb_instr_mem is

signal clk  : std_logic := '0';
signal data : std_logic_vector(dwidth-1 downto 0);
signal addr : std_logic_vector(addrw-1 downto 0);

begin

clk <= not clk after 5 ns;

stimuli: process
begin
	addr <= x"00";
	wait for 10 ns;
	addr <= x"01";
	wait;
end process;

dut: entity work.instr_mem 
port map(
	clk  => clk,
	data => data,
	addr => addr
);

end architecture testbench;
