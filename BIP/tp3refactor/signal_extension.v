`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:49:16 10/08/2018 
// Design Name: 
// Module Name:    signal_extension 
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
module signal_extension#(
	parameter IN_OPERAND_LENGTH = 11,
	parameter EXPECTED_LENGTH = 16
)(
	input [IN_OPERAND_LENGTH - 1 : 0] inOperand,
	output [EXPECTED_LENGTH - 1 : 0] outOperand
	);

assign outOperand[EXPECTED_LENGTH - 1 : IN_OPERAND_LENGTH] = 0;
assign outOperand[IN_OPERAND_LENGTH - 1 : 0] = inOperand[IN_OPERAND_LENGTH - 1 : 0];


endmodule
