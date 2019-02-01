// -----------------------------------------------------------------------------
// Author : Serna Pérez (Rodrigo) rodsernaperez@gmail.com
// File   : comparator.v
// Create : 2018-05-30 20:54:07
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps

//Description: returns the position of the maximum value of N values and DATA_WIDTH each one.
//The position is returned in bits_for_position bits
module comparator 
#(
	parameter DATA_WIDTH        = 16,
	parameter N                 = 8 ,
	parameter BITS_FOR_POSITION = 3
) (
	input  [DATA_WIDTH*N-1:0] 		values , //Vector of values
	output [BITS_FOR_POSITION-1:0]	pos_max  //Position of the maximum value
);

	genvar i,j;

	wire [DATA_WIDTH-1:0] 			partialmaxs [0:2**BITS_FOR_POSITION-1][0:BITS_FOR_POSITION]; //To keep the maximum values
	wire [BITS_FOR_POSITION-1:0]	partialpos 	[0:2**BITS_FOR_POSITION-1][0:BITS_FOR_POSITION]; //To keep the maximum positions

	//Initiatilizes the first layer
	generate
		for (i = 0; i < 2**BITS_FOR_POSITION; i = i + 1) begin: loop1
			if(i<N) begin
				assign partialmaxs[i][0] = values[N*DATA_WIDTH-i*DATA_WIDTH-1:N*DATA_WIDTH-i*DATA_WIDTH-DATA_WIDTH];
				assign partialpos[i][0]  = i;
			end else begin
				assign partialmaxs[i][0] = 15'd0;
				assign partialpos[i][0]  = 15'd0;
			end
		end
	endgenerate

	//Gets the value for each layer from the previous one
	generate
		for (i = 1; i <= BITS_FOR_POSITION; i = i + 1) begin: loop2
			for (j = 0; j <2**BITS_FOR_POSITION/(2**i) ; j = j + 1) begin: loop3
				comparator2 #(
					.BITS_FOR_POSITION(BITS_FOR_POSITION), 
					.DATA_WIDTH(DATA_WIDTH)) comp2 (
					.a        (partialmaxs[2*j][i-1]  ),
					.b        (partialmaxs[2*j+1][i-1]),
					.pos_a    (partialpos[2*j][i-1]   ),
					.pos_b    (partialpos[2*j+1][i-1] ),
					.value_max(partialmaxs[j][i]      ),
					.pos_max  (partialpos[j][i]       )
				);
			end
		end
	endgenerate

	//Gets the result from the last layer
	assign pos_max = partialpos[0][BITS_FOR_POSITION];


endmodule
