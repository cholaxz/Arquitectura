`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:30:50 10/09/2018 
// Design Name: 
// Module Name:    simple 
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
module interface(
	input reset,
	input clk,
	input tx_done,
	input rx_done,
	input tick,
	input [7:0]from_rx,
	input [7:0]from_alu,
	output reg [7:0]to_tx,
	output reg [7:0]num_a,
	output reg [7:0]num_b,
	output reg [7:0]opcode,
	output reg [7:0]leds,
	output reg tx_start
   );

parameter NUMA 	= 4'b0001;
parameter NUMB 	= 4'b0010;
parameter OPCODE 	= 4'b0100;
parameter RESULT 	= 4'b1000;

reg [3:0] state;

initial begin
num_a = 0;
num_b = 0;
opcode = 0;
tx_start = 0;
state = NUMA;
to_tx = 0;
leds = 0;
end

always@(posedge clk)
begin
	if(reset == 1)
	begin
		num_a <= 0;
		num_b <= 0;
		opcode <= 0;
		tx_start <= 0;
		state <= NUMA;
		to_tx <= 0;
		leds <= 0;
	end
	else
	begin
	case(state)
	NUMA:
		if(rx_done)
			begin
			leds <= from_rx;
			num_a <= from_rx;
			state <= NUMB;
			end
	NUMB:
		if(rx_done)
			begin
			leds <= from_rx;
			num_b <= from_rx;
			state <= OPCODE;
			end
	OPCODE:
		if(rx_done)
			begin
			leds <= from_rx;
			opcode <= from_rx;
			state <= RESULT;
			end
	RESULT:
		if(tx_start == 0)
		begin
			leds <= from_alu;
			to_tx <= from_alu;
			tx_start <=1;
		end
		else
		begin
			tx_start <=0;
			state <= NUMA;
		end
	default:
		state <= NUMA;
	endcase
	end
	//Transmisor
	/*
	//if(tx_done)
	tx_start <= 0;
	if(counter == TIME)
		begin
			to_tx <= value;
			counter <= 0;
			led <= ~led;
			tx_start <= 1;
		end
	else
		begin
			counter <= counter + 1;
		end
	*/
	//Receptor
	//if(rx_done)
	//	leds <= from_rx;
end


endmodule
