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
	output [DATA_LENGTH - 1 : 0]data_from_dm
   );
	
	wire [ADDR_LENGTH - 1 : 0]addr_to_pm;
	wire [ADDR_LENGTH - 1 : 0]addr_to_dm;
	wire [DATA_LENGTH - 1 : 0]data_from_pm;
	wire [DATA_LENGTH - 1 : 0]data_to_dm;
	wire [1:0]WrRdDM;
	wire WrRam;
	wire RdRam;
	assign WrRdDM[1] = WrRam | WrDM;
	assign WrRdDM[0] = RdRam | RdDM;
	
	cpu cpu(
	.clk(clk),
	.reset(reset_bip),
	.instruction(data_from_pm),
	.data_from_dm(data_from_dm),
	.data_to_dm(data_to_dm),
	.addr_to_pm(addr_to_pm),
	.addr_to_dm(addr_to_dm),
	.RdRam(RdRam),
	.WrRam(WrRam)
	);
	
	wire [ADDR_LENGTH - 1 : 0]inAddrPM;
	assign inAddrPM = WrPM ? addrFromInterface : addr_to_pm;
	
	program_memory pm(
	.clk(clk),
	.addr(inAddrPM),
	.instruction(data_from_pm),
	.inData(dataFromInterface),
	.Wr(WrPM)
	);
	
	
	wire [DATA_LENGTH - 1 : 0]inDataDM;
	wire [ADDR_LENGTH - 1 : 0]inAddrDM;
	
	assign inDataDM =  WrDM ? dataFromInterface : data_to_dm;
	assign inAddrDM =  WrDM ? addrFromInterface : addr_to_dm;
	
	data_memory dm(
	.clk(clk),
	.WrRd(WrRdDM),
	.addr(inAddrDM),
	.inData(inDataDM),
	.outData(data_from_dm)
	);

endmodule
