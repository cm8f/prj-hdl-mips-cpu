library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_wb is
    port(
    clk         : in std_logic;
    en          : in std_logic;
    -- input
    mem_rd_data : in std_logic_vector(31 downto 0);
    mem_alures  : in std_logic_vector(31 downto 0);
    mem_wr_reg  : in std_logic_vector( 4 downto 0);
    -- output
    wb_rd_data  : out std_logic_vector(31 downto 0);
    wb_alures   : out std_logic_vector(31 downto 0);
    wb_wr_reg   : out std_logic_vector( 4 downto 0);
    -- control
    mem_wb_regwrite : in std_logic;
    mem_wb_memtoreg : in std_logic;
    
    wb_wb_regwrite  : out std_logic;
    wb_wb_memtoreg  : out std_logic
);
end entity mem_wb;

architecture behavioral of mem_wb is

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                wb_rd_data  <= mem_rd_data;
                wb_alures   <= mem_alures;
                wb_wr_reg   <= mem_wr_reg;

                wb_wb_regwrite <= mem_wb_regwrite;
                wb_wb_memtoreg <= mem_wb_memtoreg;
            end if;
        end if;
    end process;

end architecture behavioral;

