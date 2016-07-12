library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipelined_cpu is
port(
	clk 			: in  std_logic;
	reset			: in  std_logic;
	dataout		: out std_logic_vector(31 downto 0);
	led            : out std_logic_vector(31 downto 0)
);
end entity pipelined_cpu;

architecture structural of pipelined_cpu is

signal sl_load 						: std_logic;
signal slv_fetch_pc_loadvalue 	: std_logic_vector(31 downto 0);
signal slv_fetch_pc					: std_logic_vector(31 downto 0);
signal slv_fetch_instruction		: std_logic_vector(31 downto 0);	 

signal slv_decode_pc					: std_logic_vector(31 downto 0);
signal slv_decode_rd_data0			: std_logic_vector(31 downto 0);
signal slv_decode_rd_data1			: std_logic_vector(31 downto 0);
signal slv_decode_sign_extend		: std_logic_vector(31 downto 0);
--signal slv_decode_wr_data			: std_logic_vector(31 downto 0);
signal sl_decode_branch				: std_logic;
signal sl_decode_jump				: std_logic;
signal sl_decode_memtoreg			: std_logic;
signal slv_decode_alucntrl			: std_logic_vector(3 downto 0);
signal sl_decode_memwrite			: std_logic;
signal sl_decode_memread            : std_logic;
signal sl_decode_alusrc				: std_logic;
signal slv_decode_jumpaddr          : std_logic_vector(31 downto 0);
--
signal slv_decode_wr_addr           : std_logic_vector(4 downto 0);
signal slv_decode_rt                : std_logic_vector(4 downto 0);
signal slv_decode_rd                : std_logic_vector(4 downto 0);
signal slv_decode_rs                : std_logic_vector(4 downto 0);
signal sl_decode_regdst             : std_logic;
signal sl_decode_regwrite           : std_logic;
signal sl_decode_ifidwrite          : std_logic;


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
signal sl_execute_regwrite      : std_logic;
signal slv_execute_wr_addr      : std_logic_vector(4 downto 0);

signal sl_mem_jump : std_logic;

signal slv_ifid_pc          : std_logic_vector(31 downto 0);
signal slv_ifid_instruction : std_logic_vector(31 downto 0);
signal slv_ifid_rt          : std_logic_vector(4 downto 0);
signal slv_ifid_rs          : std_logic_vector(4 downto 0);

signal slv_idex_pc          : std_logic_vector(31 downto 0);
signal slv_idex_rd_data0    : std_logic_vector(31 downto 0);
signal slv_idex_rd_data1    : std_logic_vector(31 downto 0);
signal slv_idex_signext     : std_logic_vector(31 downto 0);
signal slv_idex_rt          : std_logic_vector(4 downto 0);
signal slv_idex_rd          : std_logic_vector(4 downto 0);
signal slv_idex_rs          : std_logic_vector(4 downto 0);
signal sl_idex_alusrc       : std_logic;
signal slv_idex_alucntrl    : std_logic_Vector(3 downto 0);
signal sl_idex_regdst       : std_logic;
signal sl_idex_branch       : std_logic;
signal sl_idex_memwrite     : std_logic;
signal sl_idex_memread      : std_logic;
signal sl_idex_regwrite     : std_logic;
signal sl_idex_memtoreg     : std_logic;
signal sl_idex_jump         : std_logic;
signal slv_idex_jumpaddr    : std_logic_vector(31 downto 0);

signal slv_exmem_pc         : std_logic_vector(31 downto 0);
signal slv_exmem_pc_calc    : std_logic_vector(31 downto 0);
signal sl_exmem_zero        : std_logic;
signal sl_exmem_lt          : std_logic;
signal slv_exmem_alures     : std_logic_vector(31 downto 0);
signal slv_exmem_wr_data    : std_logic_vector(31 downto 0);
signal slv_exmem_wr_addr    : std_logic_vector(4 downto 0);
signal sl_exmem_regwrite    : std_logic;
signal sl_exmem_memtoreg    : std_logic;
signal sl_exmem_branch      : std_logic;
signal sl_exmem_jump        : std_logic;
signal slv_exmem_jumpaddr   : std_logic_vector(31 downto 0);
signal sl_exmem_memwrite    : std_logic; 

signal sl_wb_regwrite       : std_logic;
signal slv_wb_wr_data       : std_logic_vector(31 downto 0);
signal slv_wb_reg           : std_logic_vector(4 downto 0);

signal slv_mem_rd_data      : std_logic_vector(31 downto 0);
signal slv_mem_rd_alures    : std_logic_vector(31 downto 0);
signal sl_mem_memwrite      : std_logic;
signal sl_mem_memtoreg      : std_logic;
signal sl_mem_regwrite      : std_logic;
signal slv_mem_wr_data      : std_logic_vector(31 downto 0);
signal slv_mem_wr_addr      : std_logic_vector(4 downto 0);

signal slv_memwb_rd_data    : std_logic_vector(31 downto 0);
signal slv_memwb_alures     : std_logic_vector(31 downto 0);
signal slv_memwb_wr_reg     : std_logic_vector(4 downto 0);
signal sl_memwb_regwrite    : std_logic;
signal sl_memwb_memtoreg    : std_logic;

signal sl_decode_pcwrite    : std_logic;
signal sl_ifidwrite         : std_logic;

begin

i_fetch: entity work.fetch
port map(
	clk 			=> clk,
	en              => sl_decode_pcwrite,
	reset 		    => reset,
	jump 			=> sl_load,
	pc_next 		=> slv_fetch_pc_loadvalue,
	pc				=> slv_fetch_pc,
	instruction	=> slv_fetch_instruction
);

i_if_id: entity work.if_id
port map(
    clk         => clk,
    en          => sl_ifidwrite,
    if_pc       => slv_fetch_pc,
    if_instr    => slv_fetch_instruction,
    id_pc       => slv_ifid_pc,
    id_instr    => slv_ifid_instruction
    );
    
slv_ifid_rt <= slv_ifid_instruction(20 downto 16);
slv_ifid_rs <= slv_ifid_instruction(25 downto 21);

sl_load <= sl_mem_jump or sl_execute_branch;


i_decode: entity work.instruction_decode
port map(
	clk 			=> clk, 
	reset 			=> reset,
	pc_in 			=> slv_ifid_pc,
	pc_out 			=> slv_decode_pc,
    jump_addr       => slv_decode_jumpaddr,
	instruction     => slv_ifid_instruction,
	rd_data0        => slv_decode_rd_data0,
	rd_data1        => slv_decode_rd_data1,
	sign_extend     => slv_decode_sign_extend,
	--wr_data			=> slv_decode_wr_data, 
	wr_data         => slv_wb_wr_data,
	branch          => sl_decode_branch,
	jump			=> sl_decode_jump,
	memtoreg		=> sl_decode_memtoreg,
	alucntrl		=> slv_decode_alucntrl,
	memwrite		=> sl_decode_memwrite,
	memread         => sl_decode_memread,
	alusrc			=> sl_decode_alusrc,
	i_regwrite      => sl_memwb_regwrite,
	--wr_addr         => slv_decode_wr_addr,
	wr_addr        => slv_wb_reg,
	rt             => slv_decode_rt,
	rd             => slv_decode_rd,
	rs             => slv_decode_rs,
	regdst         => sl_decode_regdst,
	regwrite       => sl_decode_regwrite,
	-- hazard detection
	idex_memread   => sl_idex_memread,
	idex_rt        => slv_idex_rt,
	ifid_rt        => slv_ifid_rt,
	ifid_rs        => slv_ifid_rs,
	pcwrite        => sl_decode_pcwrite,
	ifidwrite      => sl_decode_ifidwrite
);

i_idex: entity work.id_ex
port map(
    clk => clk,
    en => '1',
    id_pc           => slv_decode_pc,
    id_rd_data0     => slv_decode_rd_data0,
    id_rd_data1     => slv_decode_rd_data1,
    id_signext      => slv_decode_sign_extend,
    id_rt           => slv_decode_rt,
    id_rd           => slv_decode_rd,
    id_rs           => slv_decode_rs,
    
    ex_pc           => slv_idex_pc,
    ex_rd_data0     => slv_idex_rd_data0,
    ex_rd_data1     => slv_idex_rd_data1,
    ex_signext      => slv_idex_signext,
    ex_rt           => slv_idex_rt,
    ex_rd           => slv_idex_rd,
    ex_rs           => slv_idex_rs,
    
    id_ex_alusrc    => sl_decode_alusrc,
    id_ex_alucntrl  => slv_decode_alucntrl,
    id_ex_regdst    => sl_decode_regdst,
    id_me_branch    => sl_decode_branch,
    id_me_memwrite  => sl_decode_memwrite,
    id_me_memread   => sl_decode_memread,
    id_me_jump      => sl_decode_jump,
    id_me_jumpaddr  => slv_decode_jumpaddr,
    id_wb_regwrite  => sl_decode_regwrite,
    id_wb_memtoreg  => sl_decode_memtoreg,
    
    ex_ex_alusrc    => sl_idex_alusrc,
    ex_ex_alucntrl  => slv_idex_alucntrl,
    ex_ex_regdst    => sl_idex_regdst,
    ex_me_branch    => sl_idex_branch,
    ex_me_memwrite  => sl_idex_memwrite,
    ex_me_memread   => sl_idex_memread,
    ex_me_jump      => sl_idex_jump,
    ex_me_jumpaddr  => slv_idex_jumpaddr,
    ex_wb_regwrite  => sl_idex_regwrite,
    ex_wb_memtoreg  => sl_idex_memtoreg
);

i_execute: entity work.execute
port map(
	pc_in 			=> slv_idex_pc,
	pc_out			=> slv_execute_pc,
	pc_calc			=> slv_execute_pc_calc,
    jump_addr_in    => slv_idex_jumpaddr,
    jump_addr_out   => slv_execute_jumpaddr,
	rd_data0	    => slv_idex_rd_data0,
	rd_data1		=> slv_idex_rd_data1,
	sign_extend		=> slv_idex_signext,
	wr_data			=> slv_execute_wr_data,
	wr_addr         => slv_execute_wr_addr,
	rt              => slv_idex_rt,
	rs              => slv_idex_rs,
	rd              => slv_idex_rd,
	zero			=> sl_execute_zero,
	lt				=> sl_execute_lt,
	alu_result		=> slv_execute_alu_result,
	branch_in 		=> sl_idex_branch,
	jump_in			=> sl_idex_jump,
	memtoreg_in		=> sl_idex_memtoreg,
	alucntrl_in		=> slv_idex_alucntrl,
	memwrite_in		=> sl_idex_memwrite,
	alusrc_in		=> sl_idex_alusrc,
	regdst_in       => sl_idex_regdst,
	regwrite_in     => sl_idex_regwrite,
	branch			=> sl_execute_branch,
	jump			=> sl_execute_jump,
	memtoreg		=> sl_execute_memtoreg,
	memwrite        => sl_execute_memwrite,
	regwrite        => sl_execute_regwrite,
	-- forwarding
	memwb_rd_data  => slv_wb_wr_data,
	memwb_rd       => slv_memwb_wr_reg,
	memwb_regwr    => sl_memwb_regwrite,
	exmem_rd_data  => slv_exmem_wr_data,
	exmem_rd       => slv_exmem_wr_addr,
	exmem_regwr    => sl_exmem_regwrite
);

