`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/26 11:49:41
// Design Name: 于文龙
// Module Name: dataram_do
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


module dataram_do(
  input clka,
  input [2:0] dram_op,
  input [31:0] addr,
  input [31:0] data_ram,
  output [31:0] data_reg
);

wire ena = (dram_op == 0) ? 0 : 1;
wire wea = (dram_op == 1) ? 1 : 0;

data_ram your_instance_name (
  .clka(clka),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addr),  // input wire [15 : 0] addra
  .dina(data_ram),    // input wire [31 : 0] dina
  .douta(data_reg)  // output wire [31 : 0] douta
);

endmodule
