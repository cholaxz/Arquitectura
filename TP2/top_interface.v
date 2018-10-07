`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:27:58 10/05/2018 
// Design Name: 
// Module Name:    top_interface 
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
module top_interface #(SIZE = 8)(
		input clock,
		input rx, 
		output tx
    );
wire [7:0]drx;
wire rx_done;
wire [7:0] dtx;
wire tx_done;
wire tx_start;
wire [7: 0] a;
wire [7: 0] b;
wire [7: 0] op;
wire[7:0] alu_res;
wire reset_rx;
wire reset_tx;
wire tick;
wire error;
reg parity = 0;
reg[1:0] stop_bits = 1;


interface in(
.reset(0),
.d_in(drx),
.alu_res(alu_res),
.rx_done(rx_done),
.tx_done(tx_done),
.clk(clock),
.tx_start(tx_start),
.d_out(dtx),
.a(a),
.b(b),
.op(op)
);

ALU al(.busA(a),.busB(b),.op(op),.salida(alu_res));

ttx txhola(
		.reset(0), 
		.tx_start(tx_start), 
		.clk(clock), 
		.tick(tick), 
		.parity(parity), 
		.stop_bits(stop_bits), 
		.d_in(dtx), 
		.tx_done(tx_done), 
		.tx_out(tx));
rrx rxhola(
		.reset(0),
		.rx(rx), 
		.clk(clock), 
		.tick(tick), 
		.parity(parity), 
		.stop_bits(stop_bits),
		.d_out(drx), 
		.rx_done(rx_done),
		.error(error)
);

baud_rate_gen bd(
.clk(clock),
.reset(0),
.tick(tick)
);

endmodule

