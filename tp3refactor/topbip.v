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
module topbip#(
	parameter DATA_LENGTH = 16,
	parameter ADDR_LENGTH = 11
)(
	input reset_bip,
	input clk,
	input WrPM,
	input WrDM,
	input RdDM,
	input [15 : 0]dataFromInterface,
	input [10 : 0]addrFromInterface,
	output [DATA_LENGTH - 1 : 0]outAcc,
	output [DATA_LENGTH - 1 : 0]outPC,	
	output [DATA_LENGTH - 1 : 0]data_from_dm,
	output [7:0]leds
   );
	
	wire [ADDR_LENGTH - 1 : 0]addr_to_pm;
	wire [ADDR_LENGTH - 1 : 0]addr_to_dm;
	wire [DATA_LENGTH - 1 : 0]data_from_pm;
	wire [DATA_LENGTH - 1 : 0]data_to_dm;
	wire WrRam;
	wire RdRam;
	assign outAcc = data_to_dm;
	
	
	cpu cpu(
	.clk(clk),
	.reset(reset_bip),
	.instruction(data_from_pm),
	.data_from_dm(data_from_dm),
	.data_to_dm(data_to_dm),
	.addr_to_pm(addr_to_pm),
	.addr_to_dm(addr_to_dm),
	.RdRam(RdRam),
	.WrRam(WrRam),
	.outPC(outPC)
	);
	
	program_memory pm(
	.clk(clk),
	.addrFromBip(addr_to_pm),
	.addrFromInterface(addrFromInterface),
	.instruction(data_from_pm),
	.dataFromInterface(dataFromInterface),
	.Wr(WrPM)
	);
	

	wire [DATA_LENGTH - 1 : 0]inDataDM;
	wire [ADDR_LENGTH - 1 : 0]inAddrDM;
		
	wire [1:0]WrRdInterface;
	wire [1:0]WrRdBip;
	
	assign WrRdInterface = {WrDM, RdDM};
	assign WrRdBip = {WrRam, RdRam};

	data_memory dm(
	.clk(clk),
	.WrRdInterface(WrRdInterface),
	.WrRdBip(WrRdBip),
	.addr_from_bip(addr_to_dm),
	.addr_from_interface(addrFromInterface),
	.data_from_bip(data_to_dm),
	.data_from_interface(dataFromInterface),
	.outData(data_from_dm)
	);
	
	//assign leds[7:6] = WrRdDM;
	assign leds[7:0] = data_from_pm[7:0];

endmodule
