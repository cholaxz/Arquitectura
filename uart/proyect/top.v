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
	output [7:0]leds
    );
	 
wire tx_start;
wire tx_done;
wire rx_done;
wire [7:0]data_to_uart;
wire [7:0]data_from_uart;
wire [7:0]num_a;
wire [7:0]num_b;
wire [7:0]opcode;
wire [7:0]res_alu;

alu alu(
	.busA(num_a), 
	.busB(num_b), 
	.op(opcode),
	.salida(res_alu)
);

interface interface(
	.reset(reset),
	.num_a(num_a),
	.num_b(num_b),
	.opcode(opcode),
	.from_alu(res_alu),
	.leds(leds),
	.from_rx(data_from_uart),
	.clk(clk),
	.to_tx(data_to_uart),
	.tx_start(tx_start),
	.tx_done(tx_done),
	.rx_done(rx_done),
	.tick(tick)
    );

uart uart(
	.clk(clk),
	.rx(rx),
	.tx_start(tx_start),
	.bip_to_uart(data_to_uart),
	.uart_to_bip(data_from_uart),
	.tx(tx),
	.rx_done(rx_done),
	.tx_done(tx_done)
    );

endmodule
