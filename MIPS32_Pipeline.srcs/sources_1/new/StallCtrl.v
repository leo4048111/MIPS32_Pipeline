`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2022 01:21:10 PM
// Design Name: 
// Module Name: StallCtrl
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

module StallCtrl(
    input rst,
    input mem_reqStall,
    input id_reqStall,
    output reg[`i5] stall
    );

always @ (*) begin
    if(rst) stall <= 5'b0;
    else if(mem_reqStall) stall <= 5'b11110;
    else if(id_reqStall) stall <= 5'b11000;
    else stall <= 5'b0;
end

endmodule