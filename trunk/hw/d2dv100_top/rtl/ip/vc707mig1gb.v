module vc707mig1gb ( // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  inout  [63:0] ddr3_dq, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475096.4]
  inout  [7:0]  ddr3_dqs_n, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475096.4]
  inout  [7:0]  ddr3_dqs_p, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475096.4]

  output [11:0] device_temp, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  s_axi_rvalid, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  s_axi_rlast, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output [1:0] s_axi_rresp, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output [63:0] s_axi_rdata, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output [3:0] s_axi_rid, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input  s_axi_rready, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  s_axi_arready, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input  s_axi_arvalid, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [3:0] s_axi_arqos, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [2:0] s_axi_arprot, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [3:0] s_axi_arcache, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input  s_axi_arlock, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [1:0] s_axi_arburst, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [2:0] s_axi_arsize, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [7:0] s_axi_arlen, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [29:0] s_axi_araddr, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [3:0] s_axi_arid, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  s_axi_bvalid, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output [1:0] s_axi_bresp, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output [3:0] s_axi_bid, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input  s_axi_bready, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  s_axi_wready, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input  s_axi_wvalid, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input  s_axi_wlast, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [7:0] s_axi_wstrb, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [63:0] s_axi_wdata, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  s_axi_awready, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input  s_axi_awvalid, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [3:0] s_axi_awqos, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [2:0] s_axi_awprot, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [3:0] s_axi_awcache, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input  s_axi_awlock, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [1:0] s_axi_awburst, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [2:0] s_axi_awsize, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [7:0] s_axi_awlen, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [29:0] s_axi_awaddr, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input [3:0] s_axi_awid, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  app_zq_ack, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  app_ref_ack, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  app_sr_active, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input  app_zq_req, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input  app_ref_req, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input  app_sr_req, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input  sys_rst, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  init_calib_complete, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input  aresetn, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  mmcm_locked, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output reg ui_clk_sync_rst, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output reg ui_clk, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  input  sys_clk_i, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  ddr3_odt, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output [7:0] ddr3_dm, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  ddr3_cs_n, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  ddr3_cke, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  ddr3_ck_n, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  ddr3_ck_p, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  ddr3_reset_n, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  ddr3_we_n, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  ddr3_cas_n, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output  ddr3_ras_n, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output [2:0] ddr3_ba, // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]
  output [13:0] ddr3_addr // @[XilinxVC707MIG.scala 53:26:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@475125.4]

  );


  assign device_temp = 0; 
  assign s_axi_rvalid = 0; 
  assign s_axi_rlast = 0; 
  assign s_axi_rresp = 0; 
  assign s_axi_rdata = 0; 
  assign s_axi_rid = 0; 
  assign s_axi_arready = 0; 
  assign s_axi_bvalid = 0; 
  assign s_axi_bresp = 0; 
  assign s_axi_bid = 0; 
  assign s_axi_wready = 0; 
  assign s_axi_awready = 0; 
  assign app_zq_ack = 0; 
  assign app_ref_ack = 0; 
  assign app_sr_active = 0; 
  assign init_calib_complete = 0; 
  assign mmcm_locked = 1;   // control soc rst , need be 1

  assign ddr3_odt = 0; 
  assign ddr3_dm = 0; 
  assign ddr3_cs_n = 0; 
  assign ddr3_cke = 0; 
  assign ddr3_ck_n = 0; 
  assign ddr3_ck_p = 0; 
  assign ddr3_reset_n = 1; 
  assign ddr3_we_n = 0; 
  assign ddr3_cas_n = 0; 
  assign ddr3_ras_n = 0; 
  assign ddr3_ba = 0; 
  assign ddr3_addr = 0; 

    //   assign ui_clk_sync_rst = 0; 
    //   assign ui_clk = 0; 
    always #1ns ui_clk <= ~ui_clk;

    initial begin
        ui_clk_sync_rst = 1;
        ui_clk = 0;
        #1000ns;
        ui_clk_sync_rst = 0;
    end


endmodule
