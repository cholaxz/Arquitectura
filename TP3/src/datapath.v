`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:54:03 10/08/2018 
// Design Name: 
// Module Name:    datapath 
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
module datapath#(
	parameter IMM_DATA_LENGTH = 11,
	parameter DATA_LENGTH = 16
)(
	input reset,
	input clk,
	input[IMM_DATA_LENGTH - 1 : 0] imm_operand,
	input [DATA_LENGTH - 1 : 0] data_from_memory,
	input [1:0]SelA,
	input SelB,
	input WrAcc,
	input Op,
	output [DATA_LENGTH - 1 : 0] out_accumulator
    );

wire [DATA_LENGTH - 1 : 0]out_signal;
wire [DATA_LENGTH - 1 : 0]out_alu;
wire [DATA_LENGTH - 1 : 0]mux_a_to_accumulator;
wire [DATA_LENGTH - 1 : 0]mux_b_to_alu;

signal_extension extensor(
.inOperand(imm_operand),
.outOperand(out_signal)
);

mux_a mux_a(
.SelA(SelA),
.from_memory(data_from_memory),
.from_signal(out_signal),
.from_alu(out_alu),
.outValue(mux_a_to_accumulator)
);

mux_b mux_b(
.SelB(SelB),
.from_memory(data_from_memory),
.from_signal(out_signal),
.outValue(mux_b_to_alu)
);

accumulator acc(
.enable(WrAcc),
.clk(clk),
.reset(reset),
.inValue(mux_a_to_accumulator),
.outValue(out_accumulator)
);

alu alu(
.from_accumulator(out_accumulator),
.from_muxb(mux_b_to_alu),
.op(Op),
.outValue(out_alu)
);

endmodule
