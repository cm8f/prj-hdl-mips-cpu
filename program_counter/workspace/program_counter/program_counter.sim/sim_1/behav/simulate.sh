#!/bin/bash -f
xv_path="/opt/Xilinx/Vivado/2015.3"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim pc_tb_behav -key {Behavioral:sim_1:Functional:pc_tb} -tclbatch pc_tb.tcl -view /home/yn38iluz/Documents/program_counter/workspace/program_counter/pc_tb_behav.wcfg -log simulate.log
