`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2024 22:12:18
// Design Name: 
// Module Name: sobel_kernel
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


module sobel_kernel(
        input sys_clk_i,
        input sys_rst_i,

        input [7:0] grey_i ,
        input       done_i,

        output [7:0] grey_o,
        output       done_o
     );

    wire [7:0] data_0_i, data_1_i, data_2_i, data_3_i, data_4_i, data_5_i, data_6_i, data_7_i, data_8_i ;
    wire done_buff;

    sobel_data_buffer buff_inst(
            .sys_clk_i(sys_clk_i),
            .sys_rst_i(sys_rst_i),

            .grey_i(grey_i),
            .done_i(done_i),

            .data_0_o(data_0_i),
            .data_1_o(data_1_i),
            .data_2_o(data_2_i),
            .data_3_o(data_3_i),
            .data_4_o(data_4_i),
            .data_5_o(data_5_i),
            .data_6_o(data_6_i),
            .data_7_o(data_7_i),
            .data_8_o(data_8_i),

            .done_o(done_buff)      
    );

    sobel_calculate dut(
        .sys_clk_i(sys_clk_i),
        .sys_rst_i(sys_rst_i),

        .data_0_i(data_0_i),
        .data_1_i(data_1_i),
        .data_2_i(data_2_i),
        .data_3_i(data_3_i),
        .data_4_i(data_4_i),
        .data_5_i(data_5_i),
        .data_6_i(data_6_i),
        .data_7_i(data_7_i),
        .data_8_i(data_8_i),

        .done_i(done_buff),

        .grey_o(grey_o),
        .done_o(done_o)
    );

endmodule
