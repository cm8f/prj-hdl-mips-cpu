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
ExecStep $xv_path/bin/xelab -wto d8ffd5113263475d9de58fe2ea14e98b -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot pc_tb_behav xil_defaultlib.pc_tb -log elaborate.log
