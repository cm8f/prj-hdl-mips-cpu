library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile is
	port(
		clk : in std_logic;
		reset : in std_logic;
		rd_addr0 : in std_logic_vector(4 downto 0);
		rd_addr1 : in std_logic_vector(4 downto 0);
		wr_addr  : in std_logic_vector(4 downto 0);
		wr_ena	 : in std_logic;
		wr_data  : in std_logic_vector(31 downto 0);
		rd_data0 : out std_logic_vector(31 downto 0);
		rd_data1 : out std_logic_vector(31 downto 0)
	);
end entity regfile;

architecture behavioral of regfile is

-- typedef
type regbank_t is array (0 to 31) of std_logic_vector(31 downto 0);

-- signal definitions
signal regbank : regbank_t;

begin

asynchronous: process(rd_addr0, rd_addr1, regbank)
begin
	rd_data0 <= regbank(to_integer(unsigned(rd_addr0)));
	rd_data1 <= regbank(to_integer(unsigned(rd_addr1)));
end process;

synchronous: process(reset, clk)
begin
	if reset = '1' then
		regbank <= (others => (others => '0'));
	elsif rising_edge(clk) then
		if wr_ena = '1' then
			regbank(to_integer(unsigned(wr_addr))) <= wr_data;
		end if;
	end if;
end process synchronous;

end architecture behavioral;
