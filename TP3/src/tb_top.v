`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:47:58 10/09/2018
// Design Name:   top
// Module Name:   /home/agustin/Desktop/Proyectos/code/tb_top.v
// Project Name:  tp3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_top;

	// Inputs
	reg clk;
	reg [7:0] d_in;
	reg rx_done;
	reg tx_done;

	// Outputs
	wire [7:0] d_out;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.d_in(d_in), 
		.rx_done(rx_done), 
		.tx_done(tx_done), 
		.d_out(d_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		d_in = 0;
		rx_done = 0;
		tx_done = 0;

		// Wait 100 ns for global reset to finish
		//Load IMM
		#10 d_in = 8'b00000010; rx_done = 1; //Codigo PM
		#10 d_in = 8'b00000000; rx_done = 1; //Addr0
		#10 d_in = 8'b00000000; rx_done = 1; //Addr0
		#10 d_in = 8'b00001111; rx_done = 1; //instruction0lsb
		#10 d_in = 8'b00011000; rx_done = 1; //instruction0msb
		
		#5  rx_done = 0;
		#5;
		
		//Store Acc
		#10 d_in = 8'b00000010; rx_done = 1; //Codigo PM
		#10 d_in = 8'b00000001; rx_done = 1; //Addr0LSB
		#10 d_in = 8'b00000000; rx_done = 1; //Addr0MSB
		#10 d_in = 8'b00000000; rx_done = 1; //instruction0LSB
		#10 d_in = 8'b00001000; rx_done = 1; //instruction0MSB
		#5  rx_done = 0;
		#5;

		//HALT
		#10 d_in = 8'b00000010; rx_done = 1; //Codigo PM
		#10 d_in = 8'b00000010; rx_done = 1; //Addr0LSB
		#10 d_in = 8'b00000000; rx_done = 1; //Addr0MSB
		#10 d_in = 8'b00000000; rx_done = 1; //instruction0LSB
		#10 d_in = 8'b00000000; rx_done = 1; //instruction0MSB
		#5  rx_done = 0;
		#5;
	
		//START
		#10 d_in = 8'b00000001; rx_done = 1; //Codigo START
		#1 rx_done = 0;
		#9;
		#70;
		
		#10 d_in = 8'b00000100; rx_done = 1; //Codigo READ
		#10 d_in = 8'b00000000; rx_done = 1; //Addr0LSB
		#10 d_in = 8'b00000000; rx_done = 1; //Addr0MSB
		
		#2.5 rx_done = 0;
		#7.5 $stop;
		

	end
	
	always
		#5 clk = ~clk;
      
endmodule

