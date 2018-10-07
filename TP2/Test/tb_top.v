`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:53:28 10/05/2018
// Design Name:   top_interface
// Module Name:   /home/uart/tb_int.v
// Project Name:  uart
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_interface
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_int;

	// Inputs
	reg clock;
	reg rx;

	// Outputs
	wire tx;

	// Instantiate the Unit Under Test (UUT)
	top_interface uut (
		.clock(clock), 
		.rx(rx), 
		.tx(tx)
	);
	integer clock;
	initial begin
		// Initialize Inputs
		clock = 0;
		rx = 1;

		// Wait 100 ns for global reset to finish
		for(clock = 0; clock < 20; clock = clock + 1)
		begin
		clock = ~clock;
		#0.1;
		end
		
        
		// Add stimulus here
		rx = 0;
		for(clock = 0; clock < 1000*1000; clock = clock + 1)
		begin
		clock = ~clock;
		#0.1;
		end
		
	end
      
endmodule


