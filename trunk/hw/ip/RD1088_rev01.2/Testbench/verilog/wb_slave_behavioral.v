//////////////////////////////////////////////////////////////////////////////////////////////
////                                                              ////
////  sd_controller_top_tb.v                                      ////
////                                                              ////
////  This file is part of the SD IP core project                 ////
//// http://www.opencores.org/?do=project&who=sdcard_mass_storage_controller                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Adam Edvardsson, adam@opencores.org                   ////
////                                                              ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//// WB Model, ideas and task borrowed from:                    ////
//// http://www.opencores.org/projects/ethmac/                    ////
////  Author(s):                                                  ////
////      - Tadej Markovic, tadej@opencores.org                   ////
////      - Igor Mohor,     igorM@opencores.org                   ////
//////////////////////////////////////////////////////////////////////
////
                                            ////
//// Copyright (C) 2001, 2002 Authors                             ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//`define TX_ERROR_TEST
//---------------------------------------------------------------------
// Copyright (c) 2010 by Lattice Semiconductor Corporation
//---------------------------------------------------------------------
// Disclaimer:
//
// This VHDL or Verilog source code is intended as a design reference
// which illustrates how these types of functions can be implemented.
// It is the user's responsibility to verify their design for
// consistency and functionality through the use of formal
// verification methods. Lattice Semiconductor provides no warranty
// regarding the use or functionality of this code.
//
// --------------------------------------------------------------------
//
// Lattice Semiconductor Corporation
// 5555 NE Moore Court
// Hillsboro, OR 97214
// U.S.A
//
// TEL: 1-800-Lattice (USA and Canada)
// 503-268-8001 (other locations)
//
// web: http://www.latticesemi.com/
// email: techsupport@latticesemi.com
//
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Ver: | Author     |Mod. Date |Changes Made:
// V1.0 | Peter.Zhou |03/16/10  |
//
// --------------------------------------------------------------------
//------------------------------------
//
//
`timescale 1ns/1ps
`include "wb_model_defines.v"
module WB_SLAVE_BEHAVIORAL
			(
			CLK_I,
			RST_I,
			ACK_O,
			ADR_I,
			CYC_I,
			DAT_O,
			DAT_I,
			ERR_O,
			RTY_O,
			SEL_I,
			STB_I,
			WE_I,
			CAB_I
			);
/*------------------------------------------------------------------------------------------------------
WISHBONE signals
------------------------------------------------------------------------------------------------------*/
input                   CLK_I;
input                   RST_I;
output                  ACK_O;
input   `WB_ADDR_TYPE   ADR_I;
input                   CYC_I;
output  `WB_DATA_TYPE   DAT_O;
input   `WB_DATA_TYPE   DAT_I;
output                  ERR_O;
output                  RTY_O;
input   `WB_SEL_TYPE    SEL_I;
input                   STB_I;
input                   WE_I;
input                   CAB_I;

reg     `WB_DATA_TYPE   DAT_O;

/*------------------------------------------------------------------------------------------------------
Asynchronous dual-port RAM signals for storing and fetching the data
------------------------------------------------------------------------------------------------------*/
//reg     `WB_DATA_TYPE wb_memory [0:16777215]; // WB memory - 24 addresses connected - 2 LSB not used
reg     `WB_DATA_TYPE 	wb_memory [0:524287]; // WB memory - 20 addresses connected - 2 LSB not used		//from 2^20 to 2^19 for the 2^24 greater than the maximum value memory
reg     `WB_DATA_TYPE 	mem_wr_data_out;
reg     `WB_DATA_TYPE 	mem_rd_data_in;

initial $readmemh("wb_memory.txt",wb_memory);

integer k;
initial 
begin
		$display("Contents of Mem after reading data file:");
		for (k=0; k<10; k=k+1) $display("%d:%h",k,wb_memory[k]);
end

/*------------------------------------------------------------------------------------------------------
Maximum values for WAIT and RETRY counters and which response !!!
------------------------------------------------------------------------------------------------------*/
reg     [2:0]  a_e_r_resp; // tells with which cycle_termination_signal must wb_slave respond !
reg     [3:0]  wait_cyc;
reg     [7:0]  max_retry;
// assign registers to default state while in reset
always@(RST_I)
begin
  	if (RST_I)
  	begin
    		a_e_r_resp <= 3'b100; // do not respond
    		wait_cyc   <= 4'b0; 	// no wait cycles
    		max_retry  <= 8'h0; 	// no retries
  	end
end //reset

task cycle_response;
  input [2:0]  ack_err_rty_resp; 	// acknowledge, error or retry response input flags
  input [3:0]  wait_cycles; 			// if wait cycles before each data termination cycle (ack, err or rty)
  input [7:0]  retry_cycles; 			// noumber of retry cycles before acknowledge cycle
begin
  	// assign values
  	a_e_r_resp <= #1 ack_err_rty_resp;
  	wait_cyc   <= #1 wait_cycles;
  	max_retry  <= #1 retry_cycles;
end
endtask // cycle_response

/*------------------------------------------------------------------------------------------------------
Tasks for writing and reading to and from memory !!!
------------------------------------------------------------------------------------------------------*/
reg    `WB_ADDR_TYPE task_wr_adr_i;
reg    `WB_ADDR_TYPE task_rd_adr_i;
reg    `WB_DATA_TYPE task_dat_i;
reg    `WB_DATA_TYPE task_dat_o;
reg    `WB_SEL_TYPE  task_sel_i;
reg                  task_wr_data;
reg                  task_data_written;
reg    `WB_DATA_TYPE task_mem_wr_data;

// write to memory
task wr_mem;
  input  `WB_ADDR_TYPE adr_i;
  input  `WB_DATA_TYPE dat_i;
  input  `WB_SEL_TYPE  sel_i;
