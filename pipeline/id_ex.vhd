library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity id_ex is 
port(
    clk     : in  std_logic;
    en      : in  std_logic;
    -- input signals
    id_pc       : in  std_logic_vector(31 downto 0);
    id_rd_data0 : in  std_logic_vector(31 downto 0);
    id_rd_data1 : in  std_logic_vector(31 downto 0);
    id_signext  : in  std_logic_vector(31 downto 0);
    --id_instr_20 : in  std_logic_vector( 4 downto 0);
    --id_instr_15 : in  std_logic_vector( 4 downto 0);
    id_rs       : in  std_logic_vector(4 downto 0);
    id_rt       : in  std_logic_vector(4 downto 0);
    id_rd       : in  std_logic_vector(4 downto 0);  
    -- output signals 
    ex_pc       : out std_logic_vector(31 downto 0);
    ex_rd_data0 : out std_logic_vector(31 downto 0);
    ex_rd_data1 : out std_logic_vector(31 downto 0);
    ex_signext  : out std_logic_vector(31 downto 0);
    --ex_instr_20 : out std_logic_vector( 4 downto 0);
    --ex_instr_15 : out std_logic_vector( 4 downto 0);
    ex_rs       : out std_logic_vector(4 downto 0);
    ex_rt       : out std_logic_vector(4 downto 0);
    ex_rd       : out std_logic_vector(4 downto 0);       
    -- control signals 
    id_ex_alusrc    : in  std_logic;
    id_ex_alucntrl  : in  std_logic_Vector(3 downto 0);
    id_ex_regdst    : in  std_logic;
    id_me_branch    : in  std_logic;
    id_me_jump      : in  std_logic;
    id_me_jumpaddr  : in  std_logic_vector(31 downto 0);
    id_me_memwrite  : in  std_logic;
    id_wb_regwrite  : in  std_logic;
    id_wb_memtoreg  : in  std_logic;
    ex_ex_alusrc    : out std_logic;
    ex_ex_alucntrl  : out std_logic_Vector(3 downto 0);
    ex_ex_regdst    : out std_logic;
    ex_me_branch    : out std_logic;
    ex_me_jump      : out std_logic;
    ex_me_jumpaddr  : out std_logic_vector(31 downto 0);
    ex_me_memwrite  : out std_logic;
    ex_wb_regwrite  : out std_logic;
    ex_wb_memtoreg  : out std_logic
);
end entity;

architecture behavioral of id_ex is

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                ex_pc           <= id_pc;
                ex_rd_data0     <= id_rd_data0;
                ex_rd_data1     <= id_rd_data1;
                ex_signext      <= id_signext;
                --ex_instr_20     <= id_instr_20;
                --ex_instr_15     <= id_instr_15;
                ex_rs           <= id_rs;
                ex_rt           <= id_rt;
                ex_rd           <= id_rd;

                ex_ex_alusrc    <= id_ex_alusrc;
                ex_ex_alucntrl  <= id_ex_alucntrl;
                ex_ex_regdst    <= id_ex_regdst;

                ex_me_branch    <= id_me_branch;
                ex_me_jump      <= id_me_jump;
                ex_me_jumpaddr  <= id_me_jumpaddr;
                ex_me_memwrite  <= id_me_memwrite;

                ex_wb_regwrite  <= id_wb_regwrite;
                ex_wb_memtoreg  <= id_wb_memtoreg;
            end if;
        end if;
    end process;

end architecture behavioral;
        
