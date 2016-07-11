library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity tb_forwarding is
end entity;

architecture testbench of tb_forwarding is

    signal rs           : std_logic_vector(4 downto 0);
    signal rt           : std_logic_vector(4 downto 0);
    signal exmem_rd     : std_logic_vector(4 downto 0);
    signal exmem_regwr  : std_logic;
    signal memwb_rd     : std_logic_vector(4 downto 0);
    signal memwb_regwr  : std_logic;
    signal forwardA     : std_logic_vector(1 downto 0);
    signal forwardB     : std_logic_vector(1 downto 0);

    constant period : time := 10 ns;

begin

    dut: entity work.forwarding_unit 
    port map(
        rs          => rs,
        rt          => rt,
        exmem_rd    => exmem_rd,
        exmem_regwr => exmem_regwr,
        memwb_rd    => memwb_rd,
        memwb_regwr => memwb_regwr,
        forwardA    => forwardA,
        forwardB    => forwardB
    );

    stimuli: process
    begin
        rs <= "00000";
        rt <= "10101";
        
        exmem_regwr <= '0';
        exmem_rd    <= "00000";
        memwb_regwr <= '0';
        memwb_rd    <= "00000";

        wait for 10 ns;

        exmem_regwr <= '1';
        memwb_regwr <= '1';

        wait for 10 ns;

        exmem_rd <= "10101";
        
        wait for 10 ns;

        exmem_rd <= "11011";
        memwb_rd <= "10101";

        wait for 10 ns;

        wait;
    end process;
    

end architecture testbench;
