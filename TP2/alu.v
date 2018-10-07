`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:39:52 09/25/2018 
// Design Name: 
// Module Name:    ALU 
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
module ALU #(
parameter length = 8)(
	input signed[length - 1:0]  busA, input signed[length - 1:0]  busB, input [5:0] op,
	output reg signed[length - 1:0] salida
    );

always @(*) begin
 case(op)
 6'b100000: salida = busA + busB;
 6'b100010: salida = busA - busB;
 6'b100100: salida = busA & busB;
 6'b100101: salida = busA | busB;
 6'b100110: salida = busA ^ busB;
 6'b000011: salida = busA >> busB;
 6'b000010: salida = busA << busB;
 6'b100111: salida = ~(busA | busB);
 default: salida = 0;
 endcase
 end

endmodule