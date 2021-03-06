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
	parameter DATA_LENGTH = 16,
	parameter data = "/home/agustin/Desktop/Arquitectura/TP3/code/data.bin"
)(
	input clk,
	input [1:0]WrRd,
	input [ADDR_LENGTH - 1 : 0]addr,
	input[DATA_LENGTH - 1 : 0] inData,
	output reg[DATA_LENGTH - 1 : 0] outData
   );
	
	localparam MEM_SIZE = 2 ^ ADDR_LENGTH ;
	reg [DATA_LENGTH - 1 : 0]memory[0 : MEM_SIZE];
	
	localparam WRITE 	= 2'b10;
	localparam READ 	= 2'b01;
	

initial begin
if(data != "")
	$readmemb(data, memory);
else
	begin
		memory[0] = 16'b0000000000000000; 
		memory[1] = 16'b0000000000000001; 
		memory[2] = 16'b0000000000000010; 
		memory[3] = 16'b0000000000000011; 
	end
end


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