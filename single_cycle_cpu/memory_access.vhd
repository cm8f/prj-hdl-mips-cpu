library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.mem_pkg.all;

entity memory_access is
	port(
		clk 		: in  std_logic;
		reset		: in  std_logic;
        jump_addr   : in  std_logic_vector(31 downto 0);
		pc_in 	: in  std_logic_vector(31 downto 0);
		pc_calc	: in  std_logic_vector(31 downto 0);
		pc_out	: out std_logic_vector(31 downto 0);
		-- from alu
		zero		: in  std_logic;
		lt 		: in  std_logic;
		alu_res	: in  std_logic_vector(31 downto 0);
		--from/to register
		wr_data	: in  std_logic_vector(31 downto 0);
		rd_data	: out std_logic_vector(31 downto 0);
        -- hw register
        led     : out std_logic_vector(31 downto 0);
		-- from control
		branch	: in  std_logic;
		jump		: in  std_logic;
		memtoreg	: in  std_logic;
		memwrite	: in  std_logic;
		jump_out	: out std_logic
	);
end entity memory_access;

architecture mixed of memory_access is

signal sl_select_pc_source : std_logic;
signal slv_read_data : std_logic_vector(31 downto 0);
signal slv_pc   : std_logic_vector(31 downto 0);

begin

jump_out <= jump;

with sl_select_pc_source select slv_pc <= 
										pc_in   when '0',
										pc_calc when others;

with jump select pc_out <= 
                    jump_addr when '1',
                    slv_pc    when others;
										
sl_select_pc_source <= branch and zero;

with memtoreg select rd_data <=
								alu_res when '0',
								slv_read_data when others;

data_mem_0: entity work.data_mem
	port map(
		clk => clk, 
		idata => wr_data,
		odata => slv_read_data,
		addr => alu_res(addrw+2-1 downto 2),
		wren => memwrite
	);

hw_reg_0: entity work.hw_reg
    port map(
        clk => clk,
        reset => reset,
        data => wr_data,
        addr => alu_res,
        ena  => memwrite,
        to_pins => led
    );



end architecture mixed;
