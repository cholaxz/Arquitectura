/* Check CLK_100MHZ. Maybe clock freq should enter somewhere else. */

module baud_rate_gen(
    input clk,
    input reset,
    //input reg baud_rate,
    output reg tick
);


parameter baud_rate = 9600;
parameter clk_value = 100 * 1000000;
parameter num_ticks = 16;
parameter counter_length = 32;


reg count_to[counter_length - 1 : 0] = clk_value / (baud_rate * num_ticks)
reg counter[counter_length - 1 : 0] = 0;

always @(posedge clk or posedge reset)
begin
    if(reset)
        begin
            counter = 0;
            tick = 0;
        end
    else
        begin
           counter = counter + 1;

            if ( counter == count_to)
                begin
                    tick = 1;
                    counter = 0;
                end
            else
                tick = 0;

        end
    end

endmodule;