`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2024 22:23:24
// Design Name: 
// Module Name: sobel_top
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


module sobel_top(
        input sys_clk_i,
        input sys_rst_i,

        input [7:0] red_i,
        input [7:0] green_i,
        input [7:0] blue_i,

        input       done_i,

        output [7:0] red_o,
        output [7:0] green_o,
        output [7:0] blue_o,

        output       done_o
    );

    //wire instantiations
    wire [7:0] grey_rgb_grey; 
    wire       done_rgb_grey;

    wire [7:0] kernel_grey_o;
    wire       done_kernel;

    RGB_to_grey rgb_to_grey_inst(
        .sys_clk_i(sys_clk_i),
		.sys_rst_i(sys_rst_i),
		
		.red_dt_i(red_i),
	    .green_dt_i(green_i),
		.blue_dt_i(blue_i),
		.done_i(done_i),
		
		.grey_dt_o(grey_rgb_grey),
		.done_o(done_rgb_grey)
        );

    sobel_kernel kernel_inst(
        .sys_clk_i(sys_clk_i),
        .sys_rst_i(sys_rst_i),

        .grey_i(grey_rgb_grey),
        .done_i(done_rgb_grey),

        .grey_o(kernel_grey_o),
        .done_o(done_kernel)
     );


    grey_to_rgb grey_to_rgb_inst(
        .sys_clk_i(sys_clk_i),
        .sys_rst_i(sys_rst_i),

        .grey_i(kernel_grey_o),
        .done_i(done_kernel),

        .red_o(red_o),
        .blue_o(blue_o),
        .green_o(green_o),

        .done_o(done_o)
    );
endmodule
