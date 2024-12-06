`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2024 17:41:22
// Design Name: 
// Module Name: RGB_to_grey
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RGB_to_grey(
		input sys_clk_i,
		input sys_rst_i,
		
		input [7:0]	red_dt_i,
		input [7:0]	green_dt_i,
		input [7:0]	blue_dt_i,
		input 		done_i,
		
		output[7:0] grey_dt_o,
		output  	done_o);
	
	reg [7:0] grey_t;
	reg 	  done_t;
	
	
	always@(posedge sys_clk_i) begin
		
		if(sys_rst_i) begin
			grey_t <= 8'd0;
			done_t <= 1'b0;
		end else begin
		    if(done_i) begin
				grey_t <= (red_dt_i>>2)   + (red_dt_i>>5)   +
						  (green_dt_i>>1) + (green_dt_i>>4) +
						  (blue_dt_i>>4)  + (blue_dt_i>>5);
				done_t <= 1'b1;
			end else begin
				grey_t <= 8'd0;
				done_t <= 1'b0;
			end
		end
	end
	
	assign grey_dt_o = grey_t;
	assign done_o	 = done_t;
endmodule
