`timescale 1ps/1ps

module tb ();


import tlul_test_pkg::*;
import uvm_pkg::*;

reg sys_clock;
reg jtag_jtag_TCK;
reg jtag_jtag_TMS;
reg jtag_jtag_TDI;
wire jtag_jtag_TDO;
wire uart_txd;
reg uart_rxd;
wire uart_rtsn;
reg uart_ctsn;
wire sdio_sdio_clk;
wire sdio_sdio_cmd;
reg sdio_sdio_dat_0;
wire sdio_sdio_dat_1;
wire sdio_sdio_dat_2;
wire sdio_sdio_dat_3;
wire [13:0]ddr_ddr3_addr;
wire [2:0]ddr_ddr3_ba;
wire ddr_ddr3_ras_n;
wire ddr_ddr3_cas_n;
wire ddr_ddr3_we_n;
wire ddr_ddr3_reset_n;
wire ddr_ddr3_ck_p;
wire ddr_ddr3_ck_n;
wire ddr_ddr3_cke;
wire ddr_ddr3_cs_n;
wire [7:0]ddr_ddr3_dm;
wire ddr_ddr3_odt;
wire [63:0]ddr_ddr3_dq;
wire [7:0]ddr_ddr3_dqs_n;
wire [7:0]ddr_ddr3_dqs_p;
wire [7:0] led;
reg sys_reset;

  wire        pcie_pci_exp_txp;
  wire        pcie_pci_exp_txn;
  wire         pcie_pci_exp_rxp;
  wire         pcie_pci_exp_rxn;
  wire         pcie_REFCLK_rxp;
  wire         pcie_REFCLK_rxn;

VC707PCIeShell  u_VC707PCIeShell
(
    .sys_clock_p(sys_clock),
    .sys_clock_n(~sys_clock),
    .jtag_jtag_TCK(jtag_jtag_TCK),
    .jtag_jtag_TMS(jtag_jtag_TMS),
    .jtag_jtag_TDI(jtag_jtag_TDI),
    .jtag_jtag_TDO(jtag_jtag_TDO),
    .uart_txd(uart_txd),
    .uart_rxd(uart_rxd),
    .uart_rtsn(uart_rtsn),
    .uart_ctsn(uart_ctsn),
    .sdio_sdio_clk(sdio_sdio_clk),
    .sdio_sdio_cmd(sdio_sdio_cmd),
    .sdio_sdio_dat_0(sdio_sdio_dat_0),
    .sdio_sdio_dat_1(sdio_sdio_dat_1),
    .sdio_sdio_dat_2(sdio_sdio_dat_2),
    .sdio_sdio_dat_3(sdio_sdio_dat_3),
    .ddr_ddr3_addr(ddr_ddr3_addr),
    .ddr_ddr3_ba(ddr_ddr3_ba),
    .ddr_ddr3_ras_n(ddr_ddr3_ras_n),
    .ddr_ddr3_cas_n(ddr_ddr3_cas_n),
    .ddr_ddr3_we_n(ddr_ddr3_we_n),
    .ddr_ddr3_reset_n(ddr_ddr3_reset_n),
    .ddr_ddr3_ck_p(ddr_ddr3_ck_p),
    .ddr_ddr3_ck_n(ddr_ddr3_ck_n),
    .ddr_ddr3_cke(ddr_ddr3_cke),
    .ddr_ddr3_cs_n(ddr_ddr3_cs_n),
    .ddr_ddr3_dm(ddr_ddr3_dm),
    .ddr_ddr3_odt(ddr_ddr3_odt),
    .ddr_ddr3_dq(ddr_ddr3_dq),
    .ddr_ddr3_dqs_n(ddr_ddr3_dqs_n),
    .ddr_ddr3_dqs_p(ddr_ddr3_dqs_p),
    .pcie_pci_exp_txp(pcie_pci_exp_txp),
    .pcie_pci_exp_txn(pcie_pci_exp_txn),
    .pcie_pci_exp_rxp(pcie_pci_exp_rxp),
    .pcie_pci_exp_rxn(pcie_pci_exp_rxn),
    .pcie_REFCLK_rxp(pcie_REFCLK_rxp),
    .pcie_REFCLK_rxn(pcie_REFCLK_rxn),
    .led(led),
    .reset(sys_reset)
);

`define ROM_MEM_HIER tb.u_VC707PCIeShell.topDesign.topMod.maskROM.rom.rom


  initial begin
      //force u_VC707PCIeShell.topDesign.topMod.sbus.control_bus.coupler_to_slave_named_MaskROM.fragmenter.Repeater.io_repeat = 0;
      force tb.u_VC707PCIeShell.topDesign.topMod.clint.auto_int_out_0_1 = 0;
      force tb.u_VC707PCIeShell.topDesign.topMod.clint.auto_int_out_1_1 = 0;
      force tb.u_VC707PCIeShell.topDesign.topMod.clint.auto_int_out_2_1 = 0;
      force tb.u_VC707PCIeShell.topDesign.topMod.clint.auto_int_out_3_1 = 0;
  end

  initial begin
      #1ns;
      force pcie_pci_exp_rxp = pcie_pci_exp_txp;
      force pcie_pci_exp_rxn = pcie_pci_exp_txn;
      force pcie_REFCLK_rxp = sys_clock;
      force pcie_REFCLK_rxn = ~sys_clock;
      force u_VC707PCIeShell.sdio_sdio_dat_0 = u_VC707PCIeShell.u_sdcard.sd_dat[0];
      force u_VC707PCIeShell.u_sdcard.sd_dat[3] = u_VC707PCIeShell.sdio_sdio_dat_3;
  end

    initial begin
        
        sys_clock <= 1'b0;
        sys_reset <= 1'b1;
        jtag_jtag_TCK <= 1'b0;
        jtag_jtag_TMS <= 1'b1;
        jtag_jtag_TDI <= 1'b0;
        uart_rxd <= 1'b1;
        uart_ctsn <= 1'b0;
        sdio_sdio_dat_0 <= 1'b0;
        # 40
        sys_reset <= 1'b0;
        # 200000;
    end
    // // dump vcd 
    // string testcase_name;

    // initial begin
    //     if(!$value$plusargs("UVM_TESTNAME=%0s", testcase_name)) begin
    //       testcase_name = "default_case_name";
    //       //`uvm_error("tb", $sformatf("check UVM_TESTNAME is defined"))
    //     end
    //     testcase_name = "waves";
    //     $dumpfile($sformatf("%0s.vcd", testcase_name));
    //     $dumpvars(0, tb);
    // end

    initial begin
        force u_VC707PCIeShell.fpga_power_on.power_on_reset = 1;
        #200ns;
        force u_VC707PCIeShell.fpga_power_on.power_on_reset = 0;
    end

    initial begin
        string boot_rom_hex_file;
	      string out_sram_hex_file;
        force u_VC707PCIeShell.topDesign.topMod.uart_0.txm.print_uart = 0;
        if ($value$plusargs("BOOT_ROM_HEX_FILE=%s",boot_rom_hex_file)) begin
            $display("boot_rom_hex_file = %s\n",boot_rom_hex_file);
            // bootrom max depth: 'h200_0000 * 4byte - exact: 'h1_0000 * 4byte
            $readmemh(boot_rom_hex_file, `ROM_MEM_HIER);
            // for(rom_depth_idx = 0;rom_depth_idx <= `BOOTROM_DEPTH-1;rom_depth_idx++)
            // begin 
            //     uvm_hdl_force($sformatf("%0s.rom[%0d]", `DV_STRINGIFY(`BOOTROM_HIR), rom_depth_idx), ) = rom_content[rom_depth_idx]);		
            // end
        end
        
    end

    always #1ns sys_clock <= ~sys_clock;
    
    wire clk, rst_n;

    clk_rst_if clk_rst_if(.clk(clk), .rst_n(rst_n));


    initial begin
        clk_rst_if.set_active();
        uvm_config_db#(virtual clk_rst_if)::set(null, "*", "clk_rst_vif", clk_rst_if);
        $timeformat(-12, 0, " ps", 12);
        run_test();
    end
    pullup (VC707PCIeShell.sdio_sdio_dat_3);
    pullup (VC707PCIeShell.sdio_sdio_dat_2);
    pullup (VC707PCIeShell.sdio_sdio_dat_1);
    pullup (VC707PCIeShell.sdio_sdio_dat_0);
