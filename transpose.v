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

// Description: transposes a matrix of size MxN with DATA_WIDTH bits for each position
module transpose #(	parameter M=2, parameter N=2,	parameter DATA_WIDTH=2)
	(	
		input  [N*M*DATA_WIDTH-1:0] a, //input matrix
		output [N*M*DATA_WIDTH-1:0] b //transposed matrix
	);
	 

	
	wire [DATA_WIDTH-1:0] Amat [0:M-1][0:N-1]; //Matrix form of the input
	wire [DATA_WIDTH-1:0] Bmat [0:N-1][0:M-1]; //Matrix form of the output
	
	genvar i,j;
	
	//Converts the input to a matrix form
	generate
		for (i = 0; i < M; i = i + 1) begin: loop1
			for (j = 0; j < N; j = j + 1) begin: loop2
					assign Amat[i][j]=a[M*N*DATA_WIDTH-N*i*DATA_WIDTH-j*DATA_WIDTH-1:M*N*DATA_WIDTH-N*i*DATA_WIDTH-j*DATA_WIDTH-DATA_WIDTH];
			end
		end
	endgenerate
	
	// Computes the transpose
	generate
		for (i = 0; i < M; i = i + 1) begin: loop3
			for (j = 0; j < N; j = j + 1) begin: loop4
					assign Bmat[j][i]=Amat[i][j];
			end
		end
	endgenerate
	
	// Converts the transpose to a matrix form
	generate
		for (i = 0; i < N; i = i + 1) begin: loop5
			for (j = 0; j < M; j = j + 1) begin: loop6
					assign b[M*N*DATA_WIDTH-M*i*DATA_WIDTH-j*DATA_WIDTH-1:M*N*DATA_WIDTH-M*i*DATA_WIDTH-j*DATA_WIDTH-DATA_WIDTH]=Bmat[i][j];
			end
		end
	endgenerate
	
	
endmodule

