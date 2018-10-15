`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:25:53 10/08/2018
// Design Name:   datapath
// Module Name:   /home/agustin/Desktop/Arquitectura/TP3/code/tb_datapath.v
// Project Name:  tp3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: datapath
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_datapath;

	// Inputs
	reg reset;
	reg clk;
	reg [10:0] imm_operand;
	reg [15:0] data_from_memory;
	reg [1:0] SelA;
	reg SelB;
	reg WrAcc;
	reg Op;

	// Outputs
	wire [15:0] out_accumulator;

	// Instantiate the Unit Under Test (UUT)
	datapath uut (
		.reset(reset), 
		.clk(clk), 
		.imm_operand(imm_operand), 
		.data_from_memory(data_from_memory), 
		.SelA(SelA), 
		.SelB(SelB), 
		.WrAcc(WrAcc), 
		.Op(Op), 
		.out_accumulator(out_accumulator)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;
		imm_operand = 0;
		data_from_memory = 0;
		SelA = 0;
		SelB = 0;
		WrAcc = 0;
		Op = 0;

		// Wait 100 ns for global reset to finish
		#10;
        
		//LOAD IMM
		imm_operand = 5;
		SelA = 1;
		WrAcc = 1;
		#10;
		
		//Add Imm
		imm_operand = 4;
		SelA = 2;
		SelB = 1;
		#10;
		
		//Halt
		WrAcc = 0;
		SelA = 0;
		SelB = 0;
		#10;
		
		#30 $stop;
		

	end
	
	always
	#5 clk = ~clk;
      
endmodule