/*
    
  // Instantitate the memory backdoor util instances.
  if (`PRIM_DEFAULT_IMPL == prim_pkg::ImplGeneric) begin : gen_generic
    initial begin
      mem_bkdr_util m_mem_bkdr_util[chip_mem_e];

      m_mem_bkdr_util[RamMain] = new(.name  ("mem_bkdr_util[RamMain]"),
                                     .path  (`DV_STRINGIFY(`RAM_MAIN_MEM_HIER)),
                                     .depth ($size(`RAM_MAIN_MEM_HIER)),
                                     .n_bits($bits(`RAM_MAIN_MEM_HIER)),
                                     .err_detection_scheme(mem_bkdr_util_pkg::ParityOdd));
      `MEM_BKDR_UTIL_FILE_OP(m_mem_bkdr_util[RamMain], `RAM_MAIN_MEM_HIER)

      m_mem_bkdr_util[RamRet] = new(.name  ("mem_bkdr_util[RamRet]"),
                                    .path  (`DV_STRINGIFY(`RAM_RET_MEM_HIER)),
                                    .depth ($size(`RAM_RET_MEM_HIER)),
                                    .n_bits($bits(`RAM_RET_MEM_HIER)),
                                    .err_detection_scheme(mem_bkdr_util_pkg::ParityOdd));
      `MEM_BKDR_UTIL_FILE_OP(m_mem_bkdr_util[RamRet], `RAM_RET_MEM_HIER)

      m_mem_bkdr_util[Rom] = new(.name  ("mem_bkdr_util[Rom]"),
                                 .path  (`DV_STRINGIFY(`ROM_MEM_HIER)),
                                 .depth ($size(`ROM_MEM_HIER)),
                                 .n_bits($bits(`ROM_MEM_HIER)),
                                 .err_detection_scheme(mem_bkdr_util_pkg::Ecc_39_32));
      `MEM_BKDR_UTIL_FILE_OP(m_mem_bkdr_util[Rom], `ROM_MEM_HIER)

      for (chip_mem_e mem = mem.first(), int i = 0; i < mem.num(); mem = mem.next(), i++) begin
        uvm_config_db#(mem_bkdr_util)::set(
            null, "*.env", m_mem_bkdr_util[mem].get_name(), m_mem_bkdr_util[mem]);
      end
    end
  end
*/

