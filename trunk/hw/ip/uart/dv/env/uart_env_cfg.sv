// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

class uart_env_cfg extends cip_base_env_cfg #(.RAL_T(uart_reg_block));

  // ext component cfgs
  dv_utils_pkg::switch_e    uart_agent_sw[string];
  bit         uart_agent_is_active = 1'b1;   // active driver/sequencer or passive monitor
  dv_utils_pkg::if_mode_e   uart_agent_if_mode;            // interface mode - Host or Device
  uart_agent_cfg            m_uart_agent_cfg;
  // during break error, DUT will trigger additional frame/parity errors, which mon doesn't catch
  // disable parity/frame check in this period
  bit  disable_scb_rx_parity_check;
  bit  disable_scb_rx_frame_check;

  `uvm_object_utils(uart_env_cfg)

  `uvm_object_new

  virtual function void initialize(bit [TL_AW-1:0] csr_base_addr = '1);
    list_of_alerts = uart_env_pkg::LIST_OF_ALERTS;
    super.initialize(csr_base_addr);
    // create uart agent config obj
    m_uart_agent_cfg = uart_agent_cfg::type_id::create("m_uart_agent_cfg");
    // set num_interrupts & num_alerts which will be used to create coverage and more
    num_interrupts = ral.intr_state.get_n_used_bits();
    // only support 1 outstanding TL item
    m_tl_agent_cfg.max_outstanding_req = 1;
  endfunction
    
  // function void create_vip();
  //     string port_name;
  //     string port_inst_path;
  //     int agent_num;
  //     foreach(bind_abs_pkg::harness_api_abstract::harness_api_q[inst_path]) begin
  //         uart_intf_c uart_intf;
  //         if($cast(uart_intf, bind_abs_pkg::harness_api_abstract::harness_api_q[inst_path])) begin
  //             int port_num = uart_intf.get_port_num(uart_intf_c::PORT_TYPE); 
  //             for(int i = 0; i < port_num; i++) begin
  //                 port_name = uart_intf.get_port_name(uart_intf_c::PORT_TYPE, i);
  //                 port_inst_path = {inst_path, "-", port_name};
  //                 this.uart_agent_sw[port_inst_path] = dv_utils_pkg::OFF;
  //                 this.uart_agent_is_active[port_inst_path] = 1;
  //                 this.uart_agent_if_mode[port_inst_path] = dv_utils_pkg::Host;
  //                 this.m_uart_agent_cfg[port_inst_path] = uart_agent_cfg::type_id::create($sformatf("m_uart_agent_cfg-%s", port_inst_path));
  //                 this.m_uart_agent_cfg[port_inst_path].if_mode = this.uart_agent_if_mode[port_inst_path];
  //                 uvm_config_db#(virtual uart_interface)::set(uvm_root::get(), {"*", port_inst_path, "*"}, "vif", uart_intf.get_uart_if(i));
  //                 `uvm_info(get_type_name(), $sformatf("get harness path %s, port_name %s, probably create vip", inst_path, port_name), UVM_NONE);
  //                 agent_num++;
  //             end
  //         end
  //     end
  // endfunction: create_vip

  // uart doesn't have reset pin. When reset occurs/clears,
  // need to call reset function in uart_agent_cfg
  virtual function void reset_asserted();
    super.reset_asserted();
    m_uart_agent_cfg.reset_asserted();
  endfunction

  virtual function void reset_deasserted();
    super.reset_deasserted();
    m_uart_agent_cfg.reset_deasserted();
  endfunction
endclass
