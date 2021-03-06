`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:39:13 10/09/2018 
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
	input reset,
	input clk,
	input rx,
	output tx,
	output [7:0]leds,
	output [15:0]outPC
   );
	 
wire tx_start;
wire tx_done;
wire rx_done;
wire [7:0]interface_to_uart;
wire [7:0]uart_to_interface;
//Del BIP
wire [15:0] bip_to_interface;
wire [15:0] interface_to_bip;
wire [11:0] addrToMemory;
wire WrPM, WrDM, RdDM, reset_bip;
wire[15:0] Acc;
wire[15:0] PC;
assign leds = Acc[7:0];

interface interface(
	.reset(reset),
	.d_in(uart_to_interface),
	.inData(bip_to_interface),
	.rx_done(rx_done),
	.tx_done(tx_done),
	.clk(clk),
	.tx_start(tx_start),
	.WrPM(WrPM),
	.WrDM(WrDM),
	.RdDM(RdDM),
	.reset_bip(reset_bip),
	.outData(interface_to_bip),
	.outAddr(addrToMemory),
	.d_out(interface_to_uart),
	.leds(),
	.inAcc(Acc),
	.inPC(PC)
    );

uart uart(
	.clk(clk),
	.rx(rx),
	.tx_start(tx_start),
	.bip_to_uart(interface_to_uart),
	.uart_to_bip(uart_to_interface),
	.tx(tx),
	.rx_done(rx_done),
	.tx_done(tx_done)
    );

/* Agrego parte de BIP */
topbip bip(
	.reset_bip(reset_bip),
	.clk(clk),
	.WrPM(WrPM),
	.WrDM(WrDM),
	.RdDM(RdDM),
	.dataFromInterface(interface_to_bip),
	.addrFromInterface(addrToMemory),
	.data_from_dm(bip_to_interface),
	.leds(),
	.outAcc(Acc),
	.outPC(PC)
   );

endmodule
