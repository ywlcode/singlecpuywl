`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/26 23:08:51
// Design Name: 
// Module Name: kkk
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


module kkk(
    input [2:0] op,
    input [31:0] datatoreg,
    input [31:0] ALU_result,
    output [31:0] wdata
);

assign wdata = (op == 3'b0) ? ALU_result : datatoreg;

endmodule
