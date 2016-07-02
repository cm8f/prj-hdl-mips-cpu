library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_single_cycle_cpu is
end entity tb_single_cycle_cpu;

architecture testbench of tb_single_cycle_cpu is

    signal clk      : std_logic := '1';
    signal reset    : std_logic := '1';
    signal dataout  : std_logic_vector(31 downto 0);

    constant period : time := 10 ns;

begin

    clk <= not clk after period/2;

    process
    begin
        reset <= '1';
        wait for period;
        reset <= '0';
        wait;
    end process;

    
    dut : entity work.single_cycle_cpu
        port map (
            clk 			 => clk,
            reset			 => reset,
            dataout		 => dataout
        );


end architecture testbench;
