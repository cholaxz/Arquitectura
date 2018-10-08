`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:31:26 10/08/2018
// Design Name:   cpu
// Module Name:   /home/agustin/Desktop/Arquitectura/TP3/code/tb_cpu.v
// Project Name:  tp3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_cpu;

	// Inputs
	reg clk;
	reg reset;
	reg [15:0] instruction;
	reg [15:0] data_from_dm;

	// Outputs
	wire [15:0] data_to_dm;
	wire [15:0] addr_to_pm;
	wire [10:0] addr_to_dm;
	wire RdRam;
	wire WrRam;

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.clk(clk), 
		.reset(reset), 
		.instruction(instruction), 
		.data_from_dm(data_from_dm), 
		.data_to_dm(data_to_dm), 
		.addr_to_pm(addr_to_pm), 
		.addr_to_dm(addr_to_dm), 
		.RdRam(RdRam), 
		.WrRam(WrRam)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		instruction = 0;
		data_from_dm = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

