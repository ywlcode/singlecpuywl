`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/01 18:55:32
// Design Name: 
// Module Name: chchch
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


module chchch(
    input wea,
    input [2:0] jump_op_c,
    output [2:0] jump_op
);

assign jump_op = (wea == 1) ? 3'b0 : jump_op_c; 

endmodule
