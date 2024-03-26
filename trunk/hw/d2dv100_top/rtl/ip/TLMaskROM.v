module TLMaskROM( // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450311.2]
  input         clock, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450312.4]
  input         reset, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450313.4]
  output        auto_in_a_ready, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450314.4]
  input         auto_in_a_valid, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450314.4]
  input  [2:0]  auto_in_a_bits_opcode, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450314.4]
  input  [2:0]  auto_in_a_bits_param, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450314.4]
  input  [1:0]  auto_in_a_bits_size, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450314.4]
  input  [9:0]  auto_in_a_bits_source, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450314.4]
  input  [16:0] auto_in_a_bits_address, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450314.4]
  input  [3:0]  auto_in_a_bits_mask, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450314.4]
  input         auto_in_a_bits_corrupt, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450314.4]
  input         auto_in_d_ready, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450314.4]
  output        auto_in_d_valid, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450314.4]
  output [1:0]  auto_in_d_bits_size, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450314.4]
  output [9:0]  auto_in_d_bits_source, // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450314.4]
  output [31:0] auto_in_d_bits_data // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450314.4]
);
  wire  TLMonitor_clock; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire  TLMonitor_reset; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire  TLMonitor_io_in_a_ready; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire  TLMonitor_io_in_a_valid; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire [2:0] TLMonitor_io_in_a_bits_opcode; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire [2:0] TLMonitor_io_in_a_bits_param; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire [1:0] TLMonitor_io_in_a_bits_size; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire [9:0] TLMonitor_io_in_a_bits_source; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire [16:0] TLMonitor_io_in_a_bits_address; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire [3:0] TLMonitor_io_in_a_bits_mask; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire  TLMonitor_io_in_a_bits_corrupt; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire  TLMonitor_io_in_d_ready; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire  TLMonitor_io_in_d_valid; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire [1:0] TLMonitor_io_in_d_bits_size; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire [9:0] TLMonitor_io_in_d_bits_source; // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  wire [31:0] rom_q; // @[ROMGenerator.scala 27:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450359.4]
  wire  rom_me; // @[ROMGenerator.scala 27:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450359.4]
  wire  rom_oe; // @[ROMGenerator.scala 27:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450359.4]
  wire [10:0] rom_address; // @[ROMGenerator.scala 27:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450359.4]
  wire  rom_clock; // @[ROMGenerator.scala 27:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450359.4]
  wire [17:0] _T_156; // @[MaskROM.scala 42:54:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450366.4]
  wire [17:0] _T_157; // @[MaskROM.scala 42:54:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450367.4]
  wire [16:0] _T_158; // @[MaskROM.scala 42:54:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450368.4]
  wire [14:0] _T_159; // @[Edges.scala 192:34:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450369.4]
  reg  d_full; // @[MaskROM.scala 46:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450375.4]
  reg [31:0] _RAND_0;
  wire  _T_172; // @[MaskROM.scala 55:33:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450395.4]
  wire  in_a_ready; // @[MaskROM.scala 55:30:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450396.4]
  wire  _T_161; // @[Decoupled.scala 37:37:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450373.4]
  reg [1:0] d_size; // @[MaskROM.scala 47:21:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450376.4]
  reg [31:0] _RAND_1;
  reg [9:0] d_source; // @[MaskROM.scala 48:23:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450377.4]
  reg [31:0] _RAND_2;
  reg  _T_167; // @[MaskROM.scala 49:45:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450379.4]
  reg [31:0] _RAND_3;
  reg [31:0] _T_169; // @[Reg.scala 11:16:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450381.4]
  reg [31:0] _RAND_4;
  wire  _T_170; // @[Decoupled.scala 37:37:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450386.4]
  // TLMonitor_76 TLMonitor ( // @[Nodes.scala 25:25:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450321.4]
  //   .clock(TLMonitor_clock),
  //   .reset(TLMonitor_reset),
  //   .io_in_a_ready(TLMonitor_io_in_a_ready),
  //   .io_in_a_valid(TLMonitor_io_in_a_valid),
  //   .io_in_a_bits_opcode(TLMonitor_io_in_a_bits_opcode),
  //   .io_in_a_bits_param(TLMonitor_io_in_a_bits_param),
  //   .io_in_a_bits_size(TLMonitor_io_in_a_bits_size),
  //   .io_in_a_bits_source(TLMonitor_io_in_a_bits_source),
  //   .io_in_a_bits_address(TLMonitor_io_in_a_bits_address),
  //   .io_in_a_bits_mask(TLMonitor_io_in_a_bits_mask),
  //   .io_in_a_bits_corrupt(TLMonitor_io_in_a_bits_corrupt),
  //   .io_in_d_ready(TLMonitor_io_in_d_ready),
  //   .io_in_d_valid(TLMonitor_io_in_d_valid),
  //   .io_in_d_bits_size(TLMonitor_io_in_d_bits_size),
  //   .io_in_d_bits_source(TLMonitor_io_in_d_bits_source)
  // );
  BootROM rom ( // @[ROMGenerator.scala 27:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450359.4]
    .q(rom_q),
    .me(rom_me),
    .oe(rom_oe),
    .address(rom_address),
    .clock(rom_clock)
  );
  assign _T_156 = auto_in_a_bits_address - 17'h10000; // @[MaskROM.scala 42:54:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450366.4]
  assign _T_157 = $unsigned(_T_156); // @[MaskROM.scala 42:54:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450367.4]
  assign _T_158 = _T_157[16:0]; // @[MaskROM.scala 42:54:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450368.4]
  assign _T_159 = _T_158[16:2]; // @[Edges.scala 192:34:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450369.4]
  assign _T_172 = d_full == 1'h0; // @[MaskROM.scala 55:33:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450395.4]
  assign in_a_ready = auto_in_d_ready | _T_172; // @[MaskROM.scala 55:30:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450396.4]
  assign _T_161 = in_a_ready & auto_in_a_valid; // @[Decoupled.scala 37:37:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450373.4]
  assign _T_170 = auto_in_d_ready & d_full; // @[Decoupled.scala 37:37:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450386.4]
  assign auto_in_a_ready = auto_in_d_ready | _T_172; // @[LazyModule.scala 173:31:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450358.4]
  assign auto_in_d_valid = d_full; // @[LazyModule.scala 173:31:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450358.4]
  assign auto_in_d_bits_size = d_size; // @[LazyModule.scala 173:31:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450358.4]
  assign auto_in_d_bits_source = d_source; // @[LazyModule.scala 173:31:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450358.4]
  assign auto_in_d_bits_data = _T_167 ? rom_q : _T_169; // @[LazyModule.scala 173:31:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450358.4]
  assign TLMonitor_clock = clock; // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450323.4]
  assign TLMonitor_reset = reset; // @[:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450324.4]
  assign TLMonitor_io_in_a_ready = auto_in_d_ready | _T_172; // @[Nodes.scala 26:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450357.4]
  assign TLMonitor_io_in_a_valid = auto_in_a_valid; // @[Nodes.scala 26:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450357.4]
  assign TLMonitor_io_in_a_bits_opcode = auto_in_a_bits_opcode; // @[Nodes.scala 26:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450357.4]
  assign TLMonitor_io_in_a_bits_param = auto_in_a_bits_param; // @[Nodes.scala 26:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450357.4]
  assign TLMonitor_io_in_a_bits_size = auto_in_a_bits_size; // @[Nodes.scala 26:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450357.4]
  assign TLMonitor_io_in_a_bits_source = auto_in_a_bits_source; // @[Nodes.scala 26:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450357.4]
  assign TLMonitor_io_in_a_bits_address = auto_in_a_bits_address; // @[Nodes.scala 26:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450357.4]
  assign TLMonitor_io_in_a_bits_mask = auto_in_a_bits_mask; // @[Nodes.scala 26:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450357.4]
  assign TLMonitor_io_in_a_bits_corrupt = auto_in_a_bits_corrupt; // @[Nodes.scala 26:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450357.4]
  assign TLMonitor_io_in_d_ready = auto_in_d_ready; // @[Nodes.scala 26:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450357.4]
  assign TLMonitor_io_in_d_valid = d_full; // @[Nodes.scala 26:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450357.4]
  assign TLMonitor_io_in_d_bits_size = d_size; // @[Nodes.scala 26:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450357.4]
  assign TLMonitor_io_in_d_bits_source = d_source; // @[Nodes.scala 26:19:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450357.4]
  assign rom_me = in_a_ready & auto_in_a_valid; // @[MaskROM.scala 44:15:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450374.4]
  assign rom_oe = 1'h1; // @[MaskROM.scala 43:15:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450372.4]
  assign rom_address = _T_159[10:0]; // @[MaskROM.scala 42:20:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450371.4]
  assign rom_clock = clock; // @[MaskROM.scala 41:18:sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.fir@450365.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  d_full = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  d_size = _RAND_1[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  d_source = _RAND_2[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  _T_167 = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  _T_169 = _RAND_4[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      d_full <= 1'h0;
    end else begin
      if (_T_161) begin
        d_full <= 1'h1;
      end else begin
        if (_T_170) begin
          d_full <= 1'h0;
        end
      end
    end
    if (_T_161) begin
      d_size <= auto_in_a_bits_size;
    end
    if (_T_161) begin
      d_source <= auto_in_a_bits_source;
    end
    _T_167 <= in_a_ready & auto_in_a_valid;
    if (_T_167) begin
      _T_169 <= rom_q;
    end
  end
endmodule