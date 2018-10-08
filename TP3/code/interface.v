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
	 
	 //States
	 localparam [ 6 : 0 ]IDLE = 7'b0000001;
	 localparam [ 6 : 0 ]NUMA = 7'b0000010;
	 localparam [ 6 : 0 ]NUMB = 7'b0000100;
	 localparam [ 6 : 0 ]OPCODE = 7'b0001000;
	 localparam [ 6 : 0 ]RESULT = 7'b0010000;
	 localparam [ 6 : 0 ]CHECK = 7'b0100000;
	 localparam [ 6 : 0 ]RESET = 7'b1000000;
	 
	 //Sub-State
	 localparam[7:0] ST	= 8'b00000010;
	 localparam[7:0] PM	= 8'b00000100;
	 localparam[7:0] DM	= 8'b00001000;
	 
	 
	 initial tx_start = 0;
	 
	 reg [6 : 0] state = IDLE;
	 reg [6 : 0] next_state = IDLE;
	 reg [2 : 0] count = 0;
always @(posedge clk)
begin
	if(reset)
		state<=RESET;
	else	
		state<=next_state;
end



always @(*)
begin
case(state)
		IDLE:
			begin
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
						next_state = DATA;
					DM:
						next_state = DATA;
					SE:
						next_state = SEND;
					default: IDLE;
				endcase
			end
			end
		DATA:
			if(rx_done == 1)
			begin
				if(count == 0)
				begin
					outData[7:0] = d_in;
					count = ~count; //count = 1
				end
				else
				begin
					outData[15:8] = d_in;
					count = ~count; //count = 0
					next_state = ADDRESS;
				end
			end
		ADDRESS:
			if(rx_done == 1)
			begin
				if(count == 0)
				begin
					outAddr[7:0] = d_in;
					count = ~count; //count = 1
				end
				else
				begin
					outAddr[10:8] = d_in[2:0];
					count = ~count; //count = 0
					next_state = WRITE;
				end
			end
		WRITE:
			begin
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
				reset_bpi = 0;
				counter = counter + 1;
				if(counter == 255)
					next_state = IDLE;
			end
		READ:
			begin
			end
			//Read and Send data
		default:
			begin
			end
		endcase
	end

endmodule

