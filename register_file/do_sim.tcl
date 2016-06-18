vlib work

vcom -93 regfile.vhd 
vcom -93 regfile_tb.vhd

vsim -novopt work.regfile_tb

add wave sim:/regfile_tb/dut/*

run 1 us
