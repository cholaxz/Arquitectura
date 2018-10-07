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
    rx_done,
	 error
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
output reg error = 0;

/* States */
localparam [5:0]IDLE    =  6'b000001;
localparam [5:0]START   =  6'b000010;
localparam [5:0]DATA    =  6'b000100;
localparam [5:0]STOP    =  6'b001000;
localparam [5:0]RESET 	= 	6'b010000;
localparam [5:0]PARITY 	= 	6'b100000;

reg [5 : 0] state = IDLE;
reg [5 : 0] next_state = IDLE;
reg [LENGTH_NUM_TICKS - 1 : 0] s, n; /* Check this */
reg [BITS_PER_DATA : 0] buffer = 0;
reg [5 : 0]sb_ticks = 6'b000000;
reg expected_parity;

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
    /* Next State Logic */
    case(state)
        IDLE:
			begin
			rx_done = 0;
			error = 0;
            if (~rx)
            begin
					 error = 0;
                next_state = START;
                s = 0;
					 buffer = 0;
            end
			end
        START:
            if(tick)
            begin
                if(s == 7)
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
                if(s == 15)
                begin
                    s = 0;
                    buffer = {rx, buffer[7 : 1]}; //Enviar dato. Que esta pasando aca. REVISAR!!! Necesito otro buffer? d_out podria ser output reg?
                    if( n == BITS_PER_DATA - 1 )
								if(parity == 1)
									next_state = PARITY;
								else
									next_state = STOP;
                    else
                        n = n + 1;
                end
                else
                    s = s + 1;
            end
		  PARITY: 
			if(tick)
			begin
				if(s == 15)
				begin
					expected_parity = buffer[0] + buffer[1] + buffer[2] + buffer[3] + buffer[4] + buffer[5] + buffer[6] + buffer[7];
					if (~ (expected_parity == rx))
						error = 1;
					s = 0;
					next_state = STOP;
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
				rx_done = 0;
				error = 0;
				next_state = IDLE;
			end
			
			default:
			begin
				next_state = RESET;
         end
    endcase
end

endmodule
