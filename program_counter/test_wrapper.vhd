-- 
--
-- fuer die implementierung auf zedboard 
-- constraints auf hierauf ausgelegt
--
--
library ieee;
use ieee.std_logic_1164.all;

entity test_wrapper is
port(
	clk : in std_logic;
	reset : in std_logic;
	en :  in std_logic;
	pc_out : out std_logic_vector(7 downto 0)
);
end entity test_wrapper;

architecture structural of test_wrapper is

constant c_pcin : std_logic_vector(31 downto 0) := (others => '0');

signal slv_pcout : std_logic_vector(31 downto 0);

begin

i_pc: entity work.pc
port map(
	clk => clk,
	reset => reset,
	en => en,
	pc_out => slv_pcout,
	ld => '0',
	pc_in => c_pcin
);

pc_out <= slv_pcout(31 downto 24);

end architecture structural;
