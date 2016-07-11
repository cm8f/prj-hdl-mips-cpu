vlib work

set flags "-93 -explicit" 

eval "vcom $flags hazard_detection.vhd"
eval "vcom $flags tb_hazard_detection.vhd"

vsim work.tb_hazard_detection

add wave sim:/tb_hazard_detection/dut/*

run 100 ns;
