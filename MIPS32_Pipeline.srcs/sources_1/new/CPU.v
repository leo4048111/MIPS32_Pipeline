`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2022 08:11:46 PM
// Design Name: 
// Module Name: CPU
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

module CPU(
    input clk,
    input rst,
    input [`i32] IM_Inst,
    output [`i32] IM_Addr,
    output IM_rena
    );

// PC寄存器实例化
wire [`i32] pc;
wire [`i32] npc;

assign IM_Addr = pc;
assign npc = pc + 4;

PC pc_instance(
    .clk(clk),
    .rst(rst),
    .pc_wena(1),
    .npc(npc),
    .pc(pc),
    .IM_rena(IM_rena)
    );

// IF_ID模块实例化
wire [`i32] id_pc;
wire [`i32] id_inst;

IF_ID if_id_instance(
    .clk(clk),
    .rst(rst),
    .if_pc(pc),
    .if_inst(IM_Inst),
    .id_pc(id_pc),
    .id_inst(id_inst)
    );

// ID模块实例化
wire [`i32] rf_rdata1;
wire [`i32] rf_rdata2;
wire rf_rena1;
wire rf_rena2;
wire [`i5] raddr1;
wire [`i5] raddr2;
wire [`i5] id_waddr;
wire id_rf_wena;
wire [`i4] id_aluc;
wire [`i32] id_alu_a;
wire [`i32] id_alu_b;

wire [`i32] ex_out_wdata;
wire ex_out_rf_wena;
wire [`i5] ex_out_waddr;

wire [`i32] mem_out_wdata;
wire [`i5] mem_out_waddr;
wire mem_out_rf_wena;

ID id_instance(
    .rst(rst),
    .id_pc(id_pc),
    .id_inst(id_inst),
    .rf_rdata1(rf_rdata1),
    .rf_rdata2(rf_rdata2),
    .ex_out_wdata(ex_out_wdata),
    .ex_out_rf_wena(ex_out_rf_wena),
    .ex_out_waddr(ex_out_waddr),
    .mem_out_wdata(mem_out_wdata),
    .mem_out_rf_wena(mem_out_rf_wena),
    .mem_out_waddr(mem_out_waddr),
    .rf_rena1(rf_rena1),
    .rf_rena2(rf_rena2),
    .raddr1(raddr1),
    .raddr2(raddr2),
    .waddr(id_waddr),
    .rf_wena(id_rf_wena),
    .aluc(id_aluc),
    .alu_a(id_alu_a),
    .alu_b(id_alu_b)
    );

// 寄存器堆模块实例化
wire [`i32] wb_wdata;
wire wb_rf_wena;
wire [`i5] wb_waddr;
Regfile rf_instance(
    .clk(clk),
    .rst(rst),
    .waddr(wb_waddr),
    .wdata(wb_wdata),
    .rf_wena(wb_rf_wena),
    .raddr1(raddr1),
    .raddr2(raddr2),
    .rf_rena1(rf_rena1),
    .rf_rena2(rf_rena2),
    .rdata1(rf_rdata1),
    .rdata2(rf_rdata2)
    );

// ID_EX模块实例化
wire [`i5] ex_waddr;
wire ex_rf_wena;
wire [`i4] ex_aluc;
wire [`i32] ex_alu_a;
wire [`i32] ex_alu_b;

ID_EX id_ex_instance(
    .clk(clk),
    .rst(rst),
    .id_waddr(id_waddr),
    .id_rf_wena(id_rf_wena),
    .id_aluc(id_aluc),
    .id_alu_a(id_alu_a),
    .id_alu_b(id_alu_b),
    .ex_waddr(ex_waddr),
    .ex_rf_wena(ex_rf_wena),
    .ex_aluc(ex_aluc),
    .ex_alu_a(ex_alu_a),
    .ex_alu_b(ex_alu_b)
    );

// EX模块实例化
EX ex_instance(
    .rst(rst),
    .aluc(ex_aluc),
    .alu_a(ex_alu_a),
    .alu_b(ex_alu_b),
    .i_rf_wena(ex_rf_wena),
    .i_waddr(ex_waddr),
    .wdata(ex_out_wdata),
    .rf_wena(ex_out_rf_wena),
    .waddr(ex_out_waddr)
    );

// EX_MEM模块实例化
wire [`i32] mem_wdata;
wire [`i5] mem_waddr;
wire mem_rf_wena;

EX_MEM ex_mem_instance(
    .rst(rst),
    .clk(clk),
    .ex_wdata(ex_out_wdata),
    .ex_rf_wena(ex_out_rf_wena),
    .ex_waddr(ex_out_waddr),
    .mem_wdata(mem_wdata),
    .mem_rf_wena(mem_rf_wena),
    .mem_waddr(mem_waddr)
    );

// MEM模块实例化
MEM mem_instance(
    .rst(rst),
    .i_wdata(mem_wdata),
    .i_rf_wena(mem_rf_wena),
    .i_waddr(mem_waddr),
    .wdata(mem_out_wdata),
    .rf_wena(mem_out_rf_wena),
    .waddr(mem_out_waddr)
    );

// MEM_WB模块实例化
MEM_WB mem_wb_instance(
    .clk(clk),
    .rst(rst),
    .mem_wdata(mem_out_wdata),
    .mem_rf_wena(mem_out_rf_wena),
    .mem_waddr(mem_out_waddr),
    .wb_wdata(wb_wdata),
    .wb_rf_wena(wb_rf_wena),
    .wb_waddr(wb_waddr)
    );

endmodule
