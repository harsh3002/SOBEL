`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2024 18:29:45
// Design Name: 
// Module Name: FIFO_single_line_buffer
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


module FIFO_single_line_buffer(
        input sys_clk_i,
        input sys_rst_i,

        input [7:0] data_i,
        input       wrt_ena_i,

        output [7:0] data_o,
        output       done_o
    );

    //Register declaration
    parameter  DEPTH = 699;
    reg [7:0] buff_mem [0: DEPTH - 1];

    // Read Write pointer declaration
    reg [9:0] rd_ptr, wrt_ptr;

    //Counter declaration 
    reg [9:0] iCounter;

    // Counter handling
    always @(posedge sys_clk_i ) begin
        if (sys_rst_i) begin
            iCounter <= 0;
        end else begin
            if (wrt_ena_i) begin
                iCounter <= (iCounter == DEPTH) ? iCounter : iCounter + 1 ;
            end
        end
    end

    // Read pointer handling 
    always @(posedge sys_clk_i ) begin
        if (sys_rst_i) begin
            rd_ptr <= 0;
        end else begin
            if (wrt_ena_i) begin
                if (iCounter == DEPTH) begin
                    rd_ptr <= (rd_ptr == DEPTH - 1 ) ? 0 : rd_ptr + 1;
                end
            end
        end
    end

    // Write pointer handling 
    always @(posedge sys_clk_i ) begin
        if (sys_rst_i) begin
            wrt_ptr <= 0;
        end else begin
            if (wrt_ena_i) begin
               buff_mem[wrt_ptr] <= data_i ;
               wrt_ptr <= (wrt_ptr == DEPTH - 1) ? 0 : wrt_ptr + 1; 
            end
        end
    end

    //OUTPUT Declaration 

    assign done_o = (iCounter == DEPTH) ? 1 : 0;
    assign data_o = buff_mem[rd_ptr];
endmodule
