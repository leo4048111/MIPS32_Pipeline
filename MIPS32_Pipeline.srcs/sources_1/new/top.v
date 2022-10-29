`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2022 07:10:27 PM
// Design Name: 
// Module Name: top
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

`include "defines.v"

module top(
    input clk,
    input rst
    );

wire [`i32] IM_Inst;
wire [`i32] pc;
wire IM_rena;

CPU cpu_instance(
    .clk(clk),
    .rst(rst),
    .IM_Inst(IM_Inst),
    .pc(pc),
    .IM_rena(IM_rena)
    );

wire [10:0] IM_Addr = (pc - 32'h00400000) >> 2;

IMEM imem_instance(
    .IM_Addr(IM_Addr),
    .IM_rena(IM_rena),
    .IM_Inst(IM_Inst)
    );
endmodule
