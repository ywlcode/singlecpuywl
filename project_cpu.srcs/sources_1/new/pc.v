`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/12 15:04:51
// Design Name: 
// Module Name: try
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


module pc(
    input clka,
    input wea,
    input [31 : 0] addra,
    input [31 : 0] dina,
    output [31 : 0] douta
);

// order从地址1开始，代码结束时，dinaddr = 0, dina = 0; 

ram_code your_instance_name (
  .clka(clka),    // input wire clka
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra[15:0]),  // input wire [15 : 0] addra
  .dina(dina),    // input wire [31 : 0] dina
  .douta(douta)  // output wire [31 : 0] douta
);

endmodule
