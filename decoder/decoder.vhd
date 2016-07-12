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
	MemRead     : out std_logic;
	ALUSrc		: out std_logic; -- v
	RegWrite	: out std_logic	-- v
);
end entity decoder;

architecture behavioral of decoder is

signal slv_alu	  : std_logic_vector(3 downto 0);

signal slv_opcode 	: std_logic_vector(7 downto 0);
signal slv_func		: std_logic_vector(7 downto 0);

begin

slv_opcode <= "00" & opcode;
slv_func   <= "00" & func;

ALUCntrl <= slv_alu;

alu_decode: process(slv_opcode, slv_func)
begin
	case(slv_opcode) is
	when x"00" =>
		--case(slv_func) is
		if slv_func = x"24" then
			slv_alu <= "0000";	-- AND
		elsif slv_func = x"25" then
			slv_alu <= "0001";	-- OR
		elsif slv_func = x"20" then
			slv_alu <= "0010";	-- ADD
		elsif slv_func = x"26" then
			slv_alu <= "0101";	-- XOR
		elsif slv_func = x"22" then
			slv_alu <= "0110";	-- SUB
		elsif slv_func = x"2a" then
			slv_alu <= "0111";	-- SLT
		elsif slv_func = x"27" then
			slv_alu <= "1100";	-- NOR
		else 
			slv_alu <= "0000";	-- undefined? do nothing
		end if;	
	when x"0f" =>			-- LUI
		slv_alu <= "0100";
	when x"08" => 			-- ADDI
		slv_alu <= "0010";	
	when x"04" =>			-- BEQ
		slv_alu <= "0110";
	when x"23" =>			-- LW
		slv_alu <= "0010";
	when x"2b" =>			-- SW
		slv_alu <= "0010";
	when others => 			-- undefined
		slv_alu <= "1111";
	end case;
end process alu_decode;

-- branch
--with slv_opcode select Branch <= '1' when x"04", 
--					   			 '0' when others;

-- memwrite
--with slv_opcode select MemWrite <= 	'1' when x"2b",
--								   	'0' when others;

-- memread ignored

-- regwrite
--with slv_opcode select RegWrite <=  '0' when x"2b",
--									'0' when x"04",
--									'1' when others;

-- mem2reg
--with slv_opcode select MemtoReg <=  '0' when x"00",
--									'1' when others; 

-- alusrc
--with slv_opcode select ALUSrc <= 	'1' when x"23",
--									'1' when x"2b",
--									'0' when others;

-- regdest
--with slv_opcode select RegDst <= 	'0' when x"23",
--									'1' when others;

-- jump
--with slv_opcode select Jump <= 		'1' when x"02",
--									'0' when others;


with slv_opcode select memread <= '1' when x"23",
                        '0' when others;

with slv_opcode select jump <= '1' when x"02",
                   '0' when others;

with slv_opcode select branch <= '1' when x"04",
                    '0' when others;
                    
with slv_opcode select memwrite <= '1' when x"2b", 
                    '0' when others;
                    
with slv_opcode select regwrite <= '0' when x"04",
                    '0' when x"2b",
                    '1' when others;

with slv_opcode select memtoreg <= '1' when x"2b",
                    '0' when others;

with slv_opcode select alusrc <= '0' when x"00",
                    '0' when x"04",
                    '1' when others; 

--with slv_opcode select regdst <= '0' when x"23",
--                    '1' when others;
with slv_opcode select regdst <= '0' when x"23",
                    '0' when x"0f",
                    '0' when x"08",
                    '1' when others;

end architecture behavioral;
