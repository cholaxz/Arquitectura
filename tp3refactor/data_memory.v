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
	parameter data = ""
)(
	input clk,
	input [1:0]WrRdInterface,
	input [1:0]WrRdBip,
	input [ADDR_LENGTH - 1 : 0]addr_from_bip,
	input [ADDR_LENGTH - 1 : 0]addr_from_interface,
	input[DATA_LENGTH - 1 : 0] data_from_bip,
	input[DATA_LENGTH - 1 : 0] data_from_interface,
	output reg[DATA_LENGTH - 1 : 0] outData
   );
	
	localparam MEM_SIZE = 2 ^ ADDR_LENGTH ;
	reg [DATA_LENGTH - 1 : 0]memory[0 : 9];
	
	localparam WRITE 	= 2'b10;
	localparam READ 	= 2'b01;
	
/*
initial begin
	outData = 0;
if(data != "")
	$readmemb(data, memory);
else
	begin
		memory[0] = 16'b1000000000000001; 
		memory[1] = 16'b0000000000000001;
		memory[2] = 16'b0000000000000010; 
		memory[3] = 16'b0000000000000011; 
	end
end
*/
initial begin
		outData = 6;
		memory[0] = 1; 
		memory[1] = 2;
		memory[2] = 3; 
		memory[3] = 4; 
end

always @(negedge clk)
begin
	case(WrRdBip)
		READ:	
			outData <= memory[addr_from_bip];
		WRITE:
			memory[addr_from_bip] <= data_from_bip;
	endcase
	
	case(WrRdInterface)
		READ:	
			outData <= memory[addr_from_interface];
		WRITE:
			memory[addr_from_interface] <= data_from_interface;
	endcase
end

endmodule