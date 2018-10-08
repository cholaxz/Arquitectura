`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:37 10/08/2018 
// Design Name: 
// Module Name:    topbip 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module topbip(
	input reset,
	input clk
   );
	
	parameter ADDR_LENGTH = 11;
	parameter DATA_LENGTH = 16;
	
	
	wire [ADDR_LENGTH - 1 : 0]addr_to_pm;
	wire [ADDR_LENGTH - 1 : 0]addr_to_dm;
	wire [DATA_LENGTH - 1 : 0]data_from_pm;
	wire [DATA_LENGTH - 1 : 0]data_from_dm;
	wire [DATA_LENGTH - 1 : 0]data_to_dm;
	wire [1:0]WrRd;
	wire WrRam;
	wire RdRam;
	
	assign WrRd = {WrRam, RdRam};

	cpu cpu(
	.clk(clk),
	.reset(reset),
	.instruction(data_from_pm),
	.data_from_dm(data_from_dm),
	.data_to_dm(data_to_dm),
	.addr_to_pm(addr_to_pm),
	.addr_to_dm(addr_to_dm),
	.RdRam(RdRam),
	.WrRam(WrRam)
	);
	
	program_memory pm(
	.clk(clk),
	.addr(addr_to_pm),
	.instruction(data_from_pm),
	.inData(0),
	.Wr(0)
	);
	
	data_memory dm(
	.clk(clk),
	.WrRd(WrRd),
	.addr(addr_to_dm),
	.inData(data_to_dm),
	.outData(data_from_dm)
	);

endmodule
