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
module ttx(
	reset,
    tx_start,
    clk,
    tick,
    parity,
	 stop_bits,
    d_in,
    tx_done,
    tx_out
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
input tx_start;
input clk;
input parity;
input tick;
input[1:0] stop_bits;
input [BITS_PER_DATA - 1 : 0] d_in;
output reg tx_done = 0;
output reg tx_out = 0;



/* States */
localparam [5:0]IDLE    =  6'b000001;
localparam [5:0]START   =  6'b000010;
localparam [5:0]DATA    =  6'b000100;
localparam [5:0]PARITY  =  6'b001000;
localparam [5:0]STOP 	=  6'b010000;
localparam [5:0]RESET 	=  6'b100000;

reg [5 : 0] state = IDLE;
reg [5 : 0] next_state = IDLE;
reg [LENGTH_MAX_DATA  - 1 : 0] data_length;
reg [LENGTH_NUM_TICKS - 1 : 0] s, n;
reg [BITS_PER_DATA - 1 : 0] buffer = 0;
reg [5 : 0]sb_ticks = 6'b000000;
reg parity_bit = 0;

//assign tx_out = buffer;

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
	sb_ticks = stop_bits * NUM_TICKS;
    /* Next State Logic */
    case(state)
        IDLE:
			begin
            tx_out = 1;
			tx_done = 0;
            if (tx_start)
            begin
                next_state = START;
                s = 0;
            end
			end
        START:
            if(tick)
				begin
            tx_out = 0;
            buffer = d_in;
                if(s == NUM_TICKS - 1)
                begin
                    s = 0;
                    n = 0;
                    next_state = DATA;
                end
                else
                    s = s + 1;
            end
        DATA:
            if (tick)
            begin
                tx_out = buffer[0];
                if(s == NUM_TICKS - 1)
                begin
                    s = 0;
                    if( n == 7 )
                        if(parity == 1)
                            next_state = PARITY;
                        else
                            next_state = STOP;
                    else
                        n = n + 1;
                        buffer = buffer >> 1;
                end
                else
                    s = s + 1;
            end
        PARITY:
            if(tick)
            begin
            parity_bit = d_in[0] + d_in[1] + d_in[2] + d_in[3] + d_in[4] + d_in[5] + d_in[6] + d_in[7];
            tx_out = parity_bit;

            if(s == NUM_TICKS - 1)
            begin
                s = 0;
                next_state = STOP;
            end
            else
                s = s + 1;
            end
        STOP:
            if(tick)
            begin
                tx_out = 1;
                if(s == sb_ticks - 1)
                begin
                    tx_done = 1'b1;
                    next_state = IDLE;
                end
                else    
                    s = s + 1;
            end
			
			RESET:
			begin
				s = 0;
				n = 0;
				buffer = 0;
                parity_bit = 0;
				tx_done = 0;
                tx_out = 1;
				next_state = IDLE;
				
			end
			default:
			begin
				next_state = RESET;
         end
    endcase
end

endmodule