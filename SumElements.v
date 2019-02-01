`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:53:12 03/15/2016 
// Design Name: 
// Module Name:    SumElements 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: Gets the sum of the elements of a vector
//
//////////////////////////////////////////////////////////////////////////////////

//Description: sums the elements of a vector of size N, with DATA_WIDTH bits for each position
module SumElements #(parameter N=2, parameter DATA_WIDTH=16)(
	input [N*DATA_WIDTH-1:0] a, //vector
	output [DATA_WIDTH-1:0]b // result
    );
	 

	genvar i,j;
	parameter log=$clog2(N)+1; //Number of layers of the structure
	
	wire [DATA_WIDTH-1:0]sums[0:2**log-1][0:log]; //Matrix to keep the partial values
	
	//Initializes the first layer of the structure
	generate
		for (i = 0; i < 2**log; i = i + 1) begin: loop1
			if(i<N) begin
				assign sums[i][0] = a[N*DATA_WIDTH-i*DATA_WIDTH-1:N*DATA_WIDTH-i*DATA_WIDTH-DATA_WIDTH];
			end else begin
				assign sums[i][0] = 0;
			end
		end
	endgenerate

	//Adds adders between each layer and the next one
	generate
		for (i = 1; i <= log; i = i + 1) begin: loop2
			for (j = 0; j <2**log/(2**i) ; j = j + 1) begin: loop3
			adder_16bits adder (
				.A(sums[2*j][i-1]), 
				.B(sums[2*j+1][i-1]),
				.S(sums[j][i])
				);
			end
		end
	endgenerate
	
	// The result can be found in the last layer
	assign b=sums[0][log];
endmodule
