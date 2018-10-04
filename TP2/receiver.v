`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:12:14 10/04/2018 
// Design Name: 
// Module Name:    rrx 
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
module rrx(
	 reset,
	 rx,
    clk,
    tick,
    parity,
	 stop_bits,
    d_out,
    rx_done
    );


function integer clog2;
input integer value;
begin
value = value - 1;
for(clog2 = 0; value > 0; clog2 = clog2 + 1)
value = value >> 1;
end
endfunction

parameter NUM_TICKS = 16;
parameter LENGTH_NUM_TICKS = clog2(NUM_TICKS);
parameter LENGTH_MAX_DATA  = clog2(9);
parameter BITS_PER_DATA = 8;

input reset;
input rx;
input clk;
input parity;
input tick;
input[1:0] stop_bits;
output [BITS_PER_DATA - 1 : 0] d_out; /* Cual es la diferencia con usar assign? */
output reg rx_done = 0;

/* States */
localparam [4:0]IDLE    =  5'b00001;
localparam [4:0]START   =  5'b00010;
localparam [4:0]DATA    =  5'b00100;
localparam [4:0]STOP    =  5'b01000;
localparam [4:0]RESET 	= 	5'b10000;

reg [4 : 0] state = IDLE;
reg [4 : 0] next_state = IDLE;
reg [LENGTH_MAX_DATA  - 1 : 0] data_length;
reg [LENGTH_NUM_TICKS - 1 : 0] s, n; /* Check this */
reg [BITS_PER_DATA - 1: 0] buffer = 0;
reg [5 : 0]sb_ticks = 6'b000000;

assign d_out = buffer;

/* State Machine */
always @(posedge clk or posedge reset)
begin
	if(reset)
			state <= RESET;
	else
			state <= next_state;
end


/* Next-State Logic */
always @(*)
begin
	 /* Initial values */
	 	sb_ticks <= stop_bits * NUM_TICKS;
		if( parity == 1 )
			data_length <= 9;
		else
         data_length <= 8;
    /* Next State Logic */
    case(state)
        IDLE: 
            if (~rx)
            begin
                next_state <= START;
                s = 0;
            end
        START:
            if(tick)
            begin
                if(s == 7)
                begin
                    s = 0;
                    n = 0;
                    next_state <= DATA;
                end
                else
                    s = s + 1;
            end
        DATA:
            if (tick)
            begin
                if(s == 15)
                begin
                    s = 0;
                    buffer = {rx, buffer[7 : 1]}; //Enviar dato. Que esta pasando aca. REVISAR!!! Necesito otro buffer? d_out podria ser output reg?
                    if( n == data_length - 1 )
                        next_state <= STOP;
                    else
                        n = n + 1;
                end
                else
                    s = s + 1;
            end
        STOP:
            if(tick)
            begin
                if(s == sb_ticks - 1)
                begin
                    rx_done = 1'b1;
                    next_state <= IDLE;
                end
                else    
                    s = s + 1;
            end
			
			RESET:
			begin
				s = 0;
				n = 0;
				buffer = 0;
				rx_done = 0;
				next_state <= IDLE;
				
			end
			default:
			begin
				next_state <= RESET;
         end
    endcase
end

endmodule
