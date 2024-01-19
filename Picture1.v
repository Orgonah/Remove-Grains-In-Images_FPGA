`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:01:10 06/14/2023 
// Design Name: 
// Module Name:    Picture 
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
module Picture(
    input clk,
    input start,
    output reg data_valid,
    output reg [7:0] data_out
    );
reg [15:0] addr;
reg [2:0] counter;
reg start_reg,flag=0,End=1;
reg [9:0] sum=0;
wire [7:0] dout;
reg [7:0] col_count,row_count;
reg [20:0] Counter=0;
Pic pic (
  .clka(clk), // input clka
  .wea(1'b0), // input [0 : 0] wea
  .addra(addr), // input [15 : 0] addra
  .dina(dina), // input [7 : 0] dina
  .douta(dout) // output [7 : 0] douta
);
always@(posedge clk) begin
	if(start==1) begin
		start_reg<=1;
		addr<=0;
		counter<=-1;
	end
		
	if(start_reg==1) begin
		if(flag==0) begin
			flag<=1;
			counter<=counter+1;
			addr<=addr+1;
			row_count<=0;
			col_count<=0;
		end
			
		else begin
			if(End) begin
				if(counter[1:0]==2'b00) begin
					sum=dout;
					addr<=addr+223;
					counter<=counter+1;
				end
				
				else if(counter[1:0]==2'b01) begin
					sum=sum+dout;
					addr<=addr+1;
					counter<=counter+1;
					col_count<=col_count+1;
				end
					
				else if(counter[1:0]==2'b10) begin
					if(row_count==223) begin
						End<=0;
					end
					else if(col_count==223) begin
						col_count<=0;
						addr<=addr-223;
						row_count<=row_count+1;
					end
					else
						addr<=addr-224;
						
					sum=sum+dout;
					counter<=counter+1;
				end
			
				else begin
					sum=sum+dout;
					addr<=addr+1;
					counter<=0;
					data_valid<=1;
					data_out<=sum[9:2];
					Counter=Counter+1;
				end
			end
		end
	end
end

endmodule
