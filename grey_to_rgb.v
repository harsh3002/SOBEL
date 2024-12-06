`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2024 21:54:34
// Design Name: 
// Module Name: grey_to_rgb
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


module grey_to_rgb(
        input  sys_clk_i,
        input  sys_rst_i,

        input [7:0] grey_i,
        input       done_i,

        output reg [7:0] red_o,
        output reg [7:0] blue_o,
        output reg [7:0] green_o,

        output       done_o
    );

    always @(posedge sys_clk_i) begin
        if (sys_rst_i) begin
            red_o <= 0;
            green_o <= 0;
            blue_o <= 0;
        end else begin
            red_o <= grey_i ;
            green_o <= grey_i ;
            blue_o <= grey_i ;
        end
    end

    assign done_o = done_i ;
endmodule
