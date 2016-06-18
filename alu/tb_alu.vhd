library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu is
end entity tb_alu;


architecture testbench of tb_alu is

signal a : std_logic_vector(31 downto 0);
signal b : std_logic_vector(31 downto 0);
signal o : std_logic_vector(31 downto 0);
signal opcode: std_logic_vector(3 downto 0);
signal lt: std_logic;

constant period : time := 10 ns;

begin

dut : entity work.alu
	port map(
		a => a,
		b => b,
		o => o,
		opcode => opcode,
		lessthan => lt	
	);

stimuli : process
begin
	a <= x"0000beef";
	b <= x"deadbeef";

	opcode <= "0000";
	wait for period;
	assert (o = x"0000beef") report "opcode 0000 (and) failded" severity error;
	wait for period;

	opcode <= "0001";
	wait for period;
	assert (o = x"deadbeef") report "opcode 0001 (or) failed" severity error;
	wait for period;

	opcode <= "0010";
	wait for period;
	assert (o = x"DEAE7DDE") report "opcode 0010 (add) failed" severity error;
	wait for period;

	opcode <= "0100";
	wait for period;
	assert (o = x"dead0000") report "opcode 0100 (lui) failed" severity error;
	wait for period;

	opcode <= "0101";
	wait for period;
	assert (o = x"dead0000")  report "opcode 0101 (xor) failed" severity error;
	wait for period;

	opcode <= "0110";
	wait for period;
	wait for period;
	
	opcode <= "0111";
	wait for period;
	assert (lt = '1') report "opcode 0111 (slt) failed" severity error;
	wait for period;

	opcode <= "1100";
	wait for period;
	assert (o = not x"deadbeef") report "opcode 1100 (nor) failed" severity error;
	wait for period;
	
	wait;
end process;


end architecture testbench;
