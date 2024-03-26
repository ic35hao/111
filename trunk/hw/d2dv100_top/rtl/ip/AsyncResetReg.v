
module AsyncResetReg #(parameter RESET_VALUE = 0)(d, q, en, clk, rst);

input  wire d;
output reg  q;
input  wire en;
input  wire clk;
input  wire rst;

   always @(posedge clk or posedge rst) begin

      if (rst) begin
         q <= RESET_VALUE;
      end else if (en) begin
         q <= d;
      end
   end
 
endmodule // AsyncResetReg