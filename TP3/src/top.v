`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:08:15 10/09/2018 
// Design Name: 
// Module Name:    top 
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
module top(
	input clk,
	
	//Quitar despues
	input[7:0] d_in,
	input rx_done,
	input tx_done,
	output[7:0] d_out
   );

wire reset_bip;
wire WrPM;
wire WrDM;
wire RdDM;
wire [10 : 0]addrFromInterface;
wire [15 : 0]dataFromInterface;
wire [15 : 0]dataFromDM;
wire tx_start;

topbip bip(
	.reset_bip(reset_bip),
	.clk(clk),
	.WrPM(WrPM),
	.WrDM(WrDM),
	.RdDM(RdDM),
	.dataFromInterface(dataFromInterface),
	.addrFromInterface(addrFromInterface),
	.data_from_dm(dataFromDM)
   );
	
interface uint (
		.d_in(d_in),
		.inData(dataFromDM),
		.rx_done(rx_done),
		.tx_done(tx_done),
		.clk(clk),
		.tx_start(tx_start),
		.WrPM(WrPM),
		.WrDM(WrDM),
		.RdDM(RdDM),
		.reset_bip(reset_bip),
		.outData(dataFromInterface),
		.outAddr(addrFromInterface),
		.d_out(d_out)
);

endmodule
