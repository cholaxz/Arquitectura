`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:14:02 10/05/2018 
// Design Name: 
// Module Name:    interface 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: a
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module interface #(parameter SIZE = 8)
	(
		input reset,
		input [SIZE-1:0] d_in,
		input [SIZE-1:0] alu_res,
		input rx_done,
		input tx_done,
		input clk,
		output reg tx_start,
		output reg [SIZE - 1 : 0] d_out,
		output reg [SIZE - 1 : 0 ] a,
		output reg [SIZE - 1 : 0 ] b,
		output reg [SIZE - 1 : 0 ] op
    );
	 
	 localparam [ 6 : 0 ]IDLE = 7'b0000001;
	 localparam [ 6 : 0 ]NUMA = 7'b0000010;
	 localparam [ 6 : 0 ]NUMB = 7'b0000100;
	 localparam [ 6 : 0 ]OPCODE = 7'b0001000;
	 localparam [ 6 : 0 ]RESULT = 7'b0010000;
	 localparam [ 6 : 0 ]CHECK = 7'b0100000;
	 localparam [ 6 : 0 ]RESET = 7'b1000000;
	 
	 initial a = 0;
	 initial b = 0;
	 initial op = 0;
	 reg [6 : 0] state = IDLE;
	 reg [6 : 0] next_state = IDLE;
	 reg [2 : 0] count = 0;
always @(posedge clk, posedge reset)
begin
	if(reset)
		state<=RESET;
	else	
		state<=next_state;
end


/* 
Estaria bueno  hacer al rx_done por rising edge. 
En ese caso resetearia el rx_done en el modulo receptor 
cuando se esta recibiendo un nuevo dato.
*/
always @(*)
begin
case(state)
		IDLE:
			begin
			if(rx_done == 1)
			begin
				case(count)
				3'b000: next_state = NUMA;
				3'b001: next_state = NUMB;
				3'b010: next_state = OPCODE;
				default: next_state = RESET;
				endcase
			end
			end
		NUMA:
			if(rx_done == 1)
			begin
			count = count + 1;
			a = d_in;
			next_state = IDLE;
			end
		NUMB: 
			if(rx_done == 1)
			begin
			count = count + 1;
			b = d_in;
			next_state = IDLE;
			end
		OPCODE:
			if(rx_done == 1)
			begin
			count = 0;
			op = d_in;
			next_state = RESULT;
			end
		RESULT:
			begin
			d_out = alu_res;
			tx_start = 1;
			if(tx_done)
				begin
				next_state = RESET;
				end
			end
		RESET:
			begin
				count = 0;
				d_out = 0;
				tx_start = 0;
				a = 0;
				b = 0;
				op = 0;
				next_state = IDLE;
			end
		default:
			next_state = RESET;
		endcase	
end

endmodule

