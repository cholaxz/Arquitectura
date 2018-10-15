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
	
	initial begin
		// Initialize Inputs
	clock = 0;
	rx = 1;
	
	//Data 1
	#5 rx = 0; //Start;
	#15 rx = 1; //Bit 1;
	#20 rx = 0;	//Bit 2;
	#145 rx = 1;
	#25;
	
	//Data 2
	#5 rx = 0; //Start;
	#15 rx = 1; //Bit 1 and Bit 2;
	#45 rx = 0;
	#120 rx = 1;
	#25;
	
	//Opcode
	#5 rx = 0; //Start;
	#124 rx = 1;
	#24 rx = 0;
	#32 rx = 1;
	#25;
	
	
	#250 $stop;

	
	end	
       	
	always
	#0.001 clock = ~clock;
	//Baud rate = 163
      
endmodule


