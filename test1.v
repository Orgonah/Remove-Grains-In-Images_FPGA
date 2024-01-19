`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:08:13 06/14/2023
// Design Name:   Picture
// Module Name:   C:/fpga/HW5/test.v
// Project Name:  HW5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Picture
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg start;
	// Outputs
	wire data_valid;
	wire [7:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	Picture uut (
		.clk(clk), 
		.start(start), 
		.data_valid(data_valid), 
		.data_out(data_out)
	);
	reg [1:0] count=0;
	reg [7:0] i,j;
	integer image_file;
	reg [15:0] Counter;
	initial begin
		// Initialize Inputs
		clk = 0;
		start = 0;
		Counter = 0;
		// Wait 100 ns for global reset to finish
		#100;
      image_file = $fopen("image.bin", "wb"); 
		// Add stimulus here
		@(negedge clk) start<=1;
		wait(data_valid);
		for(i=0;i<223;i=i+1) begin
			for(j=0;j<223;) begin
				@(negedge clk)
				count<=count+1;
				if(count==2'b00) begin
					j=j+1;
					Counter<=Counter+1;
					$fwrite(image_file, "%c", data_out);
				end
			end
		end	
	end
always #10 clk<=~clk;
endmodule

