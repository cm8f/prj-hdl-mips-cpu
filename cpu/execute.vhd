library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity execute is
	port(
		pc_in 		: in  std_logic_vector(31 downto 0);
		pc_out		: out std_logic_vector(31 downto 0);
		pc_calc		: out std_logic_vector(31 downto 0);
		rd_data0		: in  std_logic_vector(31 downto 0);
		rd_data1		: in  std_logic_vector(31 downto 0);
		sign_extend	: in  std_logic_vector(31 downto 0);
		wr_data		: out std_logic_vector(31 downto 0);
		-- alu
		zero			: out std_logic;
		lt				: out std_logic;
		alu_result	: out std_logic_vector(31 downto 0);
		-- control in
		branch_in	: in std_logic;
		jump_in		: in std_logic;
		memtoreg_in	: in std_logic;
		alucntrl_in	: in std_logic_vector(3 downto 0);
		memwrite_in	: in std_logic;
		alusrc_in	: in std_logic;
		-- control out
		branch 		: out std_logic;
		jump			: out std_logic;
		memtoreg		: out std_logic;
		memwrite		: out std_logic
		
	);
end entity execute;

architecture mixed of execute is

signal slv_b : std_logic_vector(31 downto 0);

begin

branch 	<= branch_in;
jump   	<= jump_in;
memtoreg <= memtoreg_in;
memwrite <= memwrite_in;

wr_data <= rd_data1;

with alusrc_in select slv_b <= rd_data1 when '0',
										 sign_extend when others;

pc_out <= pc_in;
pc_calc <= std_logic_vector(shift_left(signed(sign_extend), 2) +  signed(pc_in));

alu_0: entity work.alu
port map(
	a => rd_data0,
	b => slv_b,
	opcode => alucntrl_in,
	o => alu_result,
	lessthan => lt,
	zero => zero
);

end architecture mixed;