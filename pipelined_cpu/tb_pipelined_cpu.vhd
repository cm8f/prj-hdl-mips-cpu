----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/06/2016 12:54:14 PM
-- Design Name: 
-- Module Name: tb_pipelined_cpu - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_pipelined_cpu is
--  Port ( );
end tb_pipelined_cpu;

architecture Behavioral of tb_pipelined_cpu is

signal clk  : std_logic := '1';
signal reset: std_logic := '1';
signal dataout : std_logic_vector(31 downto 0);
signal led  : std_logic_vector(31 downto 0);

constant period : time := 10 ns;

begin


clk <= not clk after period/2;

do_reset: process
    begin
        reset <= '1';
        wait for 5*period;
        reset <= '0';
        wait;
    end process do_reset;


dut: entity work.pipelined_cpu
    port map(
        clk => clk,
        reset => reset,
        dataout => dataout,
        led => led
    );
    
   

end Behavioral;
