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
		input reset,
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
		output reg [SIZE - 1 : 0] d_out,
		output [7:0]leds
		
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
	 //localparam[7:0] RE	= 8'b00100000;
	 	 
	 reg [NUMBER_STATES - 1 : 0] state;
	 reg [7 : 0] counter;
	 reg [7:0] code;
	 reg [DATA_LENGTH - 1 : 0] data_to_send;

initial
begin
	state 		= IDLE;
	code = 0;
	data_to_send= 0;
	tx_start 	= 0;
	counter 		= 0;
	WrDM 			= 0;
	WrPM 			= 0;
	reset_bip 	= 1;
	RdDM 			= 0;
	d_out 		= 0;
	outAddr 		= 0;
	outData 		= 0;
end	 

assign leds = outData[15:8];
	
always @(posedge clk)
begin
	if(reset)
	begin
		state 		<= IDLE;
		data_to_send<= 0;
		tx_start 	<= 0;
		counter 		<= 0;
		WrDM 			<= 0;
		WrPM 			<= 0;
		reset_bip 	<= 1;
		RdDM 			<= 0;
		d_out 		<= 0;
	end
	else
	begin
case(state)
		IDLE:
			begin
			tx_start <= 0;
			counter <= 0;
			WrDM <= 0;
			WrPM <= 0;
			reset_bip <= 1;
			RdDM <= 0;
			if(rx_done == 1)
			begin
				code <= d_in;
				//leds <= d_in;
				case(d_in)
					ST:
						state <= START;
					PM:
						state <= ADDRESSLSB;
					DM:
						state <= ADDRESSLSB;
					RE:
						state <= ADDRESSLSB;
					default: 
						state <= IDLE;
				endcase
			end
			end
		ADDRESSLSB:
			if(rx_done == 1)
			begin
				outAddr[7:0] <= d_in;
				//leds <= d_in;
				state <= ADDRESSMSB;
			end
		ADDRESSMSB:
		if(rx_done == 1)
			begin
				outAddr[10:8] <= d_in[2:0];
				//leds <= d_in;
				state <= READ;
				case(code)
					RE:
						state <= READ;
					DM:
						state <= DATALSB;
					PM:
						state <= DATALSB;
					default
						state <= IDLE;
				endcase
			end
		DATALSB:
			if(rx_done == 1)
			begin
				outData[7:0] <= d_in;
				//leds <= d_in;
				state <= DATAMSB;
			end
		DATAMSB:
			if(rx_done == 1)
			begin
				outData[15:8] <= d_in;
				//leds <= d_in;
				state <= WRITE;
			end
		WRITE:
			begin
				reset_bip <= 1;
				case(code)
					PM:
					begin
						WrPM <= 1;
						WrDM <= 0;
					end
					DM:
					begin
						WrPM <= 0;
						WrDM <= 1;
					end
					default:
					begin
						WrPM <= 0;
						WrDM <= 0;
					end
				endcase
				state <= IDLE;
			end
		START:
			begin
				outData <= 0;
				outAddr <= 0;
				reset_bip <= 0;
				counter <= counter + 1;
				if(counter == 255)
					begin
					counter <= 0;
					state <= IDLE;
					end					
			end
		READ:
			begin
				reset_bip <= 1;
				RdDM <= 1;
				state <= SENDLSB;
			end
		SENDLSB:
			begin
				if(tx_start == 0)
				begin
					d_out <= inData[7 : 0];
					//d_out <= 60;
					//leds <= data_to_send[7:0];
					reset_bip <= 1;
					tx_start <= 1;
				end
				else
				begin
					tx_start <= 0;
					state <= SENDMSB;
				end
				
			end
		SENDMSB:
			begin
				if(tx_done)
				begin
					d_out <= inData[15:8];
					//d_out <= 70;
					//leds <= data_to_send[15:8];
					reset_bip <= 1;
					tx_start <= 1;
				end
				else if(tx_start == 1)
					begin
						tx_start <= 0;
						state <= IDLE;
					end
			end
		default:
			begin
				state <= IDLE;
			end
		endcase
		end
end

endmodule

