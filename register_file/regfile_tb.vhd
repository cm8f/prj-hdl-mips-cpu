library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile_tb is
end entity regfile_tb;

architecture testbench of regfile_tb is

signal clk   	: std_logic := '0';
signal reset    : std_logic := '1';
signal rd_addr0 : std_logic_vector(4 downto 0) := (others => '0');
signal rd_addr1 : std_logic_vector(4 downto 0) := (others => '1');
signal wr_addr  : std_logic_vector(4 downto 0) := (others => '0');
signal wr_ena 	: std_logic := '0';
signal wr_data 	: std_logic_vector(31 downto 0) := (others => '0');
signal rd_data0 : std_logic_vector(31 downto 0);
signal rd_data1 : std_logic_vector(31 downto 0);

signal enrdcnt  : std_logic;
constant period : time := 10 ns;

begin

clk <= not clk after period/2;

dut: entity work.regfile 
	port map(
		clk => clk,
		reset => reset,
		rd_addr0 => rd_addr0,	
		rd_addr1 => rd_addr1,	
		wr_addr  => wr_addr,
		wr_ena => wr_ena,
		wr_data => wr_data,
		rd_data0 => rd_data0,
		rd_data1 => rd_data1
	);

stimuli_wr: process
begin
	reset <= '1';	
	wait for 5*period;
	reset <= '0';
	wait for period;
	wr_addr <= "00010";
	wr_data <= x"deadbeef";
	wait for period;
	wr_ena <= '1' ;
	wait for period;
	wr_ena <= '0';
	wr_addr <= "01010";
	wr_data <= x"beefbeef";
	wait for period;
	wr_ena <= '1' ;
	wait for period;
	wr_ena <= '0';
	wr_addr <= "00111";
	wr_data <= x"cafeaffe";
	wait for period;
	wr_ena <= '1' ;
	wait for period;
	wr_ena <= '0';
	wait;
end process stimuli_wr;

stimuli_rd: process
begin
	enrdcnt <= '0';
	wait for 20*period;
	enrdcnt <= '1';
	wait;
end process;

cnt: process(clk) 
begin
	if rising_edge(clk) then
		if enrdcnt = '1' then
			rd_addr1 <= std_logic_vector(unsigned(rd_addr1) - 1);		
			rd_addr0 <= std_logic_vector(unsigned(rd_addr0) - 1);		
		end if;
	end if;
end process cnt;

end architecture testbench;
