`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:44:31 10/08/2018 
// Design Name: 
// Module Name:    alu 
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
module alu#(
	parameter DATA_LENGTH = 16
)(
	input [DATA_LENGTH - 1 : 0] from_accumulator,
	input [DATA_LENGTH - 1 : 0] from_muxb,
	input op, //operation
	output reg [DATA_LENGTH - 1 : 0] outValue
   );

localparam ADD = 1'b0;
localparam SUB = 1'b1;

always@(*)
begin
	case(op)
		ADD:
			outValue = from_accumulator + from_muxb;
		SUB:
			outValue = from_accumulator - from_muxb;
		endcase
end


endmodule
