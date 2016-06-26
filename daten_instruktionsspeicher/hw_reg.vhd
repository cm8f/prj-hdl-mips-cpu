library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

use work.mem_pkg.all;

entity hw_reg is
    generic(
        target_addr : std_logic_vector(31 downto 0) := x"00002000"
    );
    port(
        clk         : in  std_logic;
        reset       : in  std_logic;
        data        : in  std_logic_vector(31 downto 0);
        addr        : in  std_logic_vector(31 downto 0);
        ena         : in  std_logic;
        to_pins     : out std_logic_vector(31 downto 0)
    );
end entity hw_reg;

architecture behavioral of hw_reg is

    signal slv_reg : std_logic_vector(31 downto 0);
    signal sl_ena  : std_logic;

begin

    sl_ena <= ena and not or_reduce(target_addr xor addr);
    to_pins <= slv_reg;

    process(clk,reset)
    begin
        if reset = '1' then 
            slv_reg <= (others => '0');
        elsif rising_edge(clk) then
            if sl_ena = '1' then
                slv_reg <= data;
            end if;
        end if;
    end process;

end architecture behavioral;
        
        
