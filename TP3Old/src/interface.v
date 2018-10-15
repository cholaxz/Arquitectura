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
module interface #(parameter SIZE = 8,
parameter DATA_LENGTH = 16,
parameter ADDR_LENGTH = 11
)
	(
		input [SIZE-1:0] d_in,
		input [DATA_LENGTH - 1 : 0]inData,
		input rx_done,
		input tx_done,
		input clk,
		output reg tx_start,
		output reg WrPM,
		output reg WrDM,
		output reg RdDM,
		output reg reset_bip,
		output reg [DATA_LENGTH - 1 : 0]outData,
		output reg [ADDR_LENGTH - 1 : 0]outAddr,
		output reg [SIZE - 1 : 0] d_out
		
    );
	 
	 //States
	 localparam NUMBER_STATES = 11;
	 localparam [ NUMBER_STATES - 1 : 0 ]IDLE 			= 10'b0000000001;
	 localparam [ NUMBER_STATES - 1 : 0 ]DATALSB 		= 10'b0000000010;
	 localparam [ NUMBER_STATES - 1 : 0 ]DATAMSB 		= 10'b0000000100;
	 localparam [ NUMBER_STATES - 1 : 0 ]ADDRESSLSB 	= 10'b0000001000;
	 localparam [ NUMBER_STATES - 1 : 0 ]ADDRESSMSB 	= 10'b0000010000;
	 localparam [ NUMBER_STATES - 1 : 0 ]WRITE 			= 10'b0000100000;
	 localparam [ NUMBER_STATES - 1 : 0 ]START 			= 10'b0001000000;
	 localparam [ NUMBER_STATES - 1 : 0 ]READ 			= 10'b0010000000;
	 localparam [ NUMBER_STATES - 1 : 0 ]SENDLSB 		= 10'b0100000000;
	 localparam [ NUMBER_STATES - 1 : 0 ]SENDMSB 		= 10'b1000000000;
	 
	 //Codes
	 localparam[7:0] ST	= 8'b00000001;
	 localparam[7:0] PM	= 8'b00000010;
	 localparam[7:0] DM	= 8'b00000011;
	 localparam[7:0] RE	= 8'b00000100;
	 	 
	 reg [NUMBER_STATES - 1 : 0] state;
	 reg [NUMBER_STATES - 1 : 0] next_state;
	 reg [7 : 0] counter;
	 reg [7:0] code;
	 reg [DATA_LENGTH - 1 : 0] data_to_send;

initial
begin
	state 		= IDLE;
	next_state 	= IDLE;
	data_to_send= 0;
	tx_start 	= 0;
	counter 		= 0;
	WrDM 			= 0;
	WrPM 			= 0;
	reset_bip 	= 1;
	RdDM 			= 0;
	d_out 		= 0;
end	 
	
always @(posedge clk)
begin
		state<=next_state;
end

//Logica de salida
/*
always @(posedge clk)
begin
		case(state)
			ADDRESSLSB:
				outAddr[7:0] <= d_in;
			ADDRESSMSB:
				outAddr[10:8] <= d_in[2:0];
			DATALSB:
				outData[7:0] <= d_in;
			DATAMSB:
				outData[15:8] <= d_in;
			endcase
end
*/

always @(*)
begin
case(state)
		IDLE:
			begin
			tx_start = 0;
			counter = 0;
			WrDM = 0;
			WrPM = 0;
			reset_bip = 1;
			RdDM = 0;
			if(rx_done == 1)
			begin
				code = d_in;
				case(d_in)
					ST:
						next_state = START;
					PM:
						next_state = ADDRESSLSB;
					DM:
						next_state = ADDRESSLSB;
					RE:
						next_state = ADDRESSLSB;
					default: 
						next_state = IDLE;
				endcase
			end
			end
		ADDRESSLSB:
			if(rx_done == 1)
			begin
				outAddr[7:0] = d_in[2:0];
				next_state = ADDRESSMSB;
			end
		ADDRESSMSB:
		if(rx_done == 1)
			begin
				outAddr[10:8] = d_in[2:0];
				if(code == READ)
					next_state = READ;
				else
					next_state = DATALSB;
			end
		DATALSB:
			if(rx_done == 1)
			begin
				outData[7:0] = d_in;
				next_state = DATAMSB;
			end
		DATAMSB:
			if(rx_done == 1)
			begin
				outData[15:8] = d_in;
				next_state = WRITE;
			end
		WRITE:
			begin
				reset_bip = 1;
				case(code)
					PM:
					begin
						WrPM = 1;
						WrDM = 0;
					end
					DM:
					begin
						WrPM = 0;
						WrDM = 1;
					end
					default:
					begin
						WrPM = 0;
						WrDM = 0;
					end
				endcase
				next_state = IDLE;
			end
		START:
			begin
				outData = 0;
				outAddr = 0;
				reset_bip = 0;
				counter = counter + 1;
				if(counter == 5) //255
					begin
					counter = 0;
					next_state = IDLE;
					end					
			end
		READ:
			begin
				reset_bip = 1;
				RdDM = 1;
				data_to_send = inData;
				next_state = SENDLSB;
			end
		SENDLSB:
			begin
				d_out = data_to_send[7 : 0];
				reset_bip = 1;
				tx_start = 1;
				if(tx_done)
					begin
					tx_start = 0;
					next_state = SENDMSB;
					end
			end
		SENDMSB:
			begin
				d_out = data_to_send[15:8];
				reset_bip = 1;
				tx_start = 1;
				if(tx_done)
					begin
					tx_start = 0;
					next_state = IDLE;
					end
			end
		default:
			begin
				next_state = IDLE;
			end
		endcase
	end

endmodule

