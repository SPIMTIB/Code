`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2019 05:01:19 AM
// Design Name: 
// Module Name: writeback
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

module writeback(
    input wire clock,
    input wire reset,
    input wire regwrite_A,
    
    input wire[`R_SIZE]writeRegA,
    
    output reg[`R_SIZE]writeRegW,
    
    output reg regwrite_W
    );
    
    always @ (posedge clock) begin
        if(reset == `RESETABLE)begin
            regwrite_W <= 1'b0;
            writeRegW <= 5'b00000;
        end
        else begin
            regwrite_W <= regwrite_A;
            writeRegW <= writeRegA;
        end

    end
endmodule
