set base    ../..
set pcpath  $base/program_counter
set regpath $base/register_file
set mempath $base/daten_instruktionsspeicher
set alupath $base/alu
set decpath $base/decoder
set cpupath $base/cpu


set lib work

vlib $lib

set flags   "-93 -explicit -work $lib"

set com "vcom $flags $pcpath/pc.vhd"; eval $com

set com "vcom $flags $regpath/regfile.vhd"; eval $com

set com "vcom $flags $mempath/mem_pkg.vhd"; eval $com
set com "vcom $flags $mempath/data_mem.vhd"; eval $com
set com "vcom $flags $mempath/instr_mem.vhd"; eval $com

set com "vcom $flags $alupath/alu.vhd"; eval $com

set com "vcom $flags $decpath/decoder.vhd"; eval $com

set com "vcom $flags $cpupath/fetch.vhd"; eval $com
set com "vcom $flags $cpupath/instruction_decode.vhd"; eval $com
set com "vcom $flags $cpupath/execute.vhd"; eval $com
set com "vcom $flags $cpupath/memory_access.vhd"; eval $com
set com "vcom $flags $cpupath/single_cycle_cpu.vhd"; eval $com
set com "vcom $flags $cpupath/tb_single_cycle_cpu.vhd"; eval $com

vsim $lib.tb_single_cycle_cpu


# create wave

set dut sim:/tb_single_cycle_cpu/dut

add wave -label clk                         $dut/clk
add wave -label reset                       $dut/reset
add wave -label dataout -radix hexadecimal  $dut/dataout

add wave -divider fetch
add wave -radix hexadecimal $dut/i_fetch/*

add wave -divider decode
add wave -radix hexadecimal $dut/i_decode/*

add wave -divider execute
add wave -radix hexadecimal $dut/i_execute/*

add wave -divider mem_wb
add wave -radix hexadecimal $dut/i_memory_access_and_write_back/*

run 200 ns
