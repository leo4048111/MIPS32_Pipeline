`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2022 10:40:58 AM
// Design Name: 
// Module Name: ID_EX
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

module ID_EX(
    input clk,
    input rst,

    // 来自ID的信息
    input [`i5] id_waddr, // 寄存器堆写地址
    input id_rf_wena, // 寄存器堆写使能信号
    input [`i4] id_aluc, // alu操作码
    input [`i32] id_alu_a, // alu操作数1
    input [`i32] id_alu_b, // alu操作数2

    // 传递到EX的信息
    output reg [`i5] ex_waddr, // 寄存器堆写地址
    output reg ex_rf_wena, // 寄存器堆写使能信号
    output reg [`i4] ex_aluc, // alu操作码
    output reg [`i32] ex_alu_a, // alu操作数1
    output reg [`i32] ex_alu_b // alu操作数2
    );

always @ (posedge clk) begin
    if(rst) begin
        ex_waddr <= 0;
        ex_rf_wena <= 0;
        ex_aluc <= 0;
        ex_alu_a <= 0;
        ex_alu_b <= 0;
    end else begin
        ex_waddr <= id_waddr;
        ex_rf_wena <= id_rf_wena;
        ex_aluc <= id_aluc;
        ex_alu_a <= id_alu_a;
        ex_alu_b <= id_alu_b;
    end
end

endmodule
