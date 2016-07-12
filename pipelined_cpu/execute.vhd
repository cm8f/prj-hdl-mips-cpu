library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity execute is
	port(
		pc_in 		  : in  std_logic_vector(31 downto 0);
		pc_out		  : out std_logic_vector(31 downto 0);
		pc_calc       : out std_logic_vector(31 downto 0);
        jump_addr_in  : in  std_logic_vector(31 downto 0);
        jump_addr_out : out std_logic_vector(31 downto 0);
		rd_data0      : in  std_logic_vector(31 downto 0);
		rd_data1      : in  std_logic_vector(31 downto 0);
		sign_extend	  : in  std_logic_vector(31 downto 0);
		wr_data       : out std_logic_vector(31 downto 0);
		wr_addr       : out std_logic_vector(4 downto 0); 
		rt            : in  std_logic_vector(4 downto 0);
		rs            : in  std_logic_vector(4 downto 0);
		rd            : in  std_logic_vector(4 downto 0);
		-- alu
		zero          : out std_logic;
		lt            : out std_logic;
		alu_result	  : out std_logic_vector(31 downto 0);
		-- control in
		branch_in     : in std_logic;
		jump_in       : in std_logic;
		memtoreg_in	  : in std_logic;
		alucntrl_in	  : in std_logic_vector(3 downto 0);
		memwrite_in	  : in std_logic;
		alusrc_in	  : in std_logic;
		regdst_in     : in std_logic;
		regwrite_in   : in std_logic;
		-- control out
		branch        : out std_logic;
		regwrite      : out std_logic;
		jump          : out std_logic;
		memtoreg      : out std_logic;
		memwrite      : out std_logic;
		-- forwarding
		--forwardA      : in  std_logic_vector(1 downto 0);
		--forwardB      : in  std_logic_vector(1 downto 0);
		memwb_rd_data : in  std_logic_vector(31 downto 0);
		memwb_rd      : in  std_logic_vector(4 downto 0);
		memwb_regwr   : in  std_logic;
		exmem_rd_data : in  std_logic_vector(31 downto 0);
        exmem_rd      : in  std_logic_vector(4 downto 0);
        exmem_regwr   : in  std_logic
	);
end entity execute;

architecture mixed of execute is

signal slv_b                : std_logic_vector(31 downto 0);
signal slv_a                : std_logic_vector(31 downto 0);
signal slv_intermediate_b   : std_logic_vector(31 downto 0);

signal slv_forwardA      : std_logic_vector(1 downto 0);
signal slv_forwardB      : std_logic_vector(1 downto 0);

begin

jump_addr_out <= jump_addr_in;

regwrite <= regwrite_in;
branch 	<= branch_in;
jump   	<= jump_in;
memtoreg <= memtoreg_in;
memwrite <= memwrite_in;

wr_data <= rd_data1;

with slv_forwardB select slv_intermediate_b <= rd_data1 when "00",
                                           memwb_rd_data when "01",
                                           exmem_rd_data when "10",
                                           (others => '0') when others;
                                           
with slv_forwardA select slv_a  <=  rd_data0 when "00",
                                memwb_rd_data when "01",
                                exmem_rd_data when "10",
                                (others => '0') when others;
                                           

--with alusrc_in select slv_b <= rd_data1 when '0', 
with alusrc_in select slv_b <= slv_intermediate_b when '0', 
										 sign_extend when others;
										 
with regdst_in select wr_addr <= rt when '0',
                                rd when others;

pc_out <= pc_in;
pc_calc <= std_logic_vector(shift_left(signed(sign_extend), 2) +  signed(pc_in));

alu_0: entity work.alu
port map(
	a => slv_a,
	b => slv_b,
	opcode => alucntrl_in,
	o => alu_result,
	lessthan => lt,
	zero => zero
);

forwarding_0: entity work.forwarding_unit
port map(
    rs          => rs,
    rt          => rt,
    exmem_rd    => exmem_rd,
    exmem_regwr => exmem_regwr,
    memwb_rd    => memwb_rd,
    memwb_regwr => memwb_regwr,
    forwardA    => slv_forwardA,
    forwardB    => slv_forwardB
);

end architecture mixed;
