`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:57:58 10/08/2018
// Design Name:   topbip
// Module Name:   /home/agustin/Desktop/Arquitectura/TP3/code/tb_topbip.v
// Project Name:  tp3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: topbip
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_topbip;

	// Inputs
	reg reset;
	reg clk;

	// Instantiate the Unit Under Test (UUT)
	topbip uut (
		.reset(reset), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#10;
       
		#100 $stop;
		// Add stimulus here

	end
	
	always
		#5 clk = ~clk;
      
endmodule

