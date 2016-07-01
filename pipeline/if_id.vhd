library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity if_id is
port(
    clk     : in std_logic;
    en      : in std_logic;
    pc      : in std_logic_vector(31 downto 0);
    instr   : in std_logic_vector(31 downto 0);
    pc_o    : out std_logic_vector(31 downto 0);
    intr_o  : out std_logic_vector(31 downto 0)
);
end entity if_id;

architecture behavioral of if_id is 

begin

    process(clk) 
    begin
        if en = '1' then
            pc_o <= pc;
            instr_o <= instr;
        end if;
    end process;

end architecture behavioral;


    
    
