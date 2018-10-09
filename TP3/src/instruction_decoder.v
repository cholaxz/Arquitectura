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
	output reg WrPC,	/* 0: Enable PC / 1: Not enable PC*/
	output reg[1:0] SelA,
	output reg SelB,
	output reg WrAcc,
	output reg Op, 	/* 0: Sum / 1: Substraction */
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
/* No entiendo Sel A y Sel B */
always @(*)
case(opcode)
	HLT:
		begin
			WrPC 	= 0;
			SelA 	= 0;
			SelB 	= 0;
			WrAcc = 0;
			Op 	= 0;
			WrRam = 0;
			RdRam = 0;
		end
	STO:
		begin
			WrPC 	= 1;
			SelA 	= 0;
			SelB 	= 0;
			WrAcc = 0;
			Op 	= 0;
			WrRam = 1;
			RdRam = 0;
		end
	LD:
		begin
			WrPC 	= 1;
			SelA 	= 0;
			SelB 	= 0;
			WrAcc = 1;
			Op 	= 0;
			WrRam = 0;
			RdRam = 1;
		end
	LDI:
		begin
			WrPC 	= 1;
			SelA 	= 1;
			SelB 	= 0;
			WrAcc = 1;
			Op 	= 0;
			WrRam = 0;
			RdRam = 0;
		end
	ADD:
		begin
			WrPC 	= 1;
			SelA 	= 2;
			SelB 	= 0;
			WrAcc = 1;
			Op 	= 0;
			WrRam = 0;
			RdRam = 1;
		end
	ADDI:
		begin
			WrPC 	= 1;
			SelA 	= 2;
			SelB 	= 1;
			WrAcc = 1;
			Op 	= 0;
			WrRam = 0;
			RdRam = 0;
		end
	SUB:
		begin
			WrPC 	= 1;
			SelA 	= 2;
			SelB 	= 0;
			WrAcc = 1;
			Op 	= 1;
			WrRam = 0;
			RdRam = 1;
		end	
	SUBI:
		begin
			WrPC 	= 1;
			SelA 	= 2;
			SelB 	= 1;
			WrAcc = 1;
			Op 	= 1;
			WrRam = 0;
			RdRam = 0;
		end
	default: //by default we halt
		begin
			WrPC = 0;
			SelA = 0;
			SelB = 0;
			WrAcc = 0;
			Op = 0;
			WrRam = 0;
			RdRam = 0;
		end
endcase
endmodule
