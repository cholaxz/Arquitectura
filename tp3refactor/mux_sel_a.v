`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:22:39 10/08/2018 
// Design Name: 
// Module Name:    mux_sel_a 
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
module mux_a#(
	parameter DATA_LENGTH = 16
)(
	input [1:0] SelA,
	input [DATA_LENGTH - 1 : 0] from_memory,
	input [DATA_LENGTH - 1 : 0] from_signal,
	input [DATA_LENGTH - 1 : 0] from_alu,
	output reg [DATA_LENGTH - 1 : 0] outValue
   );
	
	localparam MEMORY 		= 2'b00;
	localparam SIGNAL 		= 2'b01;
	localparam ALU 	= 2'b10;

always @(*)
begin
case(SelA)
	MEMORY:
		outValue = from_memory;
	SIGNAL:
		outValue = from_signal;
	ALU:
		outValue = from_alu;
	default:
		outValue = from_memory;
endcase
end

endmodule
