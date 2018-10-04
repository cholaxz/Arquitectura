`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:14:59 10/04/2018
// Design Name:   rrx
// Module Name:   /home/agustin/tp2/tb_rrx.v
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

module tb_rrx;

	// Inputs
	reg reset;
	reg rx;
	reg clk;
	reg tick;
	reg parity;
	reg[1:0] stop_bits;

	// Outputs
	wire [7:0] d_out;
	wire rx_done;

	// Instantiate the Unit Under Test (UUT)
	rrx uut (
		.reset(reset),
		.rx(rx), 
		.clk(clk), 
		.tick(tick), 
		.parity(parity), 
		.stop_bits(stop_bits),
		.d_out(d_out), 
		.rx_done(rx_done)
	);

	integer data, clock, ticks, index, data_length;
	initial begin
		// Initialize Inputs
		reset=0;
		rx = 1;
		clk = 0;
		tick = 0;
		parity = 1;
		stop_bits = 2'b01;
		
		data_length = 8 + parity;

		// Wait 100 ns for global reset to finish
		#1;
		
		//IDLE
		rx=0;
		#1;
		clk=1;
		#1;
		clk=0;
		#1;
		//START
		for(index = 0; index < 16; index = index + 1)
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
			rx = ~rx;
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
		rx = 1;
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

