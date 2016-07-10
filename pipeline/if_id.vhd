library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity if_id is
port(
    clk     : in std_logic;
    en      : in std_logic;
    if_pc      : in std_logic_vector(31 downto 0);
    if_instr   : in std_logic_vector(31 downto 0);
    id_pc    : out std_logic_vector(31 downto 0);
    id_instr  : out std_logic_vector(31 downto 0)
);
end entity if_id;

architecture behavioral of if_id is 

begin

    process(clk) 
    begin
        if rising_edge(clk) then
            if en = '1' then
                id_pc   <= if_pc;
                id_instr<= if_instr;
            end if;
        end if;
    end process;

end architecture behavioral;


    
    
