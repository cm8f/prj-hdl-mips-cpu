library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity single_cycle_cpu is
port(
	clk 			: in  std_logic;
	reset			: in  std_logic;
	dataout		: out std_logic_vector(31 downto 0);
	led            : out std_logic_vector(31 downto 0)
);
end entity single_cycle_cpu;

architecture structural of single_cycle_cpu is

signal sl_load 						: std_logic;
signal slv_fetch_pc_loadvalue 	: std_logic_vector(31 downto 0);
signal slv_fetch_pc					: std_logic_vector(31 downto 0);
signal slv_fetch_instruction		: std_logic_vector(31 downto 0);	 

signal slv_decode_pc					: std_logic_vector(31 downto 0);
signal slv_decode_rd_data0			: std_logic_vector(31 downto 0);
signal slv_decode_rd_data1			: std_logic_vector(31 downto 0);
signal slv_decode_sign_extend		: std_logic_vector(31 downto 0);
signal slv_decode_wr_data			: std_logic_vector(31 downto 0);
signal sl_decode_branch				: std_logic;
signal sl_decode_jump				: std_logic;
signal sl_decode_memtoreg			: std_logic;
signal slv_decode_alucntrl			: std_logic_vector(3 downto 0);
signal sl_decode_memwrite			: std_logic;
signal sl_decode_alusrc				: std_logic;
signal slv_decode_jumpaddr          : std_logic_vector(31 downto 0);

signal slv_execute_pc			: std_logic_vector(31 downto 0);
signal slv_execute_pc_calc		: std_logic_vector(31 downto 0);
signal slv_execute_wr_data		: std_logic_vector(31 downto 0);
signal sl_execute_zero			: std_logic;
signal sl_execute_lt				: std_logic;
signal slv_execute_alu_result	: std_logic_vector(31 downto 0);
signal sl_execute_branch		: std_logic;
signal sl_execute_jump			: std_logic;
signal sl_execute_memtoreg		: std_logic;
signal sl_execute_memwrite		: std_logic;
signal slv_execute_jumpaddr     : std_logic_vector(31 downto 0);

signal sl_mem_jump : std_logic;

begin

i_fetch: entity work.fetch
port map(
	clk 			=> clk,
	reset 		=> reset,
	jump 			=> sl_load,
	pc_next 		=> slv_fetch_pc_loadvalue,
	pc				=> slv_fetch_pc,
	instruction	=> slv_fetch_instruction
);

sl_load <= sl_mem_jump or sl_execute_branch;

i_decode: entity work.instruction_decode
port map(
	clk 				=> clk, 
	reset 			=> reset,
	pc_in 			=> slv_fetch_pc,
	pc_out 			=> slv_decode_pc,
    jump_addr       => slv_decode_jumpaddr,
	instruction 	=> slv_fetch_instruction,
	rd_data0			=> slv_decode_rd_data0,
	rd_data1			=> slv_decode_rd_data1,
	sign_extend		=> slv_decode_sign_extend,
	wr_data			=> slv_decode_wr_data, 
	branch 			=> sl_decode_branch,
	jump				=> sl_decode_jump,
	memtoreg			=> sl_decode_memtoreg,
	alucntrl			=> slv_decode_alucntrl,
	memwrite			=> sl_decode_memwrite,
	alusrc			=> sl_decode_alusrc
);

i_execute: entity work.execute
port map(
	pc_in 			=> slv_decode_pc,
	pc_out			=> slv_execute_pc,
	pc_calc			=> slv_execute_pc_calc,
    jump_addr_in    => slv_decode_jumpaddr,
    jump_addr_out   => slv_execute_jumpaddr,
	rd_data0			=> slv_decode_rd_data0,
	rd_data1			=> slv_decode_rd_data1,
	sign_extend		=> slv_decode_sign_extend,
	wr_data			=> slv_execute_wr_data,
	zero				=> sl_execute_zero,
	lt					=> sl_execute_lt,
	alu_result		=> slv_execute_alu_result,
	branch_in 		=> sl_decode_branch,
	jump_in			=> sl_decode_jump,
	memtoreg_in		=> sl_decode_memtoreg,
	alucntrl_in		=> slv_decode_alucntrl,
	memwrite_in		=> sl_decode_memwrite,
	alusrc_in		=> sl_decode_alusrc,
	branch			=> sl_execute_branch,
	jump				=> sl_execute_jump,
	memtoreg			=> sl_execute_memtoreg,
	memwrite			=> sl_execute_memwrite
);

i_memory_access_and_write_back: entity work.memory_access 
port map(
	clk 				=> clk,
	reset               => reset,
	pc_in				=> slv_execute_pc,
	pc_calc 			=> slv_execute_pc_calc,
	pc_out			=> slv_fetch_pc_loadvalue,
    jump_addr       => slv_execute_jumpaddr,
	zero				=> sl_execute_zero,
	lt					=> sl_execute_lt,
	alu_res			=> slv_execute_alu_result,
	wr_data			=> slv_execute_wr_data,
	rd_data			=> slv_decode_wr_data,
	branch			=> sl_execute_branch,
	jump				=> sl_execute_jump,
	memtoreg			=> sl_execute_memtoreg,
	memwrite			=> sl_execute_memwrite,
	jump_out			=> sl_mem_jump,
	led                => led
);

dataout <= slv_decode_wr_data;

end architecture structural;
