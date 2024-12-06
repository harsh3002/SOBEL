`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2024 18:40:51
// Design Name: 
// Module Name: sobel_data_buffer
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


module sobel_data_buffer(
            input sys_clk_i,
            input sys_rst_i,

            input [7:0] grey_i,
            input       done_i,

            output [7:0] data_0_o,
            output [7:0] data_1_o,
            output [7:0] data_2_o,
            output [7:0] data_3_o,
            output [7:0] data_4_o,
            output [7:0] data_5_o,
            output [7:0] data_6_o,
            output [7:0] data_7_o,
            output [7:0] data_8_o,

            output done_o      
    );


    wire [7:0] temp_d0, temp_d1, temp_d2;
    wire fifo_done;

    FIFO_top FIFO_inst(
        .sys_clk_i(sys_clk_i),
        .sys_rst_i(sys_rst_i),

        .data_i(grey_i),
        .wrt_ena_i(done_i),

        .data_0_o(temp_d0),
        .data_1_o(temp_d1),
        .data_2_o(temp_d2),
        .done_o(fifo_done)
    );


    data_modulate data_inst(
        .sys_clk_i(sys_clk_i),
        .sys_rst_i(sys_rst_i),

        .data_0_i(temp_d0),
        .data_1_i(temp_d1),
        .data_2_i(temp_d2),

        .done_i(fifo_done),

        .data_0_o(data_0_o),
        .data_1_o(data_1_o),
        .data_2_o(data_2_o),
        .data_3_o(data_3_o),
        .data_4_o(data_4_o),
        .data_5_o(data_5_o),
        .data_6_o(data_6_o),
        .data_7_o(data_7_o),
        .data_8_o(data_8_o),
        .done_o(done_o)
    );

endmodule
