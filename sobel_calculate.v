`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2024 15:02:09
// Design Name: 
// Module Name: sobel_calculate
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


module sobel_calculate(
        input sys_clk_i,
        input sys_rst_i,

        input [7:0] data_0_i,
        input [7:0] data_1_i,
        input [7:0] data_2_i,
        input [7:0] data_3_i,
        input [7:0] data_4_i,
        input [7:0] data_5_i,
        input [7:0] data_6_i,
        input [7:0] data_7_i,
        input [7:0] data_8_i,

        input done_i,

        output reg [7:0] grey_o,
        output       done_o
    );

        //variable to store x values
        reg [9:0] gp_x ;
        reg [9:0] gn_x ;
        reg [9:0] gd_x ;

        // variables to store y values
        reg [9:0] gp_y ;
        reg [9:0] gn_y ;
        reg [9:0] gd_y ;

        //store sum 
        reg [9:0] g_sum ;

        // procedure for getting g_x & g_y 
        always @(posedge sys_clk_i ) begin
            if (sys_rst_i) begin
                gp_x <= 0;
                gn_x <= 0;
            end else begin
                gp_x <= data_0_i + (data_3_i << 1) + data_6_i ;
                gn_x <= data_2_i + (data_5_i << 1) + data_8_i ;
            end
        end

        always @(posedge sys_clk_i ) begin
            if (sys_rst_i) begin
                gp_y <= 0;
                gn_y <= 0;
            end else begin
                gp_y <= data_0_i + (data_1_i << 1) + data_2_i ;
                gn_y <= data_6_i + (data_7_i << 1) + data_8_i ;
            end
        end

        //procedure for gd_x & gd_y
        always @(posedge sys_clk_i) begin
            if (sys_rst_i) begin
                gd_x <= 0;
            end else begin
                gd_x <= (gp_x > gn_x) ? (gp_x - gn_x) : (gn_x - gp_x) ;

            end
        end

        always @(posedge sys_clk_i) begin
            if (sys_rst_i) begin
                gd_y <= 0;
            end else begin
                gd_y <= (gp_y > gn_y) ? (gp_y - gn_y) : (gn_y - gp_y) ;
                
            end
        end

        // procedure for g_sum
        always @(posedge sys_clk_i) begin
            if (sys_rst_i) begin
                g_sum <= 0;
            end else begin
                g_sum <= gd_x + gd_y ;
            end
        end
        
        //procedure for grey_o(Thresholding function)
        always @(posedge sys_clk_i) begin
            if (sys_rst_i) begin
                grey_o <= 0;
            end else begin
                grey_o <= (g_sum > 8'd175) ? 8'd255 : g_sum[7:0] ;
            end
        end

        //procedure for done_o
        reg [3:0] done_shift;
        always @(posedge sys_clk_i) begin
            if (sys_rst_i) begin
                done_shift <= 0;
            end else begin
                done_shift <= {done_shift[2:0] , done_i} ;
            end
        end

        assign done_o = done_shift[3] ;

endmodule
