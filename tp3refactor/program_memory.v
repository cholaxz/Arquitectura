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
	parameter ADDR_LENGTH = 11,
	parameter DATA_LENGTH = 16,
	parameter program = ""
)(
	input clk,
	input [ADDR_LENGTH - 1 : 0]addrFromBip,
	input [ADDR_LENGTH - 1 : 0]addrFromInterface,
	input Wr,
	input[DATA_LENGTH - 1 : 0] dataFromInterface,
	output reg[DATA_LENGTH - 1 : 0] instruction
   );
	
	localparam MEM_SIZE = 2 ^ ADDR_LENGTH ;
	reg [DATA_LENGTH - 1 : 0]memory[0 : 5];
	
	
	initial begin
		begin
			memory[0] = 16'b0001100000000101; //LDI 5
			memory[1] = 16'b0010000000000010; //Add Acc + Addr2
			memory[2] = 16'b0000100000000000; //Store Acc in Addr0
			memory[3] = 16'b0000000000000000; //Halt
			memory[4] = 16'b0000000000000000; //Halt
			memory[5] = 16'b0000000000000000; //Halt

		end
	end

always @(posedge clk)
begin
	if(Wr == 1)
		memory[addrFromInterface] <= dataFromInterface;
	else
		instruction <= memory[addrFromBip];
end

endmodule