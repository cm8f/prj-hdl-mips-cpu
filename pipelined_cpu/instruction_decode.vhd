library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

entity instruction_decode is
	port(
		clk 		: in  std_logic;
		reset 		: in  std_logic;
		pc_in		: in  std_logic_vector(31 downto 0);
		pc_out		: out std_logic_vector(31 downto 0);
		instruction : in  std_logic_vector(31 downto 0);
		rd_data0 	: out std_logic_vector(31 downto 0);
		rd_data1	: out std_logic_vector(31 downto 0);
		sign_extend : out std_logic_vector(31 downto 0);
        wr_addr     : in  std_logic_vector( 4 downto 0);   
		wr_data     : in  std_logic_vector(31 downto 0);
        jump_addr   : out std_logic_vector(31 downto 0);
        rt          : out std_logic_vector( 4 downto 0);
        rs          : out std_logic_vector( 4 downto 0);
        rd          : out std_logic_vector( 4 downto 0);
        i_regwrite  : in  std_logic;
		-- control
		branch		: out std_logic;
		jump		: out std_logic;
		memtoreg	: out std_logic;
		alucntrl	: out std_logic_vector(3 downto 0);
		memwrite	: out std_logic;
		memread     : out std_logic;
		alusrc		: out std_logic;
		regdst      : out std_logic;
		regwrite    : out std_logic;
		-- hazard detection
		idex_memread  : in  std_logic;
		idex_rt       : in  std_logic_vector(4 downto 0);
		ifid_rs       : in  std_logic_vector(4 downto 0);
		ifid_rt       : in  std_logic_vector(4 downto 0);
		pcwrite       : out std_logic;
		ifidwrite     : out std_logic
	);
end entity instruction_decode;

architecture structural of instruction_decode is

signal slv_rd_addr0  : std_logic_vector(4 downto 0);
signal slv_rd_addr1  : std_logic_vector(4 downto 0);
signal slv_wr_addr   : std_logic_vector(4 downto 0);

signal sl_memread       : std_logic;
signal sl_branch        : std_logic;
signal sl_jump          : std_logic;
signal sl_memtoreg      : std_logic;
signal slv_alucntrl     : std_logic_vector(3 downto 0);
signal sl_memwrite      : std_logic;
signal sl_alusrc        : std_logic;
signal sl_regdst		: std_logic;
signal sl_regwrite  	: std_logic;

signal slv_opcode 	: std_logic_vector(5 downto 0);
signal slv_func		: std_logic_vector(5 downto 0);

-- hazard
signal sl_control_muxsel : std_logic;

signal slv_concat_cntrl : std_logic_vector(11 downto 0);

begin 

-- hazard
memread     <= slv_concat_cntrl(11);
branch      <= slv_concat_cntrl(10);
jump        <= slv_concat_cntrl(9);
memtoreg    <= slv_concat_cntrl(8);
alucntrl    <= slv_concat_cntrl(7 downto 4);
memwrite    <= slv_concat_cntrl(3);
alusrc      <= slv_concat_cntrl(2);
regdst      <= slv_concat_cntrl(1);
regwrite    <= slv_concat_cntrl(0);

with sl_control_muxsel select slv_concat_cntrl <= (others => '0') when '1',
    (sl_memread & sl_branch & sl_jump & sl_memtoreg & slv_alucntrl & sl_memwrite & 
    sl_alusrc & sl_regdst & sl_regwrite) when others;
                                

pc_out <= pc_in;

sign_extend <= std_logic_vector(resize(signed(instruction(15 downto 0)), 32)); 

slv_rd_addr0 <= instruction(25 downto 21);
slv_rd_addr1 <= instruction(20 downto 16);

jump_addr <= pc_in(31 downto 28) & instruction(25 downto 0)& "00";

--regwrite <= sl_regwrite;
--regdst <= sl_regdst;
rt <= instruction(20 downto 16);
rd <= instruction(15 downto 11);
rs <= instruction(25 downto 21);

--with sl_regdst select slv_wr_addr <= 
--						instruction(20 downto 16) when '0',
--						instruction(15 downto 11) when others;

regfile_0: entity work.regfile 
port map(
	clk => clk,
	reset => reset,
	rd_addr0 => slv_rd_addr0,
	rd_addr1 => slv_rd_addr1,
	wr_addr  => wr_addr,
	wr_ena   => i_regwrite,
	wr_data 	=> wr_data,
	rd_data0 => rd_data0,
	rd_data1 => rd_data1
);

slv_opcode <= instruction(31 downto 26);
slv_func   <= instruction( 5 downto  0);

decode_0: entity work.decoder
	port map(
		opcode    => slv_opcode,
		func      => slv_func,
		regdst    => sl_regdst, 
		jump      => sl_jump,
		branch    => sl_branch,
		memtoreg  => sl_memtoreg,
		alucntrl  => slv_alucntrl,
		memwrite  => sl_memwrite,
		memread   => sl_memread,
		alusrc    => sl_alusrc,
		regwrite  => sl_regwrite
	);

hazard_0: entity work.hazard_detection
    port map(
        idex_memread    => idex_memread,
        idex_rt         => idex_rt,
        ifid_rs         => ifid_rs,
        ifid_rt         => ifid_rt,
        pcwrite         => pcwrite,
        ifidwrite       => ifidwrite,
        controlmuxsel   => sl_control_muxsel
    );

end architecture structural;
