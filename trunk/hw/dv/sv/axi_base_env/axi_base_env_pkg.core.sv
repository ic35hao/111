// Vendor 		: 
// Author 		: ling
// Filename 	: bus_checker 
// Date Created: 2022.04.26 
// Version		: V1.0
// File description	:
// Revision History :
/* YAML_HEADER_BEGIN
CAPI=2:
# Vendor 		: 
# Author 		: ling
# Filename 	:  
# Date Created: 2022.04.26 
# Version		: V1.0
# File description	:
# Revision History :
name: "lowrisc:dv:amba_lib:0.1"
description: "axi env DV UVM environmnt"
filesets:
  files_dv:
    depend:
      - lowrisc:dv:ralgen
      - lowrisc:dv:axi_vip
      - lowrisc:dv:dv_base_reg
      - lowrisc:dv:dv_lib
      #- lowrisc:dv:cip_lib
      - lowrisc:dv:bind_lib
      - lowrisc:dv:memory_map_info
    files:
      - th_lib/apb_bind_if.sv
      - th_lib/axi_bind_if.sv
      - axi_base_env_pkg.core.sv
      - axi_base_virtual_sequencer.sv: {is_include_file: true}
      - axi_base_scoreboard.sv: {is_include_file: true}
      - axi_base_env_cov.sv: {is_include_file: true}
      - axi_base_reg_block.sv: {is_include_file: true}
      - axi_base_env_cfg.sv: {is_include_file: true}
      - axi_base_env.sv: {is_include_file: true}
    file_type: systemVerilogSource

# generate:
#   ral:
#     generator: ralgen
#     parameters:
#       name: axi
#       ip_hjson: ../../data/axi.hjson

targets:
  default:
    filesets:
      - files_dv
    # generate:
      # - ral

 YAML_HEADER_END */

package axi_base_env_pkg;
  // dep packages
  import uvm_pkg::*;
  import top_pkg::*;
  import axi_pkg::*;
  import dv_base_reg_pkg::*;
  import dv_lib_pkg::*;
  import cip_base_pkg::*;
  
  import bind_abs_pkg::*;
  import memory_map_info_pkg::*;
  import axi_bind_lib_pkg::*;
  // import dv_utils_pkg::*;
  // import csr_utils_pkg::*;
  // import tl_agent_pkg::*;
  // import dv_lib_pkg::*;
  // import cip_base_pkg::*;
  // import axi_base_ral_pkg::*;

  // macro includes
  `include "uvm_macros.svh"
  //`include "dv_macros.svh"

  // local parameters and types
  // These are currently hardcoded to 1 - this will need to change if design is modified
  // parameter uint NUM_HARTS = 1;
  // parameter uint NUM_TIMERS = 1;

  //typedef class axi_base_env_cfg;
  //typedef class axi_base_env_cov;
  //typedef cip_base_virtual_sequencer #(axi_base_env_cfg, axi_base_env_cov) axi_base_virtual_sequencer;

  // functions

  // package sources
  `include "axi_base_reg_block.sv"
  `include "axi_base_env_cfg.sv"
  `include "axi_base_env_cov.sv"
  `include "axi_base_scoreboard.sv"
  `include "axi_base_virtual_sequencer.sv"
  `include "axi_base_env.sv"
  
  // `include "axi_base_vseq_list.sv"
endpackage