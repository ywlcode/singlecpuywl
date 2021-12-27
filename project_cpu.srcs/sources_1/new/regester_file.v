`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/19 11:54:42
// Design Name: 于文龙
// Module Name: regester_file
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


module regester_file(
    input regfile_op,
    input clk,
    input [4:0] raddr1,
    input [4:0] raddr2,
    input [4:0] waddr,
    input [31:0] wdata,
    output [31:0] rdata1,
    output [31:0] rdata2,
    output [31:0] rtt1,
    output [31:0] rtt2
);

reg [31:0] rt[31:0];

always @(posedge clk) begin
    if(regfile_op) rt[waddr] = wdata;
    else rt[0] = 0;
end

assign rdata1 = (raddr1 == 5'b0) ? 32'b0 :rt[raddr1];
assign rdata2 = (raddr2 == 5'b0) ? 32'b0 :rt[raddr2];

assign rtt1 = rt[32'b1];
assign rtt2 = rt[32'b10];

endmodule
