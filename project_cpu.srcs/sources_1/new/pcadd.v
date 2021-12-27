`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/01 11:16:08
// Design Name: 
// Module Name: pcadd
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


module pcadd(
    input ch,
    input [31:0] ch_addr,
    input wea,
    input [31:0] oldaddr,
    input [31:0] dinaddr,
    output [31:0] addra
);

wire [31:0] newaddra;

assign newaddra = (ch == 1) ? ch_addr : oldaddr+1;

assign addra = (wea == 1) ? dinaddr : newaddra;

endmodule
