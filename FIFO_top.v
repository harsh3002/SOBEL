`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.10.2024 11:39:00
// Design Name: 
// Module Name: FIFO_top
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


module FIFO_top(
        input sys_clk_i,
        input sys_rst_i,

        input [7:0] data_i,
        input       wrt_ena_i,

        output [7:0] data_0_o,
        output [7:0] data_1_o,
        output [7:0] data_2_o,
        output       done_o
    );

        //Wire declration 
        wire [7:0] buffer_1_data_o;
        wire       buffer_1_done_o;

        //Fifo buffer instantions
        FIFO_single_line_buffer buffer_inst_2(
        .sys_clk_i(sys_clk_i),
        .sys_rst_i(sys_rst_i),

        .data_i(data_i),
        .wrt_ena_i(wrt_ena_i),

        .data_o(buffer_1_data_o),
        .done_o(buffer_1_done_o)
    );
        
        FIFO_single_line_buffer buffer_inst_1(
        .sys_clk_i(sys_clk_i),
        .sys_rst_i(sys_rst_i),

        .data_i(buffer_1_data_o),
        .wrt_ena_i(buffer_1_done_o),

        .data_o(data_2_o),
        .done_o()
    );

    //Output assignment
    assign data_0_o = data_i ;
    assign data_1_o = buffer_1_data_o;
    assign done_o = buffer_1_done_o;
endmodule
