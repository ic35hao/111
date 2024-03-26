#export PWD=$(shell pwd)
export REPO_TOP=$(PWD)

export SHLVL=2
export SIMULATOR=vcs
export SYNOPSYS=/usr/synopsys
export TB_TOP=tb
export TERM=xterm
export TOOLCHAIN_PATH=/tools/riscv
export VCS_ARCH_OVERRIDE=linux
export VCS_HOME=/usr/synopsys/vcs-L-2016.06/
export VCS_LICENSE_WAIT=1
export VCS_LIC_EXPIRE_WARNING=1
export VCS_TARGET_ARCH=amd64
export VERDI_HOME=/usr/synopsys/verdi-L-2016.06-1
export VERIBLE_VERSION=v0.0-1213-g9e5c085
export GIT_VERSION=new_soc
export dv_root=$(proj_root)/hw/dv

ifeq ($(wave),)
	wave = fsdb
endif


export WAVES=$(wave)
export dut_instance=tb.dut
export _=./util/dvsim/dvsim.py