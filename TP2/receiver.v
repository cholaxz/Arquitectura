module receiver(
    rx,
    clk,
    tick,
    parity,
    d_out,
    rx_done
);

parameter NUM_TICKS = 16;
parameter LENGTH_NUM_TICKS = $clog2(NUM_TICKS);
parameter LENGTH_MAX_DATA  = $clog2(9);
parameter LENGTH_NUM_STATES = $clog2(4);
parameter BITS_PER_DATA = 8;

input rx;
input clk;
input parity;
output [BITS_PER_DATA - 1 : 0] d_out; /* Cual es la diferencia con usar assign? */
output reg rx_done;

reg [LENGTH_NUM_STATES - 1 : 0] state, next_state;
reg [LENGTH_MAX_DATA  - 1 : 0] data_length;
reg [LENGTH_NUM_TICKS - 1 : 0] s, n; /* Check this */
reg [BITS_PER_DATA - 1: 0] buffer;

assign d_out = buffer;

/* States */
localparam [3:0]IDLE    =  4'b0001;
localparam [3:0]START   =  4'b0010;
localparam [3:0]DATA    =  4'b0100;
localparam [3:0]STOP    =  4'b1000;

/* State Machine */
always @(posedge clk, posedge reset)
begin
    if(reset)
        begin
            state <= IDLE;
            s <= 0;
            buffer <= 0;
        end
    else
        begin
            state <= next_state;
        end
end


/* Combinational */
always @(*)
begin
    /* Parity */
    if( parity == 1 )
        data_length = 9;
    else
        data_length = 8;

    /* Next State Logic */
    case
        IDLE: 
            if (~rx)
            begin
                next_state = START;
                s = 0;
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
                    buffer = {rx, buffer[7 : 1]} //Enviar dato. Que esta pasando aca. REVISAR!!! Necesito otro buffer? d_out podria ser output reg?
                    if( n == data_length - 1 )
                        next_state = STOP;
                    else
                        n = n + 1;
                end
                else
                    s = s + 1;
            end
        STOP:
            if(tick)
            begin
                if(s == NUM_TICKS - 1)
                begin
                    rx_done = 1'b1;
                    next_state = IDLE;
                end
                else    
                    s = s + 1;
            end
        default:
            begin
                next_state = IDLE;
                s = 0;
                n = 0;
                buffer = 0;
                rx_done = 0;
            end
    endcase
end

    
    