begin
  	task_data_written = 0;
  	task_wr_adr_i 		= adr_i;
  	task_dat_i = dat_i;
  	task_sel_i = sel_i;
  	task_wr_data = 1;
  	wait(task_data_written);
  	task_wr_data = 0;
end
endtask

// read from memory
task rd_mem;
  input  `WB_ADDR_TYPE adr_i;
  output `WB_DATA_TYPE dat_o;
  input  `WB_SEL_TYPE  sel_i;
begin
  	task_rd_adr_i = adr_i;
  	task_sel_i = sel_i;
  	#1;
  	dat_o = task_dat_o;
end
endtask

/*------------------------------------------------------------------------------------------------------
Internal signals and logic
------------------------------------------------------------------------------------------------------*/
reg            calc_ack;
reg            calc_err;
reg            calc_rty;
reg     [7:0]  retry_cnt;
reg     [7:0]  retry_num;
reg            retry_expired;
// Retry counter
always@(posedge RST_I or posedge CLK_I)
begin
  	if (RST_I)
    begin
    		retry_cnt <= #1 8'h00;
    end
  	else
  	begin
    		if (calc_ack || calc_err)
      	begin
      			retry_cnt <= #1 8'h00;
      	end
    		else if (calc_rty)
      	begin
      			retry_cnt <= #1 retry_num;
      	end
  	end
end
////////
always@(retry_cnt or max_retry)
begin
  	if ( retry_cnt < max_retry )
  	begin
    		retry_num 		= retry_cnt + 1'b1;
    		retry_expired = 1'b0;
  	end
  	else
  	begin
    		retry_num 		= retry_cnt;
    		retry_expired = 1'b1;
  	end
end

reg     [3:0]  wait_cnt;
reg     [3:0]  wait_num;
reg            wait_expired;
// Wait counter
always@(posedge RST_I or posedge CLK_I)
begin
  	if (RST_I)
    	wait_cnt <= #1 4'h0;
  	else
  	begin
    		if (wait_expired || ~STB_I)
      			wait_cnt <= #1 4'h0;
    		else
      			wait_cnt <= #1 wait_num;
  	end
end

always@(wait_cnt or wait_cyc or STB_I or a_e_r_resp or retry_expired)
begin
  	if ((wait_cyc > 0) && (STB_I))
  	begin
    		if (wait_cnt < wait_cyc) // 4'h2)
    		begin
      			wait_num = wait_cnt + 1'b1;
      			wait_expired = 1'b0;
      			calc_ack = 1'b0;
      			calc_err = 1'b0;
      			calc_rty = 1'b0;
    		end
    		else
    		begin
      			wait_num = wait_cnt;
      			wait_expired = 1'b1;
      			if (a_e_r_resp == 3'b100)
      			begin
        				calc_ack = 1'b1;
        				calc_err = 1'b0;
        				calc_rty = 1'b0;
      			end
      			else if (a_e_r_resp == 3'b010)
      			begin
        				calc_ack = 1'b0;
        				calc_err = 1'b1;
        				calc_rty = 1'b0;
      			end
      			else if (a_e_r_resp == 3'b001)
      			begin
        				calc_err = 1'b0;
        				if (retry_expired)
        				begin
          					calc_ack = 1'b1;
          					calc_rty = 1'b0;
        				end
        				else
        				begin
          					calc_ack = 1'b0;
          					calc_rty = 1'b1;
        				end
      			end
      			else
      			begin
        				calc_ack = 1'b0;
        				calc_err = 1'b0;
        				calc_rty = 1'b0;
      			end
    		end
  end
  else
  		if ((wait_cyc == 0) && (STB_I))
 		 	begin
    			wait_num = 2'h0;
    			wait_expired = 1'b1;
    			if (a_e_r_resp == 3'b100)
    			begin
    			  	calc_ack = 1'b1;
    			  	calc_err = 1'b0;
    			  	calc_rty = 1'b0;
    			end
    			else if (a_e_r_resp == 3'b010)
    			begin
    			  	calc_ack = 1'b0;
    			  	calc_err = 1'b1;
    			  	calc_rty = 1'b0;
    			end
    			else if (a_e_r_resp == 3'b001)
    			begin
    			  	calc_err = 1'b0;
    			  	if (retry_expired)
    			  	begin
    			  	  calc_ack = 1'b1;
    			  	  calc_rty = 1'b0;
    			  	end
    			  	else
    			  	begin
    			  	  calc_ack = 1'b0;
    			  	  calc_rty = 1'b1;
    			  	end
    			end
    			else
    			begin
      				calc_ack = 1'b0;
      				calc_err = 1'b0;
      				calc_rty = 1'b0;
    			end
  		end
  		else
  		begin
  		  	wait_num = 2'h0;
  		  	wait_expired = 1'b0;
  		  	calc_ack = 1'b0;
  		  	calc_err = 1'b0;
  		  	calc_rty = 1'b0;
  		end
end

wire rd_sel = (CYC_I && STB_I && ~WE_I);
wire wr_sel = (CYC_I && STB_I && WE_I);

// Generate cycle termination signals
assign ACK_O = calc_ack && STB_I;
assign ERR_O = calc_err && STB_I;
assign RTY_O = calc_rty && STB_I;

// Assign address to asynchronous memory
always@(RST_I or ADR_I)
begin
  if (RST_I) // this is added because at start of test bench we need address change in order to get data!
  begin
    #1 mem_rd_data_in = `WB_DATA_WIDTH'hxxxx_xxxx;
  end
  else
  begin
