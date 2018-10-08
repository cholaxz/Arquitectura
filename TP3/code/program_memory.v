`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:38:03 10/08/2018 
// Design Name: 
// Module Name:    program_memory 
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
module program_memory#(
	parameter ADDR_LENGTH = 11
)(
	input clk,
	input [ADDR_LENGTH - 1 : 0]addr,
	output reg[ADDR_LENGTH - 1 : 0] instruction
   );
	
	parameter MEM_SIZE = 2 ^ ADDR_LENGTH ;
	reg [ADDR_LENGTH - 1 : 0]memory[0 : MEM_SIZE];

always @(posedge clk)
begin
	instruction <= memory[addr];
end

endmodule
