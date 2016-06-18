library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_decoder is
end entity tb_decoder;

architecture testbench of tb_decoder is

signal opcode : std_logic_vector(5 downto 0);
signal func   : std_logic_vector(5 downto 0);
signal regdst : std_logic;
signal jump		: std_logic;
signal branch : std_logic;
signal memtoreg	: std_logic;
signal alucntrl : std_logic_vector(3 downto 0);
signal memwrite : std_logic;
signal alusrc 	: std_logic;
signal regwrite	: std_logic;

signal slv_opcode : std_logic_vector(7 downto 0) := (others => '0');
signal slv_func   : std_logic_vector(7 downto 0) := (others => '0');

begin

opcode <= slv_opcode(5 downto 0);
func   <= slv_func(5 downto 0);

dut : entity work.decoder
port map(
	opcode => opcode,
	func => func,
	regdst => regdst,
	jump => jump,
	branch => branch,
	memtoreg => memtoreg,
	alucntrl => alucntrl,
	memwrite => memwrite,
	alusrc => alusrc,
	regwrite => regwrite
);

stimuli: process
begin
	slv_func   <= x"00";
	slv_opcode <= x"0f";
	wait for 10 ns;
	slv_opcode <= x"08";
	wait for 10 ns;
	slv_opcode <= x"04";
	wait for 10 ns;
	slv_opcode <= x"23";
	wait for 10 ns;
	slv_opcode <= x"2b";
	wait for 50 ns;
	slv_opcode <= x"00";
	slv_func <= x"24";
	wait for 10 ns;
	slv_func <= x"2A";
	wait;
end process stimuli;

end architecture testbench;
