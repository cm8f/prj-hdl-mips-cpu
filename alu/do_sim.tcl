vlib work

vcom -93 alu.vhd
vcom -93 tb_alu.vhd 

vsim -novopt work.tb_alu

add wave sim:/tb_alu/dut/*

run 100 ns
