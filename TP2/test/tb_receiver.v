`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:30:14 10/07/2018
// Design Name:   rrx
// Module Name:   /home/agustin/tp2/tb_rrx_new.v
// Project Name:  tp2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rrx
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_rrx_new;

	// Inputs
	reg reset;
	reg rx;
	reg clk;
	reg tick;
	reg parity ;
	reg [1:0] stop_bits;

	// Outputs
	wire [7:0] d_out;
	wire rx_done;
	wire error;

	// Instantiate the Unit Under Test (UUT)
	rrx uut (
		.reset(reset), 
		.rx(rx), 
		.clk(clk), 
		.tick(tick), 
		.parity(parity), 
		.stop_bits(stop_bits), 
		.d_out(d_out), 
		.rx_done(rx_done), 
		.error(error)
	);

	integer data;
	initial begin
		// Initialize Inputs
		reset = 0;
		rx = 1;
		clk = 0;
		tick = 0;
		parity = 1;
		stop_bits = 1;
        
		#10;
		// Add stimulus here
		//IDLE
		#10 rx = 0;
		//START
		#16;
		//DATA
		for(data = 0; data < 8; data = data + 1)
		begin
		#32 rx = ~rx;
		end
		//PARITY
		rx = 1;
		#32
		//STOP
		rx = 1;
		#32;
		//IDLE
		#10;
		
		#5 $stop;
	end
	
	always begin
		#0.1 clk = ~clk;
	end
	always begin
		#1 tick = ~tick;
	end
      
endmodule

