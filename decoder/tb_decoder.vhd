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

signal vec : std_logic_vector(15 downto 0);

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

stimuli2: process
begin
    vec <= x"0024";
    wait for 10 ns;
    vec <= x"0025";
    wait for 10 ns;
    vec <= x"0020";
    wait for 10 ns;
    vec <= x"0faa";
    wait for 10 ns;
    vec <= x"0026";
    wait for 10 ns;
    vec <= x"0022";
    wait for 10 ns;
    vec <= x"002a";
    wait for 10 ns;
    vec <= x"0027";
    wait for 10 ns;
    vec <= x"0806";
    wait for 10 ns;
    vec <= x"0406";
    wait for 10 ns;
    vec <= x"2306";
    wait for 10 ns;
    vec <= x"2b06";
    wait for 10 ns;
    wait;
end process;

slv_func <= vec(7 downto 0);
slv_opcode <= vec(15 downto 8);

end architecture testbench;
