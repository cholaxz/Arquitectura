`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:00:54 10/07/2018 
// Design Name: 
// Module Name:    adder 
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
module adder#(
parameter LENGTH = 11
)(
	input value,
	input[LENGTH - 1: 0] old_pc,
	output [LENGTH - 1 : 0]new_pc
    );

assign new_pc = old_pc + value;

endmodule
