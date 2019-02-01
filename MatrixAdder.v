`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:14:21 03/04/2016 
// Design Name: 
// Module Name:    MatrixAdder 
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
//Description: sums two matrices MxN with DATA_WIDTH bits each position
module MatrixAdder #(parameter N=2, parameter M=2, parameter DATA_WIDTH=16)(
	input [N*M*DATA_WIDTH-1:0]a, // First matrix
	input [N*M*DATA_WIDTH-1:0]b, // Second matrix
	output [N*M*DATA_WIDTH-1:0]res //Result
    );

	
	genvar i,j;
	
	generate
		for (i = 0; i < N; i = i + 1) begin: loop3
			for (j = 0; j < M; j = j + 1) begin: loop4
				adder_16bits addition(
				
				  .A(a[M*N*DATA_WIDTH-i*N*DATA_WIDTH-j*DATA_WIDTH-1:M*N*DATA_WIDTH-i*N*DATA_WIDTH-j*DATA_WIDTH-DATA_WIDTH]),
				  .B(b[M*N*DATA_WIDTH-i*N*DATA_WIDTH-j*DATA_WIDTH-1:M*N*DATA_WIDTH-i*N*DATA_WIDTH-j*DATA_WIDTH-DATA_WIDTH]),
				  .S(res[M*N*DATA_WIDTH-i*N*DATA_WIDTH-j*DATA_WIDTH-1:M*N*DATA_WIDTH-i*N*DATA_WIDTH-j*DATA_WIDTH-DATA_WIDTH]) 
				);
			end
		end
	endgenerate



endmodule
