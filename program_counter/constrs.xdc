create_clock -period 20.00 [get_ports clk];
set_property PACKAGE_PIN Y9 [get_ports clk];

set_property PACKAGE_PIN T22 [get_ports pc_out[0]];
set_property PACKAGE_PIN T21 [get_ports pc_out[1]];
set_property PACKAGE_PIN U22 [get_ports pc_out[2]];
set_property PACKAGE_PIN U21 [get_ports pc_out[3]];
set_property PACKAGE_PIN V22 [get_ports pc_out[4]];
set_property PACKAGE_PIN W22 [get_ports pc_out[5]];
set_property PACKAGE_PIN U19 [get_ports pc_out[6]];
set_property PACKAGE_PIN U14 [get_ports pc_out[7]];

set_property PACKAGE_PIN F22 [get_ports reset];
set_property PACKAGE_PIN G22 [get_ports en];

set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];
#set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 35]];
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];