module vc707axi_to_pcie_x1( 
      input s_axi_ctl_rready, output s_axi_ctl_rvalid
    , output [1:0] s_axi_ctl_rresp
    , output [31:0] s_axi_ctl_rdata
    , output s_axi_ctl_arready
    , input s_axi_ctl_arvalid
    , input [31:0] s_axi_ctl_araddr
    , input s_axi_ctl_bready
    , output s_axi_ctl_bvalid
    , output [1:0] s_axi_ctl_bresp
    , output s_axi_ctl_wready
    , input s_axi_ctl_wvalid
    , input [3:0] s_axi_ctl_wstrb
    , input [31:0] s_axi_ctl_wdata
    , output s_axi_ctl_awready
    , input s_axi_ctl_awvalid
    , input [31:0] s_axi_ctl_awaddr
    , input m_axi_rvalid
    , input m_axi_rlast
    , input [1:0] m_axi_rresp
    , input [1:0] m_axi_rdata
    , output m_axi_rready
    , input m_axi_arready
    , output m_axi_arvalid
    , output [2:0] m_axi_arprot
    , output [3:0] m_axi_arcache
    , output m_axi_arlock
    , output [1:0] m_axi_arburst
    , output [2:0] m_axi_arsize
    , output [7:0] m_axi_arlen
    , output [31:0] m_axi_araddr
    , input m_axi_bvalid
    , input [1:0] m_axi_bresp
    , output m_axi_bready
    , input m_axi_wready
    , output m_axi_wvalid
    , output m_axi_wlast
    , output [7:0] m_axi_wstrb
    , output [63:0] m_axi_wdata
    , input m_axi_awready
    , output m_axi_awvalid
    , output [2:0] m_axi_awprot
    , output [3:0] m_axi_awcache
    , output m_axi_awlock
    , output [1:0] m_axi_awburst
    , output [2:0] m_axi_awsize
    , output [7:0] m_axi_awlen
    , output [31:0] m_axi_awaddr
    , input s_axi_rvalid
    , input s_axi_rlast
    , input [1:0] s_axi_rresp
    , input [63:0] s_axi_rdata
    , input [3:0] s_axi_rid
    , output s_axi_rready
    , output s_axi_arready
    , input s_axi_arvalid
    , input [1:0] s_axi_arburst
    , input [2:0] s_axi_arsize
    , input [7:0] s_axi_arlen
    , input [3:0] s_axi_arregion
    , input [1:0] s_axi_araddr
    , input [3:0] s_axi_arid
    , output s_axi_bvalid
    , output [1:0] s_axi_bresp
    , output [3:0] s_axi_bid
    , input s_axi_bready
    , output s_axi_wready
    , input s_axi_wvalid
    , input s_axi_wlast
    , input [7:0] s_axi_wstrb
    , input [63:0] s_axi_wdata
    , output s_axi_awready
    , input s_axi_awvalid
    , input [1:0] s_axi_awburst
    , input [2:0] s_axi_awsize
    , input [7:0] s_axi_awlen
    , input [3:0] s_axi_awregion
    , input [31:0] s_axi_awaddr
    , input [3:0] s_axi_awid
    , output interrupt_out
    , output [2:0] MSI_Vector_Width
    , input [4:0] MSI_Vector_Num
    , input MSI_enable
    , output INTX_MSI_Grant
    , input INTX_MSI_Request
    , input REFCLK
    , input mmcm_lock
    , input axi_ctl_aclk_out
    , input axi_aclk_out
    , input axi_aresetn
    , input pci_exp_rxn
    , input pci_exp_rxp
    , output pci_exp_txn
    , output pci_exp_txp
  );


    assign s_axi_ctl_rvalid = 'h0;
    assign s_axi_ctl_rresp = 'h0;
    assign s_axi_ctl_rdata = 'h0;
    assign s_axi_ctl_arready = 'h0;
    assign s_axi_ctl_bvalid = 'h0;
    assign s_axi_ctl_bresp = 'h0;
    assign s_axi_ctl_wready = 'h0;
    assign s_axi_ctl_awready = 'h0;
    assign m_axi_rready = 'h0;
    assign m_axi_arvalid = 'h0;
    assign m_axi_arprot = 'h0;
    assign m_axi_arcache = 'h0;
    assign m_axi_arlock = 'h0;
    assign m_axi_arburst = 'h0;
    assign m_axi_arsize = 'h0;
    assign m_axi_arlen = 'h0;
    assign m_axi_araddr = 'h0;
    assign m_axi_bready = 'h0;
    assign m_axi_wvalid = 'h0;
    assign m_axi_wlast = 'h0;
    assign m_axi_wstrb = 'h0;
    assign m_axi_wdata = 'h0;
    assign m_axi_awvalid = 'h0;
    assign m_axi_awprot = 'h0;
    assign m_axi_awcache = 'h0;
    assign m_axi_awlock = 'h0;
    assign m_axi_awburst = 'h0;
    assign m_axi_awsize = 'h0;
    assign m_axi_awlen = 'h0;
    assign m_axi_awaddr = 'h0;
    assign s_axi_rready = 'h0;
    assign s_axi_arready = 'h0;
    assign s_axi_bvalid = 'h0;
    assign s_axi_bresp = 'h0;
    assign s_axi_bid = 'h0;
    assign s_axi_wready = 'h0;
    assign s_axi_awready = 'h0;
    assign interrupt_out = 'h0;
    assign MSI_Vector_Width = 'h0;
    assign INTX_MSI_Grant = 'h0;
    assign pci_exp_txn = 'h0;
    assign pci_exp_txp = 'h0;



endmodule
