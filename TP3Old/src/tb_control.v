`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:15:11 10/07/2018
// Design Name:   control
// Module Name:   /home/agustin/Documents/Practicos/tp3/tp3/tb_control.v
// Project Name:  tp3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_control;

	parameter OPCODE_LENGTH = 5;
	parameter ADDRESS_LENGTH = 11;

	// Inputs
	reg reset;
	reg clk;
	reg [OPCODE_LENGTH - 1: 0] opcode;
	// Outputs
	wire [ADDRESS_LENGTH - 1 : 0]address;

	// Instantiate the Unit Under Test (UUT)
	control uut (
		.reset(reset), 
		.clk(clk), 
		.opcode(opcode),
		.address(address)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;
		opcode = 0;
		
		// Wait 10 ns for global reset to finish
		#5
		// Add stimulus here		
		#10 opcode = 1;
		#10 opcode = 2;
		#10 opcode = 3;
		#10 opcode = 4;
		
		
		
		
		#40 $stop;
	end
	
	always
		#5 clk = ~clk;
      
endmodule

