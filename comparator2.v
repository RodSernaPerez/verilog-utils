// -----------------------------------------------------------------------------
// Author : Serna Pérez (Rodrigo) rodsernaperez@gmail.com
// File   : comparator2.v
// Create : 2018-05-31 00:26:39
// Description: returns the maximum value and the position of two vectors, each of DATA_WIDTH bits.
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps


module comparator2 #(
	parameter DATA_WIDTH        = 16, 
	parameter BITS_FOR_POSITION = 4
	)(
		input signed 	[DATA_WIDTH-1:0] 			a,b, //The two values to compare
		input 			[BITS_FOR_POSITION-1:0] 	pos_a, pos_b, // The positions of each of those two values
		output reg 		[BITS_FOR_POSITION-1:0] 	pos_max, //The position of the maximum value
		output reg 		[DATA_WIDTH-1:0] 			value_max
	); //The maximum value
	
	always @* begin
		if(a>b) begin
			pos_max   = pos_a;
			value_max = a;
		end else begin
			pos_max   = pos_b;
			value_max = b;
		end
	end

endmodule
