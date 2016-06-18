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

add wave -divider intern_control
add wave -label opcode                              $dut/i_decode/decode_0/opcode
add wave -label func                                $dut/i_decode/decode_0/func
add wave -label regdst                              $dut/i_decode/decode_0/regdst
add wave -label jump                                $dut/i_decode/decode_0/jump
add wave -label branch                              $dut/i_decode/decode_0/branch
add wave -label memtoreg                            $dut/i_decode/decode_0/memtoreg
add wave -label alucntrl                            $dut/i_decode/decode_0/alucntrl
add wave -label memwrite                            $dut/i_decode/decode_0/memwrite
add wave -label alusrc                              $dut/i_decode/decode_0/alusrc
add wave -label regwrite                            $dut/i_decode/decode_0/regwrite

add wave -divider fetch
add wave -label in_jump                             $dut/sl_jump
add wave -label in_pcnext       -radix hexadecimal  $dut/slv_fetch_pc_loadvalue
add wave -label out_pc          -radix hexadecimal  $dut/slv_fetch_pc
add wave -label out_instruction -radix hexadecimal  $dut/slv_fetch_instruction

add wave -divider decode
add wave -label rd_data0        -radix hexadecimal  $dut/slv_decode_rd_data0
add wave -label rd_data1        -radix hexadecimal  $dut/slv_decode_rd_data1
add wave -label sign_extend     -radix hexadecimal  $dut/slv_decode_sign_extend
add wave -label wr_data         -radix hexadecimal  $dut/slv_decode_wr_data
add wave -label branch                              $dut/sl_decode_branch
add wave -label jump                                $dut/sl_decode_jump
add wave -label memtoreg                            $dut/sl_decode_memtoreg 
add wave -label alucntrl                            $dut/sl_decode_alusrc
add wave -label memwrite                            $dut/sl_decode_memwrite
add wave -label alusrc                              $dut/sl_decode_alusrc

add wave -divider execute
add wave -label pc_out          -radix hexadecimal  $dut/slv_execute_pc
add wave -label pc_calc         -radix hexadecimal  $dut/slv_execute_pc_calc
add wave -label wr_data         -radix hexadecimal  $dut/slv_execute_wr_data
add wave -label zero                                $dut/sl_execute_zero
add wave -label lt                                  $dut/sl_execute_lt
add wave -label alures          -radix hexadecimal  $dut/slv_execute_alu_result

add wave -divider mem

run 200 ns
