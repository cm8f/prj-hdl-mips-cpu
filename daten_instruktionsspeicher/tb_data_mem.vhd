library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.mem_pkg.all;

entity tb_data_mem is
end entity;

architecture testbench of tb_data_mem is
	signal clk : std_logic := '0';
	signal idata : std_logic_vector(dwidth-1 downto 0);
	signal odata : std_logic_vector(dwidth-1 downto 0);
	signal addr  : std_logic_vector(addrw-1 downto 0);
	--signal rden  : std_logic;
	signal wren  : std_logic;
	constant period : time := 10 ns;
begin

clk <= not clk after period/2;

dut: entity work.data_mem
port map(
	clk => clk,
	idata => idata,
	odata => odata,
	addr => addr,
	--rden => rden,
	wren => wren
);

stimuli: process
begin
	wren <= '1';
	addr <= x"00";
	idata <= x"deadbeef";
	wait for period;
	addr <= x"01";
	idata <= x"cafeaffe";
	wait for period;
	wren<= '0';
	addr <= x"00";
	wait for period;
	addr <= x"01";
	wait;
end process;



end architecture testbench;
