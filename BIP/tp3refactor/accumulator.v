`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:38:34 10/08/2018 
// Design Name: 
// Module Name:    accumulator 
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
module accumulator#(
	parameter DATA_LENGTH = 16
)(
	input enable,
	input clk,
	input reset,
	input[DATA_LENGTH - 1 : 0] inValue,
	output reg[DATA_LENGTH - 1 : 0] outValue
   );

initial outValue = 0;

always@(posedge clk)
begin
	if(reset)
		outValue = 0;
	else
		if(enable)
			outValue = inValue;
end

endmodule
