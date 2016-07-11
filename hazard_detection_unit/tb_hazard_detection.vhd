library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

entity tb_hazard_detection is
end entity;

architecture testbench of tb_hazard_detection is

    signal idex_memread : std_logic;
    signal idex_rt      : std_logic_vector(4 downto 0);
    signal ifid_rs      : std_logic_vector(4 downto 0);
    signal ifid_rt      : std_logic_vector(4 downto 0);
    signal pcwrite      : std_logic;
    signal ifidwrite    : std_logic;
    signal controlmuxsel: std_logic;

begin

    dut: entity work.hazard_detection
    port map(
        idex_memread    => idex_memread,
        idex_rt         => idex_rt,
        ifid_rs         => ifid_rs,
        ifid_rt         => ifid_rt,
        pcwrite         => pcwrite,
        ifidwrite       => ifidwrite,
        controlmuxsel   => controlmuxsel
    );

    stimuli: process
    begin
        idex_memread <= '0';
        idex_rt <= "00010";
        ifid_rs <= "00100";
        ifid_rt <= "01000";

        wait for 10 ns;

        idex_memread <= '1';

        wait for 10 ns;

        idex_rt <= "00100";
        
        wait for 10 ns;

        idex_rt <= "01000";

        wait ;
        
        
    end process stimuli;

end architecture testbench;
