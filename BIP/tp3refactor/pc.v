`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:37:16 10/07/2018 
// Design Name: 
// Module Name:    pc 
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
module pc#(
parameter LENGTH = 11
)
(
	input [LENGTH - 1 : 0]new_program_count,
	input enable,
	input clk,
	input reset,
	output reg [LENGTH - 1 : 0]program_count
   );
	 
	initial program_count = 0;
	
	always@(negedge clk) //antes era pos edge
	begin
	if(reset)	//reset sincrono, antes era asincrono
	begin
		program_count = 0;
	end
	else 
		if(enable)
			program_count = new_program_count;
	end

endmodule
