vlib work

vcom -93 -explicit mem_pkg.vhd
vcom -93 -explicit instr_mem.vhd
vcom -93 -explicit tb_instr_mem.vhd

vsim -novopt work.tb_instr_mem

add wave sim:/tb_instr_mem/dut/*

run 50 ns
