`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/19 11:36:26
// Design Name: 于文龙
// Module Name: cpu
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


module cpu(
    input clk,
    input wea,
    input [31:0] dinaddr,
    input [31:0] dina,
    
    output [31:0] rtt1,
    output [31:0] rtt2,
    output [4:0] ALU_op,
    output regfile_op,
    output [4:0] waddr,
    output [4:0] raddr1,
    output [4:0] raddr2,
    output [31:0] order,
    output [31:0] addra,
    output [31:0] ch_addr,
    output [31:0] oldaddr,
    output [31:0] jor_addr,
    output ch
);

wire [2:0]  dram_op;
wire [2:0]  jump_op,jump_op_c;
wire [31:0] c_order,imm32,result,data1,data2,datatoreg,wdata;


// 建议 不要这样写 实例化时最好要指明端口
pc             t1(clk,wea,addra,dina,order);
pcadd          t2(ch,ch_addr,wea,oldaddr,dinaddr,addra);// order从地址1开始，代码结束时，dinaddr = 全1, dina = 0; 
begink         t3(wea,order,c_order);
control        t4(c_order,ALU_op,regfile_op,jump_op_c,raddr1,raddr2,waddr,imm32,dram_op);
regester_file  t5(regfile_op,clk,raddr1,raddr2,waddr,wdata,data1,data2,rtt1,rtt2);
ALU            t6(ALU_op,data1,data2,imm32,result,jor_addr);
jump           t7(jump_op,data1,data2,jor_addr,ch,ch_addr);
dataram_do     t8(clk,dram_op,jor_addr,data2,datatoreg);
kkk            t9(dram_op,datatoreg,result,wdata);
pc_new_old     t10(clk,addra,oldaddr);
chchch         t11(wea,jump_op_c,jump_op);

endmodule
