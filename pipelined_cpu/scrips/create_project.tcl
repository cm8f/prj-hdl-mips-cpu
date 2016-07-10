#
# Vivado (TM) v2015.2 (64-bit)
#
# create_project.tcl: Tcl script for re-creating project 'pipelined_cpu'
#
# Generated by Vivado on Sat Jul 02 16:16:23 CEST 2016
# IP Build 1264090 on Wed Jun 24 14:22:01 MDT 2015
#
# This file contains the Vivado Tcl commands for re-creating the project to the state*
# when this script was generated. In order to re-create the project, please source this
# file in the Vivado Tcl Shell.
#
# * Note that the runs in the created project will be configured the same way as the
#   original project, however they will not be launched automatically. To regenerate the
#   run results please launch the synthesis/implementation runs as needed.
#
#*****************************************************************************************
# NOTE: In order to use this script for source control purposes, please make sure that the
#       following files are added to the source control system:-
#
# 1. This project restoration tcl script (create_project.tcl) that was generated.
#
# 2. The following source(s) files that were local or imported into the original project.
#    (Please see the '$orig_proj_dir' and '$origin_dir' variable setting below at the start of the script)
#
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/daten_instruktionsspeicher/mem_pkg.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/daten_instruktionsspeicher/hw_reg.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/daten_instruktionsspeicher/data_mem.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/alu/alu.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/register_file/regfile.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/decoder/decoder.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/program_counter/pc.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/daten_instruktionsspeicher/instr_mem.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/pipelined_cpu/memory_access.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/pipeline/ex_mem.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/pipelined_cpu/execute.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/pipeline/id_ex.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/pipelined_cpu/instruction_decode.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/pipeline/if_id.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/pipelined_cpu/fetch.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/pipelined_cpu/pipelined_cpu.vhd"
#    "/home/phil/Documents/uni/master/3_SS16/CPU/Ubungen/cpu_entwurf/pipeline/mem_wb.vhd"
#
# 3. The following remote source files that were added to the original project:-
#
#    <none>
#
#*****************************************************************************************

# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/../../work_vivado/pipelined_cpu"]"

# Create project
create_project pipelined_cpu ./pipelined_cpu

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [get_projects pipelined_cpu]
set_property "board_part" "em.avnet.com:zed:part0:1.3" $obj
set_property "default_lib" "xil_defaultlib" $obj
set_property "simulator_language" "Mixed" $obj
set_property "target_language" "VHDL" $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "[file normalize "$origin_dir/../../daten_instruktionsspeicher/mem_pkg.vhd"]"\
 "[file normalize "$origin_dir/../../daten_instruktionsspeicher/hw_reg.vhd"]"\
 "[file normalize "$origin_dir/../../daten_instruktionsspeicher/data_mem.vhd"]"\
 "[file normalize "$origin_dir/../../alu/alu.vhd"]"\
 "[file normalize "$origin_dir/../../register_file/regfile.vhd"]"\
 "[file normalize "$origin_dir/../../decoder/decoder.vhd"]"\
 "[file normalize "$origin_dir/../../program_counter/pc.vhd"]"\
 "[file normalize "$origin_dir/../../daten_instruktionsspeicher/instr_mem.vhd"]"\
 "[file normalize "$origin_dir/../memory_access.vhd"]"\
 "[file normalize "$origin_dir/../../pipeline/ex_mem.vhd"]"\
 "[file normalize "$origin_dir/../execute.vhd"]"\
 "[file normalize "$origin_dir/../../pipeline/id_ex.vhd"]"\
 "[file normalize "$origin_dir/../instruction_decode.vhd"]"\
 "[file normalize "$origin_dir/../../pipeline/if_id.vhd"]"\
 "[file normalize "$origin_dir/../fetch.vhd"]"\
 "[file normalize "$origin_dir/../pipelined_cpu.vhd"]"\
 "[file normalize "$origin_dir/../../pipeline/mem_wb.vhd"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
# None

# Set 'sources_1' fileset file properties for local files
set file "daten_instruktionsspeicher/mem_pkg.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "daten_instruktionsspeicher/hw_reg.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "daten_instruktionsspeicher/data_mem.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "alu/alu.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "register_file/regfile.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "decoder/decoder.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "program_counter/pc.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "daten_instruktionsspeicher/instr_mem.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "pipelined_cpu/memory_access.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "pipeline/ex_mem.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "pipelined_cpu/execute.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "pipeline/id_ex.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "pipelined_cpu/instruction_decode.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "pipeline/if_id.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "pipelined_cpu/fetch.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "pipelined_cpu/pipelined_cpu.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "pipeline/mem_wb.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj


# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property "top" "pipelined_cpu" $obj

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Empty (no sources present)

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
# Empty (no sources present)

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property "top" "pipelined_cpu" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
  create_run -name synth_1 -part xc7z020clg484-1 -flow {Vivado Synthesis 2015} -strategy "Vivado Synthesis Defaults" -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2015" [get_runs synth_1]
}
set obj [get_runs synth_1]

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
  create_run -name impl_1 -part xc7z020clg484-1 -flow {Vivado Implementation 2015} -strategy "Vivado Implementation Defaults" -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2015" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property "steps.write_bitstream.args.readback_file" "0" $obj
set_property "steps.write_bitstream.args.verbose" "0" $obj

# set the current impl run
current_run -implementation [get_runs impl_1]

puts "INFO: Project created:pipelined_cpu"
