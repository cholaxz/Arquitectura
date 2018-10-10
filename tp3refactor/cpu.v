`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:12:33 10/08/2018 
// Design Name: 
// Module Name:    cpu 
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
module cpu#(
	parameter ADDR_LENGTH = 11,
	parameter INSTRUCTION_LENGTH = 16,
	parameter DATA_LENGTH = 16,
	parameter OPCODE_LENGTH = 5,
	parameter OPERAND_LENGTH = 11
)(
	input clk,
	input reset,
	input [INSTRUCTION_LENGTH - 1 : 0]instruction,
	input [DATA_LENGTH - 1 : 0]data_from_dm,
	output [DATA_LENGTH - 1 : 0]data_to_dm,
	output [ADDR_LENGTH - 1 : 0]addr_to_pm,
	output [ADDR_LENGTH - 1 : 0]addr_to_dm,
	output RdRam,
	output WrRam
    );
	 
wire [OPCODE_LENGTH - 1 : 0]opcode;
wire [OPERAND_LENGTH - 1 : 0]operand;

assign opcode = instruction[INSTRUCTION_LENGTH - 1 : INSTRUCTION_LENGTH - OPCODE_LENGTH]; //Los bits mas significativos
assign operand = instruction[OPERAND_LENGTH - 1 : 0]; //Los bits menos significativos
assign addr_to_dm = operand;

wire [1:0] SelA;
wire SelB;
wire WrAcc;
wire Op;

control control(
.reset(reset),
.clk(clk),
.opcode(opcode),
.address(addr_to_pm),
.SelA(SelA),
.SelB(SelB),
.WrAcc(WrAcc),
.Op(Op),
.WrRam(WrRam),
.RdRam(RdRam)
);

datapath datapath(
.reset(reset),
.clk(clk),
.imm_operand(operand),
.data_from_memory(data_from_dm),
.SelA(SelA),
.SelB(SelB),
.WrAcc(WrAcc),
.Op(Op),
.out_accumulator(data_to_dm)
);

endmodule
