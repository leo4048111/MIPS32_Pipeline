`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2022 02:17:02 PM
// Design Name: 
// Module Name: EX_MEM
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

module EX_MEM(
    input rst,
    input clk,
    input [`i32] ex_wdata, // 来自EX的运算结果
    input ex_rf_wena, // 来自EX的写入使能信号输出
    input [`i5] ex_waddr, // 来自EX的写入地址输出
    output reg [`i32] mem_wdata, // 传递到MEM的运算结果
    output reg mem_rf_wena, // 传递到MEM的写入使能信号输出
    output reg [`i5] mem_waddr // 传递到MEM的写入地址输出
    );

always @ (posedge clk) begin
    if(rst) begin
        mem_wdata <= 0;
        mem_rf_wena <= 0;
        mem_waddr <= 0;
    end else begin
        mem_wdata <= ex_wdata;
        mem_rf_wena <= ex_rf_wena;
        mem_waddr <= ex_waddr;
    end
end

endmodule
