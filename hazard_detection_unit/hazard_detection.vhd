library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

entity hazard_detection is
    port (
        idex_memread    : in std_logic;
        idex_rt         : in std_logic_vector(4 downto 0);
        ifid_rs         : in std_logic_vector(4 downto 0);
        ifid_rt         : in std_logic_vector(4 downto 0);
        
        pcwrite         : out std_logic;
        ifidwrite       : out std_logic;
        controlmuxsel   : out std_logic
    );
end entity hazard_detection;
    
architecture behavioral of hazard_detection is


    signal sl_stall                 : std_logic;
    signal sl_idex_rt_is_ifid_rs    : std_logic;
    signal sl_idex_rt_is_ifid_rt    : std_logic;

begin

    sl_idex_rt_is_ifid_rs <= not or_reduce(idex_rt xor ifid_rs);
    sl_idex_rt_is_ifid_rt <= not or_reduce(idex_rt xor ifid_rt);

    sl_stall <= idex_memread and (sl_idex_rt_is_ifid_rt or sl_idex_rt_is_ifid_rs);

    pcwrite         <= not sl_stall;
    ifidwrite       <= not sl_stall;
    controlmuxsel   <= sl_stall;


--    compare: process(idex_rt, ifid_rs, ifid_rt)
--    begin
--        sl_idex_rt_is_ifid_rs   <= '0';
--        if idex_rt = ifid_rs then
--            sl_idex_rt_is_ifid_rs <= '1';
--        end if;

--        sl_idex_rt_is_ifid_rt <= '0';
--        if idex_rt = ifid_rt then
--            sl_idex_rt_is_ifid_rt <= '1';
--        end if;
--    end if;

end architecture behavioral;
        
