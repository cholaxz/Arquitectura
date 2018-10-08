`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:27:47 10/07/2018 
// Design Name: 
// Module Name:    instruction_decoder 
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
module instruction_decoder#(parameter OPCODE_LENGTH = 5)(
	input[OPCODE_LENGTH - 1 : 0] opcode,
	output reg WrPC,
	output reg[1:0] SelA,
	output reg SelB,
	output reg WrAcc,
	output reg Op,
	output reg WrRam,
	output reg RdRam
   );

localparam HLT 	= 5'b00000;
localparam STO 	= 5'b00001;
localparam LD 		= 5'b00010;
localparam LDI 	= 5'b00011;
localparam ADD 	= 5'b00100;
localparam ADDI 	= 5'b00101;
localparam SUB 	= 5'b00110;
localparam SUBI 	= 5'b00111;

/* Combination Logic */
always @(*)
case(opcode)
	HLT:
		begin
		end
	STO:
		begin
		end
	LD:
		begin
		end
	LDI:
		begin
		end
	ADD:
		begin
		end
	ADDI:
		begin
		end
	SUB:
		begin
		end	
	SUBI:
		begin
		end
	default: //by default we halt
		begin
		end
endcase
endmodule
