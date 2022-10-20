`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2022 04:38:52 PM
// Design Name: 
// Module Name: tb_CPU
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


module tb_CPU;

reg clk = 0;
reg rst = 1;

reg [31:0] IM_Inst;

initial begin
#11 rst = 0;
#14 IM_Inst = 32'h34011100;
#20 IM_Inst = 32'h34020020;
#20 IM_Inst = 32'h3403ff00;
#20 IM_Inst = 32'b001000_00001_00001_0000000000000001;
end

CPU uut(
    .clk(clk),
    .rst(rst),
    .IM_Inst(IM_Inst)
    );

always #10 clk = ~clk;

endmodule
