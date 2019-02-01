`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:42:19 05/17/2018
// Design Name:   comparator
// Module Name:   C:/Users/Rodrigo/Desktop/RLS/testComparator2.v
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

module testComparator2;

	// Inputs
	reg [15:0] a;
	reg [15:0] b;
	reg [3:0] pos_a;
	reg [3:0] pos_b;

	// Outputs
	wire [3:0] pos_max;

	// Instantiate the Unit Under Test (UUT)
	comparator2 uut (
		.a(a), 
		.b(b), 
		.pos_a(pos_a), 
		.pos_b(pos_b), 
		.pos_max(pos_max)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		pos_a = 0;
		pos_b = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		a=16'd5;
		b=16'd4;
		pos_a=15'd0;
		pos_b=15'd1;
		
		#50
		if(pos_max !== pos_a) begin
			$display("First test failed");
			$finish;
		end
		#50
		
		a=16'd3;
		b=16'd4;
		pos_a=15'd0;
		pos_b=15'd1;
		
		#50
		if(pos_max !== pos_b) begin
			$display("Second test failed");
			$finish;
		end
		#50
		
		a=-16'd5;
		b=16'd4;
		pos_a=15'd0;
		pos_b=15'd1;
		
		#50
		if(pos_max !== pos_b) begin
			$display("Third test failed");
			$finish;
		end
		#50
			
		a=16'd5;
		b=-16'd4;
		pos_a=15'd0;
		pos_b=15'd1;
		
		#50
		if(pos_max !== pos_a) begin
			$display("Fourth test failed");
			$finish;
		end

		$display("All test passed");
	end

      
endmodule

