library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- TODO lui mit abgedeckt?

entity decoder is
port(
	opcode		: in  std_logic_vector(5 downto 0);
	func		: in  std_logic_vector(5 downto 0);
	RegDst		: out std_logic; -- v
	Jump		: out std_logic; -- v
	Branch		: out std_logic; -- v
	MemtoReg	: out std_logic; -- v
	ALUCntrl	: out std_logic_vector(3 downto 0); -- v
	MemWrite	: out std_logic; -- v
	ALUSrc		: out std_logic; -- v
	RegWrite	: out std_logic	-- v
);
end entity decoder;

architecture behavioral of decoder is

    signal slv_regdst       : std_logic;
    signal slv_mem2reg      : std_logic;
    signal slv_writemem     : std_logic;
    signal slv_branch       : std_logic;

    signal slv_opALU        : std_logic_vector(1 downto 0);

begin


    slv_RegDst      <= and_reduce(not opcode);
    slv_mem2reg     <=     opcode(5) and not opcode(4) and not opcode(3) and not opcode(2) and      opcode(1) and     opcode(0);
    slv_writemem    <=     opcode(5) and not opcode(4) and     opcode(3) and not opcode(2) and      opcode(1) and     opcode(0);
    slv_branch      <= not opcode(5) and not opcode(4) and not opcode(3) and     opcode(2) and  not opcode(1) and not opcode(0);

    regdst      <= slv_regdst;
    alusrc      <= slv_mem2reg or slv_writemem;
    memtoreg    <= slv_mem2reg;
    RegWrite    <= slv_regdst or slv_mem2reg;
    MemWrite    <= slv_writemem;
    Branch      <= slv_branch;

    slv_opALU   <= slv_regdst & slv_branch;


end architecture behavioral;
