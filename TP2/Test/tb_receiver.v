`timescale 1s/100ms
`include "../receiver.v"
module tb_receiver;

    reg rx, tick, parity, clk;
    wire [7:0] d_out;
    wire rx_done;
    

    rx=1;
    parity=0;
    tick=0;
    clk=0;

    test receiver( 
    rx,
    clk,
    tick,
    parity,
    d_out,
    rx_done
    );

integer data, clock;

initial
    begin
        for(data = 0; data < 10; data = data + 1)
        begin
            rx = ~rx;
            for(ticks = 0; ticks < 500; ticks = ticks + 1)
            begin
            tick = ~tick;
            for(clock = 0; clock < 10; clock = clock + 1)
            #100
            clk = ~clk;
            end
            end
        end
    end
endmodule