`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 12:52:02 AM
// Design Name: 
// Module Name: PC_ALU
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

`include "defines.vh"
module PC_ALU(
    input [`PCSIZE]PCF,
    output reg[`PCSIZE] PCPlus4F
    );
    
    always@(*)begin
        PCPlus4F <= PCF + 4;
    end
    
endmodule
