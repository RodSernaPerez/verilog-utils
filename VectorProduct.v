// -----------------------------------------------------------------------------
// Author : Serna Pérez (Rodrigo) rodsernaperez@gmail.com
// File   : VectorProduct.v
// Create : 2018-05-30 21:12:56
// Description: Computes the inner product of two vectors of size N with DATA_WIDTH bits for position 
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps


module VectorProduct #(	 parameter N=2,	parameter DATA_WIDTH=32)
(
	 input [N*DATA_WIDTH-1:0] a, // First vector
	 input [N*DATA_WIDTH-1:0] b, // Second vector
	 output [DATA_WIDTH-1:0]res // Result
 );
	 
	 
	wire [DATA_WIDTH-1:0]Amat[0:N-1]; // Matrix representation of the vector A
	wire [DATA_WIDTH-1:0]Bmat[0:N-1]; // Matrix representation of the vector B
	wire [N*DATA_WIDTH-1:0] prods; // To keep the element-by-element products 
	wire [DATA_WIDTH-1:0]prods_matrix[0:N-1]; // To keep the element-by-element products in matrix form
	
	genvar i;
	
	// Converts the vectors to a matrix form
	generate
		for (i = 0; i < N; i = i + 1) begin: loop1
				assign Amat[i]=a[N*DATA_WIDTH-1-i*DATA_WIDTH:N*DATA_WIDTH-i*DATA_WIDTH-DATA_WIDTH];
				assign Bmat[i]=b[N*DATA_WIDTH-1-i*DATA_WIDTH:N*DATA_WIDTH-i*DATA_WIDTH-DATA_WIDTH];
		end
	endgenerate

	// Implements the multiplications
	generate
		for (i = 0; i < N; i = i + 1) begin: loop2
			multiplication_16bits mult (
				.A(Amat[i][DATA_WIDTH-1:0]),
				.B(Bmat[i][DATA_WIDTH-1:0]),
				.P(prods_matrix[i][DATA_WIDTH-1:0]));

		end
	endgenerate
	

	// Converts the matrix form of multiplications to a vector form
	generate
		for (i = 0; i < N; i = i + 1) begin: loop4
			assign prods[N*DATA_WIDTH-1-i*DATA_WIDTH:N*DATA_WIDTH-i*DATA_WIDTH-DATA_WIDTH]=prods_matrix[i];
		end
	endgenerate
	
	
	// Sums the elements of the vector
	SumElements #(.N(N),.DATA_WIDTH(DATA_WIDTH)) sums (
    .a(prods), 
    .b(res)
    );


endmodule
