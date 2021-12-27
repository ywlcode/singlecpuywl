`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/01 16:01:32
// Design Name: 
// Module Name: begin
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


module begink(
    input wea,
    input [31:0] order,
    output [31:0] c_order
);

assign c_order = (wea == 0) ? order: 32'b0;

endmodule
