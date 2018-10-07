`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:07:09 10/07/2018
// Design Name:   interface
// Module Name:   /home/agustin/tp2/tb_interface.v
// Project Name:  tp2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: interface
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_interface;

	// Inputs
	reg reset;
	reg [7:0] d_in;
	reg [7:0] alu_res;
	reg rx_done;
	reg tx_done;
	reg clk;

	// Outputs
	wire tx_start;
	wire [7:0] d_out;
	wire [7:0] a;
	wire [7:0] b;
	wire [7:0] op;

	// Instantiate the Unit Under Test (UUT)
	interface uut (
		.reset(reset), 
		.d_in(d_in), 
		.alu_res(alu_res), 
		.rx_done(rx_done), 
		.tx_done(tx_done), 
		.tx_start(tx_start), 
		.d_out(d_out), 
		.a(a), 
		.b(b), 
		.op(op), 
		.clk(clk)
	);
	
	initial begin
		// Initialize Inputs
		reset = 0;
		d_in = 0;
		alu_res = 0;
		rx_done = 0;
		tx_done = 0;
		clk = 0;	
		
		#20 d_in = 10; rx_done = 1;
		#20 rx_done = 0;
		#20 d_in = 9; rx_done = 1;
		#20 rx_done = 0;
		#20 d_in = 2; rx_done = 1;
		#20 rx_done = 0; alu_res = 3;
		
		#160 $stop;
		
	end
	
	always
		#10 clk = ~clk;
	
	
endmodule


