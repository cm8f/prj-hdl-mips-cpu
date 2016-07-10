library ieee;
use ieee.std_logic_1164.all;

entity write_back is
port(
    memtoreg    : in  std_logic;
    rd_data     : in  std_logic_vector(31 downto 0);
    alures      : in  std_logic_vector(31 downto 0);
    addr_in     : in  std_logic_vector(4 downto 0);
    addr_out    : out std_logic_vector(4 downto 0);
    wr_data     : out std_logic_vector(31 downto 0)
);
end entity write_back;

architecture behavioral of write_back is

begin

addr_out <= addr_in;

with memtoreg select wr_data <= rd_data when '0',
                                alures when others;

end architecture behavioral;