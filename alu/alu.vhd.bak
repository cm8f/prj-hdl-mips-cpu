library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	port(
		a : in std_logic_vector(31 downto 0);
		b : in std_logic_vector(31 downto 0);
		opcode : in std_logic_vector(3 downto 0);
		o : out std_logic_vector(31 downto 0);
		lessthan: out std_logic
	);
end entity alu;

architecture behavioral of alu is

--signal slv_opcode : std_logic_vector(
signal slv_o : std_logic_vector(31 downto 0);
signal slv_lt : std_logic;

begin

with opcode select o <= 
	(a and b) when "0000",
	(a or  b) when "0001",
	(std_logic_vector(signed(a) + signed(b))) when "0010",
	(b(31 downto 16) & x"0000") when "0100",
	(a xor b) when "0101",
	(std_logic_vector(signed(a) - signed(b))) when "0110",
	(a nor b) when "1100",
	slv_o  when others;

lessthan <= slv_lt;
--o <= slv_o;

process(a,b,opcode)
begin
	slv_lt <= '0';
	if opcode = "0111" then
		if (signed(a) < signed(b)) then
			slv_lt <= '1';
		end if;
	end if;	
end process;

end architecture;
