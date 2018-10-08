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

	// Inputs
	reg reset;
	reg clk;

	// Outputs
	wire address;

	// Instantiate the Unit Under Test (UUT)
	control uut (
		.reset(reset), 
		.clk(clk), 
		.address(address)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;

		// Wait 10 ns for global reset to finish
		#10
		// Add stimulus here		
		
		
		
		
		#50 $stop;
	end
	
	always
		#5 clk = ~clk;
      
endmodule

