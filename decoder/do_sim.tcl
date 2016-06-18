vlib work;

vcom -93 -explicit decoder.vhd
vcom -93 -explicit tb_decoder.vhd

vsim -novopt work.tb_decoder

add wave sim:/tb_decoder/dut/*

run 150 ns;
