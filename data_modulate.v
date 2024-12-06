`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2024 10:46:17
// Design Name: 
// Module Name: data_modulate
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


module data_modulate(
        input sys_clk_i,
        input sys_rst_i,

        input [7:0] data_0_i,
        input [7:0] data_1_i,
        input [7:0] data_2_i,

        input       done_i,

        output reg [7:0] data_0_o ,
        output reg [7:0] data_1_o ,
        output reg [7:0] data_2_o ,
        output reg [7:0] data_3_o ,
        output reg [7:0] data_4_o ,
        output reg [7:0] data_5_o ,
        output reg [7:0] data_6_o ,
        output reg [7:0] data_7_o ,
        output reg [7:0] data_8_o ,

        output           done_o
    );

    localparam ROWS = 559 ;
    localparam COLUMNS = 699 ;

    reg [7:0] d0,d1,d2,d3,d4,d5,d6,d7,d8 ;

    //Handle the shift register
    always @(posedge sys_clk_i) begin
        if (sys_rst_i) begin
            d0 <= 0;
            d1 <= 0;
            d2 <= 0;
            d3 <= 0;
            d4 <= 0;
            d5 <= 0;
            d6 <= 0;
            d7 <= 0;
            d8 <= 0;
        end else begin
            if (done_i) begin
                d0 <= d1;
                d1 <= d2;
                d2 <= data_2_i;

                d3 <= d4;
                d4 <= d5;
                d5 <= data_1_i;

                d6 <= d7;
                d7 <= d8;
                d8 <= data_0_i;
            end
        end
    end

    //Handle the done_o signal
    reg [7:0] count ;
    assign done_o = (count == 2) ? 1 : 0;
    always @(posedge sys_clk_i) begin
        if (sys_rst_i) begin
            count <= 0;
        end else begin
            if (done_i) begin
                count <= (count == 2) ? count : count + 1 ;
            end
        end
    end


    //Handle the special pixels
    reg [9:0] rows, cols ;

    always @(posedge sys_clk_i) begin
        if (sys_rst_i) begin
            rows <= 0;
            cols <= 0;
        end else begin
            if (done_o) begin
              cols <= (cols == COLUMNS - 1) ? 0 : cols + 1 ;
              if (cols == COLUMNS - 1) begin
                rows <= (rows == ROWS - 1) ? 0 : rows + 1 ;
              end
            end
        end
    end

    always @(*) begin
        if (sys_rst_i) begin
            data_0_o <= 0;
            data_1_o <= 0;
            data_2_o <= 0;
            data_3_o <= 0;
            data_4_o <= 0;
            data_5_o <= 0;
            data_6_o <= 0;
            data_7_o <= 0;
            data_8_o <= 0;
        end else begin
            if (done_o) begin
                //handle corner 1
                if ((rows == 0) && (cols == 0)) begin
                    data_0_o <= 0;
                    data_1_o <= 0;
                    data_2_o <= 0;
                    data_3_o <= 0;
                    data_4_o <= d4;
                    data_5_o <= d5;
                    data_6_o <= 0;
                    data_7_o <= d7;
                    data_8_o <= d8;
                end

                //handle corner 2
                else if ((rows == 0) && (cols == COLUMNS - 1)) begin
                    data_0_o <= 0;
                    data_1_o <= 0;
                    data_2_o <= 0;
                    data_3_o <= d3;
                    data_4_o <= d4;
                    data_5_o <= 0;
                    data_6_o <= d6;
                    data_7_o <= d7;
                    data_8_o <= 0;
                end

                //handle corner 3
                else if ((rows == ROWS - 1) && (cols == 0)) begin
                    data_0_o <= 0;
                    data_1_o <= d1;
                    data_2_o <= d2;
                    data_3_o <= 0;
                    data_4_o <= d4;
                    data_5_o <= d5;
                    data_6_o <= 0;
                    data_7_o <= 0;
                    data_8_o <= 0;
                end

                //handle corner 4
                else if ((rows == ROWS - 1) && (cols == COLUMNS - 1)) begin
                    data_0_o <= d0;
                    data_1_o <= d1;
                    data_2_o <= 0;
                    data_3_o <= d3;
                    data_4_o <= d4;
                    data_5_o <= 0;
                    data_6_o <= 0;
                    data_7_o <= 0;
                    data_8_o <= 0;
                end

                //handle edge 1
                else if ((rows == 0) && (cols > 0) && (cols < COLUMNS - 1)) begin
                    data_0_o <= 0;
                    data_1_o <= 0;
                    data_2_o <= 0;
                    data_3_o <= d3;
                    data_4_o <= d4;
                    data_5_o <= d5;
                    data_6_o <= d6;
                    data_7_o <= d7;
                    data_8_o <= d8;
                end

                //handle edge 2
                else if ((rows > 0) && (rows < ROWS - 1) && (cols == 0)) begin
                    data_0_o <= 0;
                    data_1_o <= d1;
                    data_2_o <= d2;
                    data_3_o <= 0;
                    data_4_o <= d4;
                    data_5_o <= d5;
                    data_6_o <= 0;
                    data_7_o <= d7;
                    data_8_o <= d8;
                end

                //handle edge 3
                else if ((rows > 0) && (rows < ROWS - 1) && (cols == COLUMNS - 1)) begin
                    data_0_o <= d0;
                    data_1_o <= d1;
                    data_2_o <= 0;
                    data_3_o <= d3;
                    data_4_o <= d4;
                    data_5_o <= 0;
                    data_6_o <= d6;
                    data_7_o <= d7;
                    data_8_o <= 0;
                end

                //handle edge 4
                else if ((rows == ROWS - 1) && (cols > 0) && (cols < COLUMNS - 1)) begin
                    data_0_o <= d0;
                    data_1_o <= d1;
                    data_2_o <= d2;
                    data_3_o <= d3;
                    data_4_o <= d4;
                    data_5_o <= d5;
                    data_6_o <= 0;
                    data_7_o <= 0;
                    data_8_o <= 0;
                

                //handle middle pixel
               end else if ((rows > 0) && (rows < ROWS - 1) && (cols > 0) && (cols < COLUMNS - 1)) begin
                    data_0_o <= d0;
                    data_1_o <= d1;
                    data_2_o <= d2;
                    data_3_o <= d3;
                    data_4_o <= d4;
                    data_5_o <= d5;
                    data_6_o <= d6;
                    data_7_o <= d7;
                    data_8_o <= d8;
                end
            end
        end
    end
endmodule
