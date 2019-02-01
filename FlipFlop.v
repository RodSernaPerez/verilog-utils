// -----------------------------------------------------------------------------
// Author : Serna Pérez (Rodrigo) rodsernaperez@gmail.com
// File   : FlipFlop.v
// Create : 2018-06-03 21:26:46
// Description: 
// -----------------------------------------------------------------------------

`timescale 1ns / 1ps

module FlipFlop #(parameter N=100)(
	input clk,
	input [N-1:0] data,
	input enable,
	input reset,
	input clear,
	output reg [N-1:0]out);

	
	always @ ( posedge clk or negedge reset)
	if (~reset) begin
		out <= {N{1'b0}};
	end else begin
		if (clear) begin
			out<={N{1'b0}};
		end else if (enable) begin
			out <= data;
		end
	end	 
endmodule
