vlib work

set flags "-93 -explicit" 

eval "vcom $flags forwarding_unit.vhd"
eval "vcom $flags tb_forwarding.vhd"

vsim -novopt work.tb_forwarding 

add wave sim:/tb_forwarding/dut/*

run 100 ns
