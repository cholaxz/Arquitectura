`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:56:50 10/08/2018 
// Design Name: 
// Module Name:    data_memory 
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
module data_memory#(
	parameter ADDR_LENGTH = 11,
	parameter DATA_LENGTH = 16
)(
	input clk,
	input [1:0]WrRd,
	input [ADDR_LENGTH - 1 : 0]addr,
	input[DATA_LENGTH - 1 : 0] inData,
	output reg[DATA_LENGTH - 1 : 0] outData
   );
	
	parameter MEM_SIZE = 2 ^ ADDR_LENGTH ;
	reg [ADDR_LENGTH - 1 : 0]memory[0 : MEM_SIZE];
	
	localparam WRITE 	= 2'b10;
	localparam READ 	= 2'b01;

always @(negedge clk)
begin
	case(WrRd)
		READ:	
			outData <= memory[addr];
		WRITE:
			memory[addr] <= inData;
	endcase
		
end

endmodule