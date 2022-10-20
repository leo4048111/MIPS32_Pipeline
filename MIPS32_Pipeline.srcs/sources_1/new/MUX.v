`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2022 11:35:37 AM
// Design Name: 
// Module Name: MUX
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

module MUX (
    input [`i32] in_0,
    input [`i32] in_1,
    output reg [`i32] Q,
    input A
);

always @ (in_0,in_1,A) begin
    if(A == 0) 
        Q = in_0;
    else if(A == 1)
        Q = in_1;
end

endmodule

module MUX4(
    input [`i32] in_0,
    input [`i32] in_1,
    input [`i32] in_2,
    input [`i32] in_3,
    output reg [`i32] Q, 
    input [1:0] A
);

always @(in_0,in_1,in_2,in_3,A) begin
    if(A === 0) 
        Q = in_0;
    else if(A === 1)
        Q = in_1;
    else if(A == 2)
        Q = in_2; 
    else if(A == 3)
        Q = in_3;
end

endmodule

module MUX8(
    input  [`i32] in_0,
    input  [`i32] in_1,
    input  [`i32] in_2,
    input  [`i32] in_3,
    input  [`i32] in_4,
    input  [`i32] in_5,
    input  [`i32] in_6,
    input  [`i32] in_7,
    output reg [`i32] Q,
    input [2:0] A
);

always @(in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7,A) begin
    if(A === 0) 
        Q = in_0;
    else if(A === 1)
        Q = in_1;
    else if(A == 2)
        Q = in_2; 
    else if(A == 3)
        Q = in_3;
    else if(A == 4)
        Q = in_4;
    else if(A == 5)
        Q = in_5;
    else if(A == 6)
        Q = in_6;
    else if(A == 7)
        Q = in_7;
end

endmodule

