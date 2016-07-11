library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

entity forwarding_unit is
    port(
        rs  : in  std_logic_vector(4 downto 0);
        rt  : in  std_logic_vector(4 downto 0);
        exmem_rd    : in  std_logic_vector(4 downto 0);
        exmem_regwr : in  std_logic;
        --exmem_m2reg : in  std_logic;
        memwb_rd    : in  std_logic_vector(4 downto 0);
        memwb_regwr : in  std_logic;
        --memwb_m2reg : in  std_logic;
        forwardA    : out std_logic_vector(1 downto 0);
        forwardB    : out std_logic_vector(1 downto 0)
    );
end entity forwarding_unit;

architecture behavioral of forwarding_unit is

    signal sl_rs_is_rd_exmem    : std_logic;
    signal sl_rs_is_rd_memwb    : std_logic;

    signal sl_rt_is_rd_exmem    : std_logic;
    signal sl_rt_is_rd_memwb    : std_logic;

    signal sl_rs_is_nonzero        : std_logic;
    signal sl_rt_is_nonzero        : std_logic;

begin

    sl_rs_is_nonzero <= or_reduce(rs);  -- zero if all zero, one if at least one is 1
    sl_rt_is_nonzero <= or_reduce(rt);

    compare:process(rs, rt, exmem_rd, memwb_rd)
    begin
        -- exmem stage compare
        sl_rs_is_rd_exmem <= '0';
        if rs = exmem_rd then
            sl_rs_is_rd_exmem <= '1';
        end if;

        sl_rt_is_rd_exmem <= '0';
        if rt = exmem_rd then
            sl_rt_is_rd_exmem <= '1';
        end if;
        
        -- memwb stage compare
        sl_rs_is_rd_memwb <= '0';
        if rs = memwb_rd then
            sl_rs_is_rd_memwb <= '1';
        end if;

        sl_rt_is_rd_memwb <= '0';
        if rt = memwb_rd then
            sl_rt_is_rd_memwb <= '1';
        end if;
    end process;

    forwardA(1) <= sl_rs_is_nonzero and sl_rs_is_rd_exmem and exmem_regwr;
    forwardA(0) <= sl_rs_is_nonzero and sl_rs_is_rd_memwb and memwb_regwr;
    forwardB(1) <= sl_rt_is_nonzero and sl_rt_is_rd_exmem and exmem_regwr;
    forwardB(0) <= sl_rt_is_nonzero and sl_rt_is_rd_memwb and memwb_regwr;
        

end architecture behavioral;
