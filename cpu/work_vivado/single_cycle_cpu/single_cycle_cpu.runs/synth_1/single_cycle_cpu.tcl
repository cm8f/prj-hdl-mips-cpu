# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z020clg484-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/phil/cpu_entwurf/cpu/work_vivado/single_cycle_cpu/single_cycle_cpu.cache/wt [current_project]
set_property parent.project_path /home/phil/cpu_entwurf/cpu/work_vivado/single_cycle_cpu/single_cycle_cpu.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
read_vhdl -library xil_defaultlib {
  /home/phil/cpu_entwurf/daten_instruktionsspeicher/mem_pkg.vhd
  /home/phil/cpu_entwurf/alu/alu.vhd
  /home/phil/cpu_entwurf/decoder/decoder.vhd
  /home/phil/cpu_entwurf/register_file/regfile.vhd
  /home/phil/cpu_entwurf/program_counter/pc.vhd
  /home/phil/cpu_entwurf/daten_instruktionsspeicher/data_mem.vhd
  /home/phil/cpu_entwurf/daten_instruktionsspeicher/instr_mem.vhd
  /home/phil/cpu_entwurf/cpu/memory_access.vhd
  /home/phil/cpu_entwurf/cpu/execute.vhd
  /home/phil/cpu_entwurf/cpu/instruction_decode.vhd
  /home/phil/cpu_entwurf/cpu/fetch.vhd
  /home/phil/cpu_entwurf/cpu/single_cycle_cpu.vhd
}
synth_design -top single_cycle_cpu -part xc7z020clg484-1
write_checkpoint -noxdef single_cycle_cpu.dcp
catch { report_utilization -file single_cycle_cpu_utilization_synth.rpt -pb single_cycle_cpu_utilization_synth.pb }
