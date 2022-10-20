`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2022 06:14:28 PM
// Design Name: 
// Module Name: ID
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
`include "opcodes.v"

module ID(
    input rst,
    input [`i32] id_pc,
    input [`i32] id_inst,
    input [`i32] rf_rdata1, // 从Regfile读出的rdata1
    input [`i32] rf_rdata2, // 从Regfile读出的rdata2
    output rf_rena1, // 读使能信号1
    output rf_rena2, // 读使能信号2
    output [`i5] raddr1, // 寄存器堆读地址1
    output [`i5] raddr2, // 寄存器堆读地址2
    output [`i5] waddr, // 寄存器堆写地址
    output rf_wena, // 寄存器堆写使能信号
    output [`i4] aluc, // alu操作码
    output [`i32] alu_a, // alu操作数1
    output [`i32] alu_b // alu操作数2
    );

wire [`i6] op, funct;
assign op = id_inst[`op];
assign funct = id_inst[`funct];

// R型指令译码
wire ADD, ADDU, SUB, SUBU, AND, OR, XOR, NOR, SLT, SLTU, SLL, SRL, SRA, SLLV, SRLV, SRAV, JR;
assign ADD = (op == `R_type && funct == `ADD);
assign ADDU = (op == `R_type && funct == `ADDU);
assign SUB = (op == `R_type && funct == `SUB);
assign SUBU = (op == `R_type && funct == `SUBU);
assign AND = (op == `R_type && funct == `AND);
assign OR = (op == `R_type && funct == `OR);
assign XOR = (op == `R_type && funct == `XOR);
assign NOR = (op == `R_type && funct == `NOR);
assign SLT = (op == `R_type && funct == `SLT);
assign SLTU = (op == `R_type && funct == `SLTU);
assign SLL = (op == `R_type && funct == `SLL);
assign SRL = (op == `R_type && funct == `SRL);
assign SRA = (op == `R_type && funct == `SRA);
assign SLLV = (op == `R_type && funct == `SLLV);
assign SRLV = (op == `R_type && funct == `SRLV);
assign SRAV = (op == `R_type && funct == `SRAV);
assign JR = (op == `R_type && funct == `JR);

// I型指令译码
wire ADDI, ADDIU, ANDI, ORI, XORI, LW, SW, BEQ, BNE, SLTI, SLTIU, LUI;
assign ADDI = (op == `ADDI);
assign ADDIU = (op == `ADDIU);
assign ANDI = (op == `ANDI);
assign ORI = (op == `ORI);
assign XORI = (op == `XORI);
assign LW = (op == `LW);
assign SW = (op == `SW);
assign BEQ = (op == `BEQ);
assign BNE = (op == `BNE);
assign SLTI = (op == `SLTI);
assign SLTIU = (op == `SLTIU);
assign LUI = (op == `LUI);

// J型指令译码
wire J,JAL;
assign J = (op == `J);
assign JAL = (op == `JAL);

// 寄存器堆控制信号
assign rf_rena1 = rst ? 0 : (~(J|JAL|LUI));
assign rf_rena2 = rst ? 0 : (~(J|JAL|LUI|ADDI|ADDIU|ANDI|ORI|XORI|LW|SW|BEQ|BNE|SLTI|SLTIU|LUI));
assign raddr1 = rst ? 0 : id_inst[`rs];
assign raddr2 = rst ? 0 : id_inst[`rt];
assign waddr = rst ? 0 : (JAL ? 31 : (op ? id_inst[`rt] : id_inst[`rd]));
assign rf_wena = rst ? 0 : (~(JR|SW|BEQ|BNE|J));

// ALU控制信号与运算数
wire [`i5] shamt;
assign shamt = id_inst[`shamt];

wire should_sign_ext;
assign should_sign_ext = ADDI | ADDIU | SLTI | SLTIU;

assign aluc[0] = SUBU | SUB | BEQ | BNE | OR | ORI | NOR  | SLT | SLTI | SRL | SRLV;
assign aluc[1] = ADD | ADDI | SUB | BEQ | BNE | XOR | XORI | NOR | SLT | SLTI | SLTU | SLTIU | SLL | SLLV;
assign aluc[2] = AND | ANDI | OR | ORI | XOR | XORI | NOR | SRA | SRAV | SLL | SLLV | SRL | SRLV;
assign aluc[3] = LUI | SLT | SLTI | SLTU | SLTIU | SRA | SRAV | SLL | SLLV | SRL | SRLV;
assign alu_a = rst ? 0 : ((SLL|SRL|SRA) ? {23'b0, shamt} : rf_rdata1);
assign alu_b = rst ? 0 : (op && !BEQ && !BNE ? (should_sign_ext ? {{16{id_inst[15]}}, id_inst[15:0]} : {16'b0, id_inst[15:0]}) : rf_rdata2);

endmodule
