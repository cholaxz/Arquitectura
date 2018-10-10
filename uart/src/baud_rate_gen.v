/* Check CLK_100MHZ. Maybe clock freq should enter somewhere else. */

module baud_rate_gen(
    input clk,
    output reg tick
);


parameter baud_rate = 9600;
parameter clk_value = 50 * 1000 * 1000;
parameter num_ticks = 16;
parameter counter_length = 32;
parameter RATE = clk_value / (baud_rate * num_ticks);

reg [counter_length - 1 : 0]counter;

initial
begin
tick = 0;
counter = 0;
end

always @(posedge clk)
begin
	if ( counter == RATE)
	begin
		tick <= 1;
		counter <= 0;
	end
	else
	begin
		counter <= counter + 1;
		tick <= 0;
	end
end

endmodule
