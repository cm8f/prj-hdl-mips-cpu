library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex_mem is
port(
    clk         : in  std_logic;
    en          : in  std_logic;
    -- input
    ex_pc       : in  std_logic_vector(31 downto 0);
    ex_zero     : in  std_logic;
    ex_lt       : in  std_logic;
    ex_alures   : in  std_logic_vector(31 downto 0);
    ex_wr_data  : in  std_logic_vector(31 downto 0);
    ex_wr_addr  : in  std_logic_vector(31 downto 0);
    -- output
    mem_pc       : out std_logic_vector(31 downto 0);
    mem_zero     : out std_logic;
    mem_lt       : out std_logic;
    mem_alures   : out std_logic_vector(31 downto 0);
    mem_wr_data  : out std_logic_vector(31 downto 0);
    mem_wr_addr  : out std_logic_vector(31 downto 0);
    --control
    ex_wb_regwrite : in  std_logic;
    ex_wb_memtoreg : in  std_logic;

    ex_mem_branch   : in  std_logic;
    ex_mem_memwrite : in  std_logic;

    mem_wb_regwrite : out std_logic;
    mem_wb_memtoreg : out std_logic;

    mem_mem_branch   : out std_logic;
    mem_mem_memwrite : out std_logic
);
end entity ex_mem;

architecture behavioral of ex_mem is

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                mem_pc      <= ex_pc;
                mem_zero    <= ex_zero;
                mem_lt      <= ex_lt;
                mem_alures  <= ex_alures;
                mem_wr_data <= ex_wr_data;
                mem_wr_addr <= ex_wr_addr;

                mem_wb_regwrite <= ex_wb_regwrite;
                mem_wb_memtoreg <= ex_wb_memtoreg;

                mem_mem_branch   <= ex_mem_branch;
                mem_mem_memwrite <= ex_mem_memwrite;
    end process;

end architecture behavioral;
