`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:03:56 10/07/2018 
// Design Name: 
// Module Name:    control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module control#(
parameter addrLength = 11
)(
	input reset,
	input clk,
	output address
    );
	 
wire [addrLength - 1 : 0]addr;
wire [addrLength - 1 : 0]middle_addr;
reg enable = 1;  //wire

pc pc_module(
.new_program_count(middle_addr),
.enable(enable),
.clk(clk),
.reset(reset),
.program_count(addr)
);

adder adder_module(
.value(1),
.old_pc(addr),
.new_pc(middle_addr)
);

endmodule
