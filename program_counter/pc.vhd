library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is 
	port(
		clk 	 : in std_logic;
		reset 	 : in std_logic;
		en	     : in std_logic;	
		pc_out	 : out std_logic_vector(31 downto 0);
		ld       : in std_logic;
		pc_in    : in std_logic_vector(31 downto 0)
	);
end entity pc;

architecture behavioral of pc is

signal reg_pc 		: std_logic_vector(31 downto 0);
signal reg_pc_next 	: std_logic_vector(31 downto 0);

begin

p_next: process(reg_pc)
begin
	reg_pc_next <= std_logic_vector(unsigned(reg_pc) + 4);
end process p_next;

p_reg: process(clk, reset)
begin
	if reset = '1' then 
		reg_pc <= (others => '0');
	elsif rising_edge(clk) then
		  reg_pc <= reg_pc;
		  --if ld = '1' then	-- load hat prioritaet
		  --  reg_pc <= pc_in;
		  --elsif en = '1' then
          if en = '1' then
			reg_pc <= reg_pc_next;
            if ld = '1' then 
                reg_pc <= pc_in;
            end if;
		  end if;
	end if;
end process p_reg;

pc_out <= reg_pc;


end architecture behavioral;