`undef ROM_MEM_HIER


endmodule


bind VC707PCIeShell uart_monitor u_uart_monitor(
      .clk(VC707PCIeShell.topDesign.topMod.uart_0.txm.clock)
    , .rst_n(~VC707PCIeShell.topDesign.topMod.uart_0.txm.reset)
    , .io_en(VC707PCIeShell.topDesign.topMod.uart_0.txm.io_en)
    , .tx_en(VC707PCIeShell.topDesign.topMod.uart_0.txm._T_20 & VC707PCIeShell.topDesign.topMod.uart_0.txm._T_22)
    , .wdata(VC707PCIeShell.topDesign.topMod.uart_0.txm.io_in_bits)
    ); 


// bind VC707PCIeShell sdModel u_sdModel
// 				(
// 				.sdClk 	( VC707PCIeShell.sdio_sdio_clk 	),
// 				.sd_cmd_oe(1),
// 				.cmd 		( VC707PCIeShell.sdio_sdio_cmd 				),
// 				.sd_dat_oe(sd_dat_oe),
// 				.dat 		( {VC707PCIeShell.sdio_sdio_dat_3, VC707PCIeShell.sdio_sdio_dat_2, VC707PCIeShell.sdio_sdio_dat_1, VC707PCIeShell.sdio_sdio_dat_0} )
// 				);

bind VC707PCIeShell mdl_sdio u_sdcard (
		.sd_clk(VC707PCIeShell.sdio_sdio_clk)
    , .sd_cmd(VC707PCIeShell.sdio_sdio_cmd)
    , .sd_dat({VC707PCIeShell.sdio_sdio_dat_3, VC707PCIeShell.sdio_sdio_dat_2, VC707PCIeShell.sdio_sdio_dat_1, VC707PCIeShell.sdio_sdio_dat_0})
	);
