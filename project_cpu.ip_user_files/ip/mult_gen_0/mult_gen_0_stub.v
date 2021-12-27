// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Wed Oct 27 19:42:12 2021
// Host        : LAPTOP-LO6UQ92B running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/project/project_cpu/project_cpu.srcs/sources_1/ip/mult_gen_0/mult_gen_0_stub.v
// Design      : mult_gen_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "mult_gen_v12_0_11,Vivado 2016.2" *)
module mult_gen_0(A, B, P)
/* synthesis syn_black_box black_box_pad_pin="A[31:0],B[31:0],P[31:0]" */;
  input [31:0]A;
  input [31:0]B;
  output [31:0]P;
endmodule
