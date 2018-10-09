`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:32:51 10/08/2018 
// Design Name: 
// Module Name:    mux_sel_b 
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
module mux_b#(
	parameter DATA_LENGTH = 16
)(
	input SelB,
	input [DATA_LENGTH - 1 : 0] from_memory,
	input [DATA_LENGTH - 1 : 0] from_signal,
	output reg [DATA_LENGTH - 1 : 0] outValue
   );
	
	localparam MEMORY 		= 1'b0;
	localparam SIGNAL 		= 1'b1;

always @(*)
begin
case(SelB)
	MEMORY:
		outValue = from_memory;
	SIGNAL:
		outValue = from_signal;
endcase
end

endmodule