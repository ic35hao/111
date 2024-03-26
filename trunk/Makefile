export proj_root=$(PWD)
ip_name = axi_xbar
ip_name = u500_top
export SCRATCH_PATH=$(proj_root)/scratch/${GIT_VERSION}/$(ip_name)-sim-vcs

pl = UVM_DEBUG
uvm_test = $(ip_name)_base_test
uvm_test_seq = $(ip_name)_base_vseq
seed = 111
wave = fsdb
post_build_cmds=
pre_build_cmds=
rom=bootrom/bootrom
ram=case/test_demo
export build_cmd=vcs
export build_dir=$(SCRATCH_PATH)/default
export sv_flist_gen_cmd=fusesoc 
export sv_flist_gen_dir=$(SCRATCH_PATH)/default/sim-vcs 
export sv_flist_gen_opts=--cores-root $(proj_root) run --flag=fileset_ip --target=sim --build-root=$(build_dir) --setup lowrisc:dv:$(ip_name)_sim:0.1
# --std=c99  -fno-extended-identifiers 
# +define+PRINTF_CORE_INFO
export build_opts=+define+UVM +define+UVM_NO_DEPRECATED +define+UVM_REGEX_NO_DPI +define+UVM_REG_ADDR_WIDTH=32 +define+UVM_REG_DATA_WIDTH=32 +define+UVM_REG_BYTENABLE_WIDTH=4 +define+SIMULATION -sverilog -full64 -licqueue -kdb -ntb_opts uvm-1.2 -timescale=1ns/1ps -Mdir=$(build_dir)/simv.csrc -o $(build_dir)/simv -f $(build_dir)/sim-vcs/lowrisc_dv_$(ip_name)_sim_0.1.scr -lca -top tb +incdir+$(build_dir) +warn=SV-NFIVC +warn=noUII-L +warn=noLCA_FEATURES_ENABLED -assert svaext -xlrm uniq_prior_final -CFLAGS --std=c++11 -LDFLAGS -Wl,--no-as-needed -debug_access+f -debug_region=cell+lib +define+VCS +nospecify +notimingcheck -error=IPDW -error=UPF_ISPND -error=IGPA -error=PCSRMIO -error=AOUP -error=ELW_UNBOUND -error=IUWI -error=INAV -error=SV-ISC -error=OSVF-NPVIUFPI -error=DPIMI -error=IPDASP -error=CM-HIER-FNF -error=CWUC -error=MATN -error=STASKW_NDTAZ1 -error=TMPO -error=SV-OHCM +error+100 -error=IOPCWM -debug_access+all +vcs+initreg+config+../../../../../util/common/initfile +define+BUS_SZW=3
export run_cmd=$(build_dir)/simv
export run_dir=$(SCRATCH_PATH)/0.$(uvm_test)/out
export run_opts=+UVM_NO_RELNOTES +UVM_VERBOSITY=$(pl) -licqueue -ucli -do $(dv_root)/tools/sim.tcl +ntb_random_seed=$(seed) -assert nopostproc +UVM_TESTNAME=$(uvm_test) +UVM_TEST_SEQ=$(uvm_test_seq)  +vcs+initreg+config+../../../../../util/common/initfile +BOOT_ROM_HEX_FILE=../../../../../sw/$(rom).hex  +OUT_SRAM_HEX_FILE=../../../../../sw/$(ram).hex

debug_waves_cmd = verdi -64bit
debug_waves_opts = $(run_dir)/wave.fsdb

include $(proj_root)/hw/dv/tools/dvsim/sim.mk

vlib:
	@echo "[make]: verdi lib"
	cd $(build_dir)/simv.daidir && verdi -lib $(build_dir)/simv.daidir/work.lib++ &
g:gen_sv_flist
	@echo "[make]: gen_sv_flist"
b:
	@echo "[make]: only_build"
	cd $(build_dir)/sim-vcs && ${build_cmd} ${build_opts} -l ${build_dir}/build.log

debug_verdi:
	@echo "[make]: run verdi vcs debug"
	cd ${run_dir} && ${run_cmd} ${run_opts} -gui=verdi &

fsdb:
	@echo "[make]: verdi *.fsdb"
	cd ${run_dir} && nWave -max_mtr_count 1 -nologo ${run_dir}/waves.fsdb &

vcd:
	@echo "[make]: gtkwave ${run_dir}/waves.vcd"
	cd ${run_dir} && gtkwave --giga ${run_dir}/waves.vcd &

fsdb2vcd:
	@echo "[make]: fsdb2vcd *.fsdb"
	cd ${run_dir} && fsdb2vcd ${run_dir}/waves.fsdb -o ${run_dir}/waves.vcd

soft_compile: 
	@echo "[make]: soft_compile"
	cd ${run_dir} && ${run_cmd} ${run_opts} -l ${run_dir}/run.log

s: sw_build
	@echo "[make]: simulate"
	cd ${run_dir} && ${run_cmd} ${run_opts} -l ${run_dir}/run.log

help:
	@echo "./util/dvsim/dvsim.py ./hw/top_earlgrey/dv/chip_sim_cfg.hjson -i chip_base_test -br default -pr /work/svn/MEISHAV100/trunk"
	@echo "./util/dvsim/dvsim.py ./hw/ip/axi_xbar/dv/axi_xbar_sim_cfg.hjson -i axi_base_test -br default -pr /work/svn/MEISHAV100/trunk"
	@echo "./util/dvsim/dvsim.py ./hw/top_earlgrey/ip/xbar_main/dv/autogen/xbar_main_sim_cfg.hjson -br default -pr /work/svn/MEISHAV100/trunk"
	@echo "make vlib"
	@echo "make g"
	@echo "make b"
	@echo "make g b s uvm_test=tlul_base_test ip_name=u500_top"
	@echo "make g b s uvm_test=soft_base_test ip_name=u500_top"
	@echo "make vlib uvm_test=tlul_base_test ip_name=u500_top"
	@echo "make s uvm_test=axi_base_test"
	@echo "make fsdb uvm_test=tlul_base_test ip_name=u500_top"
	@echo "make fsdb uvm_test=axi_base_test ip_name=axi_xbar"

