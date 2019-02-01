`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:26:52 02/19/2016 
// Design Name: 
// Module Name:    MatrixMultiplier 
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

// Description: multiplies a matrix of size MxN and another of size NxO, with DATA_WIDTH for each position
module MatrixMultiplier #(	parameter M=32, parameter N=24,parameter O=1,parameter DATA_WIDTH=16)
(
	input [M*N*DATA_WIDTH-1:0]x1, // First matrix
	input [N*O*DATA_WIDTH-1:0]x2, // Second matrix
	output [M*O*DATA_WIDTH-1:0]y // Result
);


	wire [N*O*DATA_WIDTH-1:0]X2trans; // Transpose of matrix x2
	wire [DATA_WIDTH-1:0]resmat[0:M-1][0:O-1]; // Matrix form of the result
	
	genvar i,j;
	
	
	// Transposes the matrix x2 in order to more easily select the rows
	transpose #(.M(N),.N(O), .DATA_WIDTH(DATA_WIDTH)) trans (
		 .a(x2), 
		 .b(X2trans)
		 );

	// Each position of the resulting matrix is got as an inner product
	generate
		for (i = 0; i < M; i = i + 1) begin: loop5
			for (j = 0; j < O; j = j + 1) begin: loop6
				VectorProduct #(.N(N), .DATA_WIDTH(DATA_WIDTH)) innerproduct (
					 .a(x1[M*N*DATA_WIDTH-i*N*DATA_WIDTH-1:M*N*DATA_WIDTH-i*N*DATA_WIDTH-N*DATA_WIDTH]), 
					 .b(X2trans[O*N*DATA_WIDTH-j*N*DATA_WIDTH-1:O*N*DATA_WIDTH-j*N*DATA_WIDTH-N*DATA_WIDTH]), 
					 .res(resmat[i][j])
				 );
			end
		end
	endgenerate
	
	// Converts the matrix form of the result to a vector representation
	generate
		for (i = 0; i < M; i = i + 1) begin: loop7
			for (j = 0; j < O; j = j + 1) begin: loop8
				assign y[M*O*DATA_WIDTH-i*O*DATA_WIDTH-j*DATA_WIDTH-1:M*O*DATA_WIDTH-i*O*DATA_WIDTH-j*DATA_WIDTH-DATA_WIDTH]=resmat[i][j];
			end
		end
	endgenerate
endmodule
