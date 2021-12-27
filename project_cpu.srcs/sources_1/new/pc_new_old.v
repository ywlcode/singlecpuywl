`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/01 13:41:32
// Design Name: 
// Module Name: pc_new_old
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


module pc_new_old(
    input clk,
    input [31:0] addra,
    output [31:0] oldaddr
);

reg [31:0] old;


always @(posedge clk) begin
    old = addra;
end

assign oldaddr = old;

endmodule
