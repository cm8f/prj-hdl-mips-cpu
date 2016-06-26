library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	port(
		a : in std_logic_vector(31 downto 0);
		b : in std_logic_vector(31 downto 0);
		opcode : in std_logic_vector(3 downto 0);
		o : out std_logic_vector(31 downto 0);
		lessthan: out std_logic;
		zero		: out std_logic
	);
end entity alu;

architecture behavioral of alu is

--signal slv_opcode : std_logic_vector(
signal slv_o : std_logic_vector(31 downto 0);
signal slv_lt : std_logic;

begin

process(opcode)
begin
    case(opcode) is
    when "0000" => slv_o <= (a and b);
    when "0001" => slv_o <= (a or  b);
    when "0010" => slv_o <= std_logic_vector(signed(a) + signed(b));
    when "0100" => slv_o <= b(15 downto 0) & x"0000";
    when "0101" => slv_o <= a xor b;
    when "0110" => slv_o <= std_logic_vector(signed(a) - signed(b));
    when "1100" => slv_o <= a nor b;
    when "0111" =>
        if signed(a) < signed(b) then
            slv_o <= std_logic_vector(to_signed(1, 32));
        else 
            slv_o <= (others => '0');
        end if;
    when others => null;
    end case;
end process;


lessthan <= slv_lt;
o <= slv_o;

with slv_o select zero <= '1' when std_logic_vector(to_unsigned(0, 32)),
									'0' when others;

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
