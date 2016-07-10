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
        rd          : out std_logic_vector( 4 downto 0);
        i_regwrite  : in  std_logic;
		-- control
		branch		: out std_logic;
		jump		: out std_logic;
		memtoreg	: out std_logic;
		alucntrl	: out std_logic_vector(3 downto 0);
		memwrite	: out std_logic;
		alusrc		: out std_logic;
		regdst      : out std_logic;
		regwrite    : out std_logic
	);
end entity instruction_decode;

architecture structural of instruction_decode is

signal slv_rd_addr0  : std_logic_vector(4 downto 0);
signal slv_rd_addr1  : std_logic_vector(4 downto 0);
signal slv_wr_addr   : std_logic_vector(4 downto 0);

signal sl_regwrite  	: std_logic;
signal sl_regdst		: std_logic;

signal slv_opcode 	: std_logic_vector(5 downto 0);
signal slv_func		: std_logic_vector(5 downto 0);

begin 

pc_out <= pc_in;

sign_extend <= std_logic_vector(resize(signed(instruction(15 downto 0)), 32)); 

slv_rd_addr0 <= instruction(25 downto 21);
slv_rd_addr1 <= instruction(20 downto 16);

jump_addr <= pc_in(31 downto 28) & instruction(25 downto 0)& "00";

regwrite <= sl_regwrite;
regdst <= sl_regdst;
rt <= instruction(20 downto 16);
rd <= instruction(15 downto 11);

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
		opcode => slv_opcode,
		func => slv_func,
		regdst => sl_regdst, 
		jump => jump,
		branch => branch,
		memtoreg => memtoreg,
		alucntrl => alucntrl,
		memwrite => memwrite,
		alusrc => alusrc,
		regwrite => sl_regwrite
	);

end architecture structural;
