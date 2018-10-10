`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:51:20 10/09/2018 
// Design Name: 
// Module Name:    uart 
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
module uart(
	input clk,
	input rx,
	input tx_start,
	input [7:0]bip_to_uart,
	output [7:0]uart_to_bip,
	output tx,
	output rx_done,
	output tx_done
    );
	
wire tick;
parameter parity 		= 1'b0;
parameter stop_bits 	= 2'b01;
parameter reset 		= 1'b0;
wire error;

	 
transmitter txx(
	 .reset(reset),
    .tx_start(tx_start),
    .clk(clk),
    .tick(tick),
    .parity(parity),
	 .stop_bits(stop_bits),
    .d_in(bip_to_uart),
    .tx_done(tx_done),
    .tx_out(tx)
    );

baud_rate_gen baud_gen(
    .clk(clk),
    .tick(tick)
);

receiver rxx(
	 .reset(reset),
	 .rx(rx),
    .clk(clk),
    .tick(tick),
    .parity(parity),
	 .stop_bits(stop_bits),
    .d_out(uart_to_bip),
    .rx_done(rx_done),
	 .error(error)
    );

endmodule
