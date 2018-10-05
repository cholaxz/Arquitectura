`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:44:38 10/05/2018
// Design Name:   ttx
// Module Name:   /home/uart/tb_ttx.v
// Project Name:  uart
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ttx
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_ttx;

	// Inputs
	reg reset;
	reg tx_start;
	reg clk;
	reg tick;
	reg parity;
	reg [1:0] stop_bits;
	reg [7:0] d_in;

	// Outputs
	wire tx_done;
	wire tx_out;

	// Instantiate the Unit Under Test (UUT)
	ttx uut (
		.reset(reset), 
		.tx_start(tx_start), 
		.clk(clk), 
		.tick(tick), 
		.parity(parity), 
		.stop_bits(stop_bits), 
		.d_in(d_in), 
		.tx_done(tx_done), 
		.tx_out(tx_out)
	);
	integer data, clock, ticks, index, data_length;
	initial begin
		// Initialize Inputs
		reset = 0;
		tx_start = 0;
		clk = 0;
		tick = 0;
		parity = 1;
		stop_bits = 1;
		d_in = 250;



		data_length = 8 + parity;
		// Wait 100 ns for global reset to finish
		#1;
		
		//IDLE
		tx_start=1;
		#1;
		clk=1;
		#1;
		clk=0;
		#1;
		//START
		for(index = 0; index < 32; index = index + 1)
		begin
		tick = ~tick;
		for(clock = 0; clock < 10; clock = clock + 1 )
		begin
		clk = ~clk;
		#0.1;
		end
		end
		//DATA
		for(data = 0; data < data_length; data = data + 1)
		begin
			for (ticks = 0; ticks < 32; ticks = ticks + 1)
			begin
				tick = ~tick;
				for(clock = 0; clock < 10; clock = clock + 1)
				begin
				#0.1;
				clk = ~clk;
				end
			end
			
		end
		//STOP
		for(index = 0; index < 32; index = index + 1)
		begin
		tick = ~tick;
		for(clock = 0; clock < 10; clock = clock + 1 )
		begin
		clk = ~clk;
		#0.1;
		end
		end
		
		//FINISH
		for(clock = 0; clock < 10; clock = clock + 1)
		begin
		clk = ~clk;
		#0.1;
		end
		reset=1;
		for(clock = 0; clock < 10; clock = clock + 1)
		begin
		clk = ~clk;
		#0.1;
		end
		
		reset = 0;
		for(clock = 0; clock < 10; clock = clock + 1)
		begin
		clk = ~clk;
		#0.1;
		end
		
	end
	
      
endmodule



