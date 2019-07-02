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
    input reset,

    input [`PCSIZE]PCF,
    output [`PCSIZE] PCPlus4F
    );
    
    assign PCPlus4F = (reset == `RESETABLE)?`ZEROWORD:PCF+4;
    /*
    always@(*)begin
        if(reset == `RESETABLE)begin
            PCPlus4F <= `ZEROWORD;
        end else begin
            PCPlus4F <= PCF + 4;
        end

    end
    */
endmodule
