`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/19 11:38:22
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [4:0] ALU_op,
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] imm,
    output [31:0] result,
    output [31:0] jump_addr
);

wire [31:0] mul_result, temp;

assign jump_addr = (ALU_op == 14 || ALU_op == 15 || ALU_op == 17 ) ? imm :
                    (ALU_op == 19 || ALU_op == 20) ? data1 + imm : 0;

mult_gen_0 mul (
  .A(data1),  // input wire [31 : 0] A
  .B(data2),  // input wire [31 : 0] B
  .P(mul_result)  // output wire [31 : 0] P
);

assign temp = data1 - data2;

assign result = (ALU_op == 1) ? data1 + data2 :
                (ALU_op == 2) ? data1 + imm :
                (ALU_op == 3) ? data1 - data2 :
                (ALU_op == 4) ? (data1[31] & ~data2[31]) | 
                                ((data1[31] & data2[31]) == 0 & temp[31] == 0) | 
                                ((data1[31] & data2[31]) == 1 & temp[31] == 1):
                (ALU_op == 5) ? data1 < data2:
                (ALU_op == 6) ? data1 & data2:
                (ALU_op == 7) ? imm:
                (ALU_op == 8) ? ~(data1 | data2):
                (ALU_op == 9) ? data1 | data2:
                (ALU_op == 10)? data1 ^ data2:
                (ALU_op == 11)? data1 << imm: // 逻辑 左移
                (ALU_op == 12)? ((data1 >> imm[4:0]) | ( (~data2) << (32 - imm[4:0]))): //算术 右移
                (ALU_op == 13)? data1 >> imm: // 逻辑 右移
                (ALU_op == 16)? mul_result: 0;
endmodule

/*
always @(*) begin
    if(ALU_op == 1 || ALU_op == 2) begin //加法
        resultm    = data1+data2;
        jump_addrm = 0;
    end
    if(ALU_op == 3) begin // 减法
        resultm    = data1-data2;
        jump_addrm = 0;
    end
    if(ALU_op == 4) begin // 有符号数比较
        resultm    = (data1[31] & ~data2[31]) 
                    | ((data1[31] & data2[31])==0 & temp[31]==0)
                    | ((data1[31] & data2[31])==1 & temp[31]==1);
        jump_addrm = 0;
    end
    if(ALU_op == 5) begin // 无符号数比较
        resultm    = data1 < data2;
        jump_addrm = 0;
    end
    if(ALU_op == 6) begin //AND
        resultm    = data1 & data2;
        jump_addrm = 0;
    end
    if(ALU_op == 7) begin //LUI
        resultm    = imm;
        jump_addrm = 0;
    end
    if(ALU_op == 8) begin //NOR
        resultm    = ~(data1 & data2);
        jump_addrm = 0;
    end
    if(ALU_op == 9) begin //OR
        resultm    = data1 | data2;
        jump_addrm = 0;
    end
    if(ALU_op == 10) begin //XOR
        resultm    = data1 ^ data2;
        jump_addrm = 0;
    end
    if(ALU_op == 11) begin //SLL
        resultm    = data1 << imm;
        jump_addrm = 0;
    end
    if(ALU_op == 12) begin //SRA
        resultm    = data1 >>> imm;
        jump_addrm = 0;
    end
    if(ALU_op == 13) begin //SRL
        resultm    = data1 >> imm;
        jump_addrm = 0;
    end
    if(ALU_op == 14 || ALU_op == 15) begin //BEQ BNE
        resultm    = 0;
        jump_addrm = imm;
    end
    if(ALU_op == 16) begin //MUL
        resultm    = mul_result;
        jump_addrm = 0;
    end
    if(ALU_op == 17) begin //JAL
        resultm    = 0;
        jump_addrm = imm;
    end
    if(ALU_op == 18) begin //JL
        resultm    = 0;
        jump_addrm = 0;
    end
    if(ALU_op == 19 || ALU_op == 20) begin //SW LW
        resultm    = 0;
        jump_addrm = data1 + imm;
    end
end
*/