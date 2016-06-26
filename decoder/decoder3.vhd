library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- TODO lui mit abgedeckt?

entity decoder3 is
port(
	opcode		: in  std_logic_vector(5 downto 0);
	func		: in  std_logic_vector(5 downto 0);
	RegDst		: out std_logic; -- 
	Jump		: out std_logic; -- v
	Branch		: out std_logic; -- v
	MemtoReg	: out std_logic; -- v
	ALUCntrl	: out std_logic_vector(3 downto 0); -- v
	MemWrite	: out std_logic; -- v
	ALUSrc		: out std_logic; -- v
	RegWrite	: out std_logic	 -- v
);
end entity decoder3;

architecture behavioral of decoder3 is


signal slv_op_func  : std_logic_vector(15 downto 0);
signal slv_opcode   : std_logic_vector(7 downto 0);
signal slv_func     : std_logic_vector(7 downto 0);
begin

slv_func    <= "00" & func;
slv_opcode  <= "00" & opcode; 
slv_op_func <= slv_opcode & slv_func;

process(slv_op_func)
begin
    case(slv_op_func) is
    when x"0024" => ALUCntrl <= "0000";  -- r-type and
    when x"0025" => ALUCntrl <= "0001";  -- r-type or
    when x"0020" => ALUCntrl <= "0010";  -- r-type add
    when "00001111--------" => ALUCntrl <= "0100";  -- i-type lui
    when x"0026" => ALUCntrl <= "0101";  -- r-type xor
    when x"0022" => ALUCntrl <= "0110";  -- r-type sub
    when x"002a" => ALUCntrl <= "0111";  -- r-type slt
    when x"0027" => ALUCntrl <= "1100";  -- r-type nor
    when "00001000--------" => ALUCntrl <= "0010";  -- i-type addi
    when "00000100--------" => ALUCntrl <= "0110";  -- i-type beq
    when "00100011--------" => ALUCntrl <= "0010";  -- i-type lw
    when "00101011--------" => ALUCntrl <= "0010";  -- i-type sw
    when others => ALUCntrl <= "1111"; 
    end case;
end process;

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

with slv_opcode select regdst <= '0' when x"23",
                    '1' when others;

end architecture behavioral;
