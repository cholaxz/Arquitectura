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
parameter addrLength = 11,
parameter OPCODE_LENGTH = 5
)(
	input reset,
	input clk,
	input [OPCODE_LENGTH - 1: 0] opcode,
	output[addrLength - 1 : 0] address,
	output [1:0]SelA,
	output SelB,
	output WrAcc,
	output Op,
	output WrRam,
	output RdRam
    );

wire [addrLength - 1 : 0]addr;
wire [addrLength - 1 : 0]middle_addr;
wire WrPC;

assign address = addr;

instruction_decoder decoder(
.opcode(opcode),
.WrPC(WrPC),
.SelA(SelA),
.SelB(SelB),
.WrAcc(WrAcc),
.Op(Op),
.WrRam(WrRam),
.RdRam(RdRam)
);

pc pc_module(
.new_program_count(middle_addr),
.enable(WrPC),
.clk(clk),
.reset(reset),
.program_count(addr)
);

adder adder_module(
.value(1'b1),
.old_pc(addr),
.new_pc(middle_addr)
);

endmodule