//    #1 mem_rd_data_in = wb_memory[ADR_I[25:2]];
     mem_rd_data_in = #1 wb_memory[ADR_I[21:2]];
  end
end

// Data input/output interface
always@(rd_sel or mem_rd_data_in or RST_I)
begin
  if (RST_I)
    DAT_O <=#2 `WB_DATA_WIDTH'hxxxx_xxxx;	// assign outputs to unknown state while in reset
  else if (rd_sel)
    DAT_O <=#2 mem_rd_data_in;
  //else
   // DAT_O <=#2 `WB_DATA_WIDTH'hxxxx_xxxx;
end


always@(RST_I or task_rd_adr_i)
begin
  if (RST_I)
    task_dat_o = `WB_DATA_WIDTH'hxxxx_xxxx;
  else
    task_dat_o = wb_memory[task_rd_adr_i[21:2]];
end
always@(CLK_I or wr_sel or task_wr_data or ADR_I or task_wr_adr_i or
        mem_wr_data_out or DAT_I or task_mem_wr_data or task_dat_i or
        SEL_I or task_sel_i)
begin
  if (task_wr_data)
  begin
    task_mem_wr_data = wb_memory[task_wr_adr_i[21:2]];

    if (task_sel_i[3])
      task_mem_wr_data[31:24] = task_dat_i[31:24];
    if (task_sel_i[2])
      task_mem_wr_data[23:16] = task_dat_i[23:16];
    if (task_sel_i[1])
      task_mem_wr_data[15: 8] = task_dat_i[15: 8];
    if (task_sel_i[0])
      task_mem_wr_data[ 7: 0] = task_dat_i[ 7: 0];

    wb_memory[task_wr_adr_i[21:2]] = task_mem_wr_data; // write data
    task_data_written = 1;
  end
  else if (wr_sel && ~CLK_I)
  begin
//    mem_wr_data_out = wb_memory[ADR_I[25:2]]; // if no SEL_I is active, old value will be written
    mem_wr_data_out = wb_memory[ADR_I[21:2]]; // if no SEL_I is active, old value will be written

    if (SEL_I[3])
      mem_wr_data_out[31:24] = DAT_I[31:24];
    if (SEL_I[2])
      mem_wr_data_out[23:16] = DAT_I[23:16];
    if (SEL_I[1])
      mem_wr_data_out[15: 8] = DAT_I[15: 8];
    if (SEL_I[0])
      mem_wr_data_out[ 7: 0] = DAT_I[ 7: 0];

//    wb_memory[ADR_I[25:2]]  <= mem_wr_data_out; // write data
    wb_memory[ADR_I[21:2]]  = mem_wr_data_out; // write data
  end
end

endmodule
