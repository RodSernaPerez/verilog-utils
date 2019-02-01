
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:16:23 05/17/2018
// Design Name:   comparator
// Module Name:   C:/Users/Rodrigo/Desktop/RLS/testCompleteComparator.v
// Project Name:  RLS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: comparator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testCompleteComparator;

	parameter DATA_WIDTH=16;
	parameter number_blocks=8;
	parameter BITS_FOR_POSITION=3;
	
	// Inputs
	reg [DATA_WIDTH*number_blocks-1:0] values;

	// Outputs
	wire [BITS_FOR_POSITION-1:0] pos_max;

	genvar i;
	
	reg  [DATA_WIDTH-1:0] vectorOfValues [0:number_blocks-1];
	wire [DATA_WIDTH*number_blocks-1:0] values_aux;
	
	generate
		for (i = 0; i < number_blocks; i = i + 1) begin: loop1
			assign values_aux[number_blocks*DATA_WIDTH-i*DATA_WIDTH-1:number_blocks*DATA_WIDTH-i*DATA_WIDTH-DATA_WIDTH]=vectorOfValues[i];
		end
	endgenerate
	
	
	// Instantiate the Unit Under Test (UUT)
	comparator  #(.DATA_WIDTH(DATA_WIDTH),.number_blocks(number_blocks),.BITS_FOR_POSITION(BITS_FOR_POSITION)) uut(
		.values(values), 
		.pos_max(pos_max)
	);
	
	

	initial begin
		// Initialize Inputs
		
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		vectorOfValues[0]=0;
		vectorOfValues[1]=1;
		vectorOfValues[2]=2;
		vectorOfValues[3]=3;
		vectorOfValues[4]=4;
		vectorOfValues[5]=5;
		vectorOfValues[6]=6;
		vectorOfValues[7]=7;
		values=values_aux;
		#50
		if(pos_max!=7) begin
			$display("First test failed");
			$finish;
		end
		
		#100
		vectorOfValues[3]=10;
		#10
		values=values_aux;
		#50
		if(pos_max!=3) begin
			$display("Second test failed");
			$finish;
		end
		
		#100
		vectorOfValues[2]=-25;
		#10
		values=values_aux;
		#50
		if(pos_max!=3) begin
			$display("Third test failed");
			$finish;
		end
		
				
		#100
		vectorOfValues[4]=100;
		#10
		values=values_aux;
		#50
		if(pos_max!=4) begin
			$display("Fourth test failed");
			$finish;
		end
		
		$display("All tests passed");
	end
      
endmodule

