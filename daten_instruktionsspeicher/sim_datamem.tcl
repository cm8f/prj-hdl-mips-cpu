vlib work

vcom -93 -explicit mem_pkg.vhd
vcom -93 -explicit data_mem.vhd
vcom -93 -explicit tb_data_mem.vhd

vsim -novopt work.tb_data_mem

add wave sim:/tb_data_mem/dut/*

run 100 ns;
