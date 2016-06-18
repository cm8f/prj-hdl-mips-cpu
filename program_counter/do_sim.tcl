vlib work

vcom -93 pc.vhd 
vcom -93 pc_tb.vhd

vsim -novopt work.pc_tb

add wave sim:/pc_tb/dut/*

