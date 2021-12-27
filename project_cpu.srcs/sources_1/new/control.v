`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/26 13:39:43
// Design Name: 于文龙
// Module Name: control
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


module control(
    input [31:0] order,
    output [4:0] ALU_op,
    output regfile_op,
    output [2:0] jump_op,
    output [4:0] raddr1,
    output [4:0] raddr2,
    output [4:0] waddr,
    output [31:0] imm32,
    output [2:0] dram_op
);
reg regfile_opm;
reg [4:0] ALU_opm;
reg [2:0] jump_opm,dram_opm;
reg [4:0] raddr1m,raddr2m,waddrm;
reg [31:0] imm32m;

wire [5:0] op = order[31:26];
wire [4:0] sa = order[10:6];
wire [5:0] func = order[5:0];

wire inst_addu;
wire inst_addiu;
wire inst_subu;
wire inst_lw;
wire inst_sw;
wire inst_slt;
wire inst_sltu;
wire inst_sll;
wire inst_srl;
wire inst_sra;
wire inst_lui;
wire inst_and;
wire inst_or;
wire inst_ori;
wire inst_xor;
wire inst_nor;
wire inst_beq;
wire inst_bne;
wire inst_jal;
wire inst_jr;
wire inst_mul;
//指令译码
assign inst_addu = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b100001);
assign inst_addiu = (op == 6'b001001);
assign inst_subu = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b100011);
assign inst_mul = (op == 6'b011100) && (func == 6'b000010);
assign inst_slt = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b101010);
assign inst_sltu = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b101011);
assign inst_and = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b100100);
assign inst_nor = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b100111);
assign inst_or = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b100101);
assign inst_xor = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b100110);
assign inst_lui = (op == 6'b001111);
assign inst_sll = (op == 6'b000000) && sa && (func == 6'b000000);
assign inst_sra = (op == 6'b000000) && sa && (func == 6'b000011);
assign inst_srl = (op == 6'b000000) && sa && (func == 6'b000010);

assign inst_beq = (op == 6'b000100);
assign inst_bne = (op == 6'b000101);
assign inst_jal = (op == 6'b000011);
assign inst_jr = (op == 6'b000000) && (func == 6'b001000);

assign inst_lw = (op == 6'b100011);
assign inst_sw = (op == 6'b101011);

always @(*) begin
    if(inst_addu == 1) begin
        ALU_opm     = 1;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[25:21];
        raddr2m     = order[20:16];
        waddrm      = order[15:11];
        imm32m      = 0;
        dram_opm    = 0;
    end
    else if(inst_addiu == 1) begin
        ALU_opm     = 2;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[25:21];
        raddr2m     = 0;
        waddrm      = order[20:16];
        imm32m      = {{16{order[15]}},order[15:0]};
        dram_opm    = 0;
    end
    else if(inst_subu == 1) begin
        ALU_opm     = 3;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[25:21];
        raddr2m     = order[20:16];
        waddrm      = order[15:11];
        imm32m      = 0;
        dram_opm    = 0;
    end
    else if(inst_slt == 1) begin
        ALU_opm     = 4;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[25:21];
        raddr2m     = order[20:16];
        waddrm      = order[15:11];
        imm32m      = 0; 
        dram_opm    = 0;    
    end
    else if(inst_sltu == 1) begin
        ALU_opm     = 5;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[25:21];
        raddr2m     = order[20:16];
        waddrm      = order[15:11];
        imm32m      = 0;
        dram_opm    = 0;
    end
    else if(inst_and == 1) begin
        ALU_opm     = 6;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[25:21];
        raddr2m     = order[20:16];
        waddrm      = order[15:11];
        imm32m      = 0;
        dram_opm    = 0;
    end
    else if(inst_lui == 1) begin  
        ALU_opm     = 7;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = 0;
        raddr2m     = 0;
        waddrm      = order[20:16];
        //imm32m      = {16'b0,order[15:0]}; //测试用，简化，改成高16位置零 、
        imm32m      = {order[15:0],16'b0};
        dram_opm    = 0;
    end
    // 关于 LUI的一点点思考
    // 指令32位立即数最多为16位
    // 原本的LUI是将低16位置零，高16位赋值
    // 如此一来结合其他指令来产生32位数
    else if(inst_nor == 1) begin
        ALU_opm     = 8;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[25:21];
        raddr2m     = order[20:16];
        waddrm      = order[15:11];
        imm32m      = 0;
        dram_opm    = 0;
    end
    else if(inst_or == 1) begin
        ALU_opm     = 9;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[25:21];
        raddr2m     = order[20:16];
        waddrm      = order[15:11];
        imm32m      = 0;
        dram_opm    = 0;
    end
    else if(inst_xor == 1) begin
        ALU_opm     = 10;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[25:21];
        raddr2m     = order[20:16];
        waddrm      = order[15:11];
        imm32m      = 0;
        dram_opm    = 0;
    end
    else if(inst_sll == 1) begin
        ALU_opm     = 11;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[20:16];
        raddr2m     = 0;
        waddrm      = order[15:11];
        imm32m      = {27'b0,order[10:6]};
        dram_opm    = 0;
    end
    else if(inst_sra == 1) begin
        ALU_opm     = 12;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[20:16];
        raddr2m     = 0;
        waddrm      = order[15:11];
        imm32m      = {27'b0,order[10:6]};
        dram_opm    = 0;
    end
    else if(inst_srl == 1) begin
        ALU_opm     = 13;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[20:16];
        raddr2m     = 0;
        waddrm      = order[15:11];
        imm32m      = {27'b0,order[10:6]};
        dram_opm    = 0;
    end
    else if(inst_beq == 1) begin
        ALU_opm     = 14;
        regfile_opm = 0;
        jump_opm    = 1;
        raddr1m     = order[25:21];
        raddr2m     = order[20:16];
        waddrm      = 0;
        imm32m      = {16'b0,order[15:0]}; // 简化了，没有进行有符号扩展和加PC
        dram_opm    = 0;
    end
    else if(inst_bne == 1) begin
        ALU_opm     = 15;
        regfile_opm = 0;
        jump_opm    = 2;
        raddr1m     = order[25:21];
        raddr2m     = order[20:16];
        waddrm      = 0;
        imm32m      = {16'b0,order[15:0]}; // 简化了，没有进行有符号扩展和加PC
        dram_opm    = 0;
    end
    else if(inst_mul == 1) begin
        ALU_opm     = 16;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[25:21];
        raddr2m     = order[20:16];
        waddrm      = order[15:11]; // 溢出高位舍去
        imm32m      = 0;      
        dram_opm    = 0;
    end
    else if(inst_jal == 1) begin
        ALU_opm     = 17;
        regfile_opm = 0;
        jump_opm    = 3;
        raddr1m     = 0;
        raddr2m     = 0;
        waddrm      = 0;
        imm32m      = {6'b0,order[25:0]};
        dram_opm    = 0;
    end
    else if(inst_jr == 1) begin
        ALU_opm     = 18;
        regfile_opm = 1;
        jump_opm    = 4;
        raddr1m     = order[25:21];
        raddr2m     = 0;
        waddrm      = 0;
        imm32m      = 0;
        dram_opm    = 0;
    end
    else if(inst_sw == 1) begin
        ALU_opm     = 19;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[25:21];
        raddr2m     = order[20:16];
        waddrm      = 0;
        imm32m      = {{16{order[15]}},order[15:0]};
        dram_opm     = 1;
    end
    else if(inst_lw == 1) begin
        ALU_opm     = 20;
        regfile_opm = 1;
        jump_opm    = 0;
        raddr1m     = order[25:21];
        raddr2m     = 0;
        waddrm      = order[20:16];
        imm32m      = {{16{order[15]}},order[15:0]};
        dram_opm    = 2;
    end
    else begin
        ALU_opm     = 0;
        regfile_opm = 0;
        jump_opm    = 0;
        raddr1m     = 0;
        raddr2m     = 0;
        waddrm      = 0;
        imm32m      = 0;
        dram_opm    = 0;
    end
end

assign ALU_op     = ALU_opm;
assign regfile_op = regfile_opm;
assign jump_op    = jump_opm;
assign raddr1     = raddr1m;
assign raddr2     = raddr2m;
assign waddr      = waddrm;
assign imm32      = imm32m;
assign dram_op    = dram_opm;

endmodule