i_exmem: entity work.ex_mem
port map(
    clk             => clk,
    en              => '1',
    ex_pc           => slv_execute_pc,
    ex_pc_calc      => slv_execute_pc_calc,
    ex_zero         => sl_execute_zero,
    ex_lt           => sl_execute_lt,
    ex_alures       => slv_execute_alu_result,
    ex_wr_data      => slv_execute_wr_data,
    ex_wr_addr      => slv_execute_wr_addr,
    mem_pc          => slv_exmem_pc,
    mem_pc_calc     => slv_exmem_pc_calc,
    mem_zero        => sl_exmem_zero,
    mem_lt          => sl_exmem_lt,
    mem_alures      => slv_exmem_alures,
    mem_wr_data     => slv_exmem_wr_data,
    mem_wr_addr     => slv_exmem_wr_addr,
    ex_wb_regwrite  => sl_execute_regwrite,
    ex_wb_memtoreg  => sl_execute_memtoreg,
    ex_mem_branch   => sl_execute_branch,
    ex_mem_jump     => sl_execute_jump,
    ex_mem_jumpaddr => slv_execute_jumpaddr,
    ex_mem_memwrite => sl_execute_memwrite,
    mem_wb_regwrite => sl_exmem_regwrite,
    mem_wb_memtoreg => sl_exmem_memtoreg,
    mem_mem_branch  => sl_exmem_branch,
    mem_mem_jump    => sl_exmem_jump,
    mem_mem_jumpaddr=> slv_exmem_jumpaddr,
    mem_mem_memwrite=> sl_exmem_memwrite
);
    

i_memory_access: entity work.memory_access 
port map(
	clk 			=> clk,
	reset           => reset,
	jump_addr       => slv_exmem_jumpaddr,
	pc_in			=> slv_exmem_pc,
	pc_calc 		=> slv_exmem_pc_calc,
	pc_out			=> slv_fetch_pc_loadvalue,
	rd_data			=> slv_mem_rd_data,
	rd_alures       => slv_mem_rd_alures,
	zero			=>  sl_exmem_zero,
	lt				=>  sl_exmem_lt,
	alu_res			=> slv_exmem_alures,
	wr_data			=> slv_exmem_wr_data,    
	wr_addr         => slv_exmem_wr_addr,
	branch			=>  sl_exmem_branch,
	jump			=>  sl_exmem_jump,
	memtoreg		=>  sl_exmem_memtoreg,
	memwrite		=>  sl_exmem_memwrite,
	regwrite        =>  sl_exmem_regwrite,
	memwrite_out    =>  sl_mem_memwrite,
	memtoreg_out    =>  sl_mem_memtoreg,
	regwrite_out    =>  sl_mem_regwrite,
	jump_out		=>  sl_mem_jump,
	wr_addr_out     => slv_mem_wr_addr,
	led             => led
);

i_mem_wb: entity work.mem_wb
port map(
    clk             => clk,
    en              => '1',
    mem_rd_data     => slv_mem_rd_data,
    mem_alures      => slv_mem_rd_alures,
    mem_wr_reg      => slv_mem_wr_addr,
    wb_rd_data      => slv_memwb_rd_data,
    wb_alures       => slv_memwb_alures,
    wb_wr_reg       => slv_memwb_wr_reg,
    mem_wb_regwrite => sl_mem_regwrite,
    mem_wb_memtoreg => sl_mem_memtoreg,
    wb_wb_regwrite  => sl_memwb_regwrite,
    wb_wb_memtoreg  => sl_memwb_memtoreg 
);

i_wb: entity work.write_back
port map(
    memtoreg        =>  sl_memwb_memtoreg,
    rd_data         => slv_memwb_rd_data,
    alures          => slv_memwb_alures,
    addr_in         => slv_memwb_wr_reg,
    addr_out        => slv_wb_reg,
    wr_data         => slv_wb_wr_data
);

dataout <= slv_wb_wr_data;

end architecture structural;
