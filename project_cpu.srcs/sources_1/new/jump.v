`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/26 21:55:48
// Design Name: 于文龙
// Module Name: jump
// Project Name: CPU
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


module jump(
    input [2:0] jump_op,
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] jump_addr,
    output ch,
    output [31:0] ch_addr
);

assign ch_addr = (jump_op == 4) ? data1 : jump_addr;

assign ch      = (jump_op == 1 && data1 == data2) ? 1:
                 (jump_op == 2 && data1 != data2) ? 1:
                 (jump_op == 3 || jump_op == 4)   ? 1:0;

endmodule
