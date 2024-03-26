`define tc_name soft_base_test
`define tc_name_cfg soft_base_test_cfg

class `tc_name_cfg extends tlul_base_test_cfg;

    `uvm_object_utils_begin(`tc_name_cfg)
		//`uvm_field_int(ping_delay_max,  UVM_DEFAULT)
	`uvm_object_utils_end

    `uvm_object_new

  virtual function void initialize(bit [TL_AW-1:0] csr_base_addr = '1);
  	super.initialize(csr_base_addr);  // need override tlul_base_test config
    has_devmode = 0;
    en_devmode = 0;
    // list_of_alerts = tlul_base_env_pkg::LIST_OF_ALERTS;
    // initialize
    ral_model_names = {}; // 清空ral_model_names 不进行创建寄存器模型相关组件及相关检查
    is_initialized = 1'b1;
    // super.initialize(csr_base_addr);
    // // create tlul_base agent config obj
    // m_tlul_base_agent_cfg = tlul_base_agent_cfg::type_id::create("m_tlul_base_agent_cfg");
    // // set num_interrupts & num_alerts which will be used to create coverage and more
    // num_interrupts = ral.intr_state.get_n_used_bits();
    // // only support 1 outstanding TL item
    // m_tl_agent_cfg.max_outstanding_req = 1;
    foreach(this.tlul_agent_sw[i]) begin
        
        if(uvm_is_match("*tile*RocketTile*_mst*", i)) begin
            this.tlul_agent_work_mode[i] = dv_utils_pkg::ONLY_MONITOR;
			//this.m_tlul_agent_cfg[i].en_check = dv_utils_pkg::OFF;  // disable core monitor for cmd match resp, because bootrom TLFragmeter_3
        end
		else if(uvm_is_match("*maskROM*_slv*", i)) begin
            this.tlul_agent_work_mode[i] = dv_utils_pkg::ONLY_MONITOR;
        end
        else if(uvm_is_match("*XilinxVC707MIG*tl_mem_slv*", i)) begin
            this.tlul_agent_work_mode[i] = dv_utils_pkg::SLAVE;
        end
        else begin
			this.tlul_agent_sw[i] = dv_utils_pkg::ON;
            this.tlul_agent_work_mode[i] = dv_utils_pkg::ONLY_MONITOR;
        end
		this.tlul_agent_sw[i] = dv_utils_pkg::OFF;
        `uvm_info(get_type_name(), $sformatf("set_vip_agent_work_mode for inst_path %s, work_mode %s", i, this.tlul_agent_work_mode[i].name()), UVM_DEBUG);
        //this.m_tlul_agent_cfg[i].if_mode = dv_utils_pkg::Host;  // donnot need add in here
    end
    `uvm_info(get_type_name(), $sformatf("this cfg is :\n%0s", this.sprint()), UVM_MEDIUM);
  endfunction

  function void pre_randomize();
    super.pre_randomize();
    
  endfunction

  function void post_randomize();
    super.post_randomize();
    
  endfunction


endclass



class `tc_name extends tlul_base_test;
    `uvm_component_utils(`tc_name)
    
    // Components
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
        set_type_override_by_type(dv_base_scoreboard#(dv_base_reg_pkg::dv_base_reg_block,dv_base_env_cfg,dv_base_env_cov)::get_type(), tlul_base_scoreboard::get_type());
		set_type_override_by_type(tlul_base_env_cfg::get_type(), `tc_name_cfg::get_type());
        cfg = `tc_name_cfg::type_id::create("test_cfg", this);
    endfunction //new()

    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    
    //  Function: end_of_elaboration_phase
    extern function void end_of_elaboration_phase(uvm_phase phase);
    
    //  Function: run_phase
    extern task run_phase(uvm_phase phase);
    
    //  Function: main_phase
    extern task main_phase(uvm_phase phase);
    

virtual task trigger_env_clk_rst();
    if (!uvm_config_db#(virtual clk_rst_if)::get(this, "", "clk_rst_vif", cfg.clk_rst_vif)) begin
        `uvm_fatal(get_full_name(), "failed to get clk_rst_vif from uvm_config_db")
    end
    cfg.clk_freq_mhz = dv_utils_pkg::ClkFreq1000Mhz;
    cfg.clk_rst_vif.set_freq_mhz(cfg.clk_freq_mhz);
    cfg.clk_rst_vif.set_active();
endtask


virtual task wait_clk_rst();
    #400ns; // wait soc rst_n deassert
endtask


endclass //`tc_name extends uvm_test

function void `tc_name::build_phase(uvm_phase phase);
    super.build_phase(phase);    
    env.cfg = cfg;
endfunction: build_phase

function void `tc_name::end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
endfunction: end_of_elaboration_phase


task `tc_name::main_phase(uvm_phase phase);
    //super.main_phase(phase);
    phase.raise_objection(this);
    foreach(env.virtual_sequencer.sqr_q[i]) begin
        foreach(env.virtual_sequencer.sqr_q[i][j]) begin
            `uvm_info(get_type_name(), $sformatf("check sequencer type %0s for port_name %0s", i, j), UVM_NONE)
        end
    end
    fork 
        #10ms;  // wait core done
        //seq.start(env.virtual_sequencer.sqr_q["tlul"]["u_VC707BaseShell-topDesign-topMod-tile_3-RocketTile_bind_if_inst-tl_mem_mst-sqr"]);
    join
    #1000ns;
    phase.drop_objection(this);
endtask: main_phase




task  `tc_name::run_phase(uvm_phase phase);

	bit [`BOOTROM_WIDTH - 1:0] rom_content[`BOOTROM_DEPTH];
	
	bit [`DDR_MEM_WIDTH - 1:0] mem_content[`DDR_MEM_BYTE_DEPTH];

	int fp;

	string BOOT_ROM_HEX_FILE;
	string OUT_SRAM_HEX_FILE;

   super.run_phase(phase);
   phase.raise_objection(this);
   #10ns; // wait reset

    `uvm_info(get_type_name(), "run_phase.",UVM_NONE)
	if(device_seq.exists(`BOOTROM_HIR_str)) begin
		if ($value$plusargs("BOOT_ROM_HEX_FILE=%s", BOOT_ROM_HEX_FILE)) begin
			$display("BOOT_ROM_HEX_FILE=%s\n", BOOT_ROM_HEX_FILE);
			// Check wheather the hex  exist
			if($fopen(BOOT_ROM_HEX_FILE, "r") == null)
				$fatal();
		end

		$readmemh(BOOT_ROM_HEX_FILE, rom_content);

		if(`BOOTROM_WIDTH == 64) begin
			for(int ram_depth_idx = 0; ram_depth_idx < `BOOTROM_BYTE_DEPTH; ram_depth_idx++) begin
				`BOOTROM_HIR.write_dword(`BOOTROM_BASE_ADDR + ram_depth_idx * 8, rom_content[ram_depth_idx]);
				//`uvm_info(get_type_name(), $sformatf("load mem_content[%x]=%x", ram_depth_idx, mem_content[ram_depth_idx]), UVM_MEDIUM)
			end
		end
		else if(`BOOTROM_WIDTH == 32) begin
			for(int ram_depth_idx = 0; ram_depth_idx < `BOOTROM_BYTE_DEPTH; ram_depth_idx++) begin
				`BOOTROM_HIR.write_word(`BOOTROM_BASE_ADDR + ram_depth_idx * 4, rom_content[ram_depth_idx]);
				//`uvm_info(get_type_name(), $sformatf("load mem_content[%x]=%x", ram_depth_idx, mem_content[ram_depth_idx]), UVM_MEDIUM)
			end
		end
		else begin
			`uvm_error(get_type_name(), $sformatf("load mem_content error, the mem_width %0d is undefined", `BOOTROM_WIDTH))
		end
	end

//////////////////////////////////////////////////////////////////////
///  Write SRAM  @0x8000_0000
/////////////////////////////////////////////////////////////////////


	if ($value$plusargs("OUT_SRAM_HEX_FILE=%s", OUT_SRAM_HEX_FILE)) begin
		$display("OUT_SRAM_HEX_FILE=%s\n", OUT_SRAM_HEX_FILE);
		// Check wheather the hex  exist
		if($fopen(OUT_SRAM_HEX_FILE, "r") == null)
			$fatal();
	end

	$readmemh(OUT_SRAM_HEX_FILE, mem_content);

	if(`DDR_MEM_WIDTH == 64) begin
		for(int ram_depth_idx = 0; ram_depth_idx < `DDR_MEM_BYTE_DEPTH; ram_depth_idx++) begin
			`uvm_info(get_type_name(), $sformatf("%0s", env.m_axi_agent["u_VC707PCIeShell-topDesign-topMod-mig-island-blackbox-vc707mig1gb_bind_if_inst-s_axi_slv"].get_full_name()), UVM_MEDIUM)
			`uvm_info(get_type_name(), $sformatf("%0s", env.m_axi_agent["u_VC707PCIeShell-topDesign-topMod-mig-island-blackbox-vc707mig1gb_bind_if_inst-s_axi_slv"].s_drv.get_full_name()), UVM_MEDIUM)
			`uvm_info(get_type_name(), $sformatf("%0s", env.m_axi_agent["u_VC707PCIeShell-topDesign-topMod-mig-island-blackbox-vc707mig1gb_bind_if_inst-s_axi_slv"].s_drv.mem.get_full_name()), UVM_MEDIUM)
			`DDR_MEM_HIR.write_dword(`DDR_MEM_BASE_ADDR + ram_depth_idx * 8, mem_content[ram_depth_idx]);
			`uvm_info(get_type_name(), $sformatf("load mem_content[%x]=%x", ram_depth_idx, mem_content[ram_depth_idx]), UVM_MEDIUM)
		end
	end
	else if(`DDR_MEM_WIDTH == 32) begin
		for(int ram_depth_idx = 0; ram_depth_idx < `DDR_MEM_BYTE_DEPTH; ram_depth_idx++) begin
			`DDR_MEM_HIR.write_word(`DDR_MEM_BASE_ADDR + ram_depth_idx * 4, mem_content[ram_depth_idx]);
			//`uvm_info(get_type_name(), $sformatf("load mem_content[%x]=%x", ram_depth_idx, mem_content[ram_depth_idx]), UVM_MEDIUM)
		end
	end
	else begin
		`uvm_error(get_type_name(), $sformatf("load mem_content error, the mem_width %0d is undefined", `DDR_MEM_WIDTH))
	end

