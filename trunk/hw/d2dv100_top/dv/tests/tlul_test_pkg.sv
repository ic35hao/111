// Vendor 		: 
// Author 		: ling
// Filename 	: tlul_test 
// Date Created: 2022.04.26 
// Version		: V1.0
// File description	:
// Revision History :

package tlul_test_pkg;
  // dep packages
  import uvm_pkg::*;
  //import cip_base_pkg::*;
  import top_pkg::*;
  import tl_agent_pkg::*;
  import bind_abs_pkg::*;
  import dv_lib_pkg::*;
  import tlul_base_env_pkg::*;
  
// `define BOOTROM_HIR tb.u_VC707PCIeShell.topDesign.topMod.maskROM.rom
// `define BOOTROM_DEPTH 32'h1000
// `define BOOTROM_WIDTH 32

`define BOOTROM_HIR_str "u_VC707PCIeShell-topDesign-topMod-maskROM-TLMaskROM_bind_if_inst-tl_slv-sqr"
`define BOOTROM_HIR device_seq[`BOOTROM_HIR_str].mem
`define BOOTROM_DEPTH 32'h1_0000
`define BOOTROM_WIDTH 32
`define BOOTROM_BYTE_DEPTH 32'h0_800
`define BOOTROM_BASE_ADDR 32'h0001_0000


//`define DDR_MEM_HIR device_seq["u_VC707PCIeShell-topDesign-topMod-mig-XilinxVC707MIG_bind_if_inst-tl_mem_slv-sqr"].mem
`define DDR_MEM_HIR env.m_axi_agent["u_VC707PCIeShell-topDesign-topMod-mig-island-blackbox-vc707mig1gb_bind_if_inst-s_axi_slv"].s_drv.mem
`define DDR_MEM_DEPTH 32'h4_0000
`define DDR_MEM_WIDTH 64
`define DDR_MEM_BYTE_DEPTH 32'h0_800
//`define DDR_MEM_BASE_ADDR 32'h8000_0000  // mig axi slv port addr is begin from 0
`define DDR_MEM_BASE_ADDR 32'h0000_0000

  // Types of memories in the chip.
  typedef enum {
    FlashBank0Data,
    FlashBank1Data,
    FlashBank0Info,
    FlashBank1Info,
    Otp,
    RamMain,
    RamRet,
    Rom
  } chip_mem_e;


  // macro includes
  `include "uvm_macros.svh"

  // functions

  // package sources
  `include "tlul_test.sv"
  `include "soft_base_test.sv"
  `include "uart_base_test.sv"
endpackage

`undef BOOTROM_HIR
`undef BOOTROM_DEPTH
`undef BOOTROM_WIDTH

`undef DDR_MEM_HIR
`undef DDR_MEM_DEPTH
`undef DDR_MEM_WIDTH
`undef DDR_MEM_BYTE_DEPTH
`undef DDR_MEM_BASE_ADDR