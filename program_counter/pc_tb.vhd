library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_tb is
end entity pc_tb;

architecture testbench of pc_tb is

signal clk : std_logic := '0';
signal reset : std_logic := '1';
signal en : std_logic := '0';
signal pc_out : std_logic_vector(31 downto 0);
signal pc_in  : std_logic_vector(31 downto 0) := (others => '0');
signal ld : std_logic := '0';

signal cnt:  unsigned(2 downto 0) := "000";

constant period : time := 10 ns;

begin

dut: entity work.pc
port map(
	clk => clk,
	reset => reset,
	en => en,
	pc_out => pc_out ,
	ld => ld,
	pc_in => pc_in
);

clk <=  not clk after period/2;

stimuli: process
begin
	wait for 3*period;
	reset <= '0';
	wait until pc_out = x"00000020";
	pc_in <= x"deadbeef";
	ld <= '1';
	wait for period;
	ld <= '0';
	wait;
end process;

en_stim: process(clk)
begin
    if rising_edge(clk) then
        cnt <= cnt + 1;
        
        if cnt = "111" then
            en <= '1';
        else
            en <= '0'; 
        end if;
    end if;
end process en_stim;

end architecture testbench;