/*
	for(ram_depth_idx = 0;ram_depth_idx <= `MEM_DEPTH_TB-1;ram_depth_idx++)
	begin
		ram_depth_idx_lsb26 = ram_depth_idx[25:0];
		case (ram_depth_idx[27:26])
			// 2'b00: begin
			// 	`DRAM_HIR.mem_0_0.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][7 : 0 ];		
			// 	`DRAM_HIR.mem_0_1.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][15: 8 ];		
			// 	`DRAM_HIR.mem_0_2.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][23: 16];		
			// 	`DRAM_HIR.mem_0_3.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][31: 24];		
			// 	`DRAM_HIR.mem_0_4.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][39: 32];		
			// 	`DRAM_HIR.mem_0_5.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][47: 40];		
			// 	`DRAM_HIR.mem_0_6.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][55: 48];		
			// 	`DRAM_HIR.mem_0_7.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][63: 56];				
			// end
			// 2'b01: begin
			// 	`DRAM_HIR.mem_1_0.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][7 : 0 ];		
			// 	`DRAM_HIR.mem_1_1.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][15: 8 ];		
			// 	`DRAM_HIR.mem_1_2.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][23: 16];		
			// 	`DRAM_HIR.mem_1_3.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][31: 24];		
			// 	`DRAM_HIR.mem_1_4.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][39: 32];		
			// 	`DRAM_HIR.mem_1_5.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][47: 40];		
			// 	`DRAM_HIR.mem_1_6.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][55: 48];		
			// 	`DRAM_HIR.mem_1_7.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][63: 56];						
			// end
			// 2'b10: begin
			// 	`DRAM_HIR.mem_2_0.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][7 : 0 ];		
			// 	`DRAM_HIR.mem_2_1.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][15: 8 ];		
			// 	`DRAM_HIR.mem_2_2.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][23: 16];		
			// 	`DRAM_HIR.mem_2_3.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][31: 24];		
			// 	`DRAM_HIR.mem_2_4.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][39: 32];		
			// 	`DRAM_HIR.mem_2_5.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][47: 40];		
			// 	`DRAM_HIR.mem_2_6.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][55: 48];		
			// 	`DRAM_HIR.mem_2_7.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][63: 56];					
			// end
			// 2'b11: begin
			// 	`DRAM_HIR.mem_3_0.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][7 : 0 ];		
			// 	`DRAM_HIR.mem_3_1.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][15: 8 ];		
			// 	`DRAM_HIR.mem_3_2.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][23: 16];		
			// 	`DRAM_HIR.mem_3_3.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][31: 24];		
			// 	`DRAM_HIR.mem_3_4.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][39: 32];		
			// 	`DRAM_HIR.mem_3_5.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][47: 40];		
			// 	`DRAM_HIR.mem_3_6.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][55: 48];		
			// 	`DRAM_HIR.mem_3_7.ram[ram_depth_idx_lsb26] = mem_content[ram_depth_idx_lsb26][63: 56];						
			// end
			default: begin 
					$display("RAM ADDR ERROR!!!") ;
					$finish();
			end
		endcase
	  
	end	
*/
	
    phase.drop_objection(this);
endtask: run_phase



`undef tc_name
`undef tc_name_cfg