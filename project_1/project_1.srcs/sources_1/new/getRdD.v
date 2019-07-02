`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2019 10:26:18 PM
// Design Name: 
// Module Name: getRdD
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
module getRdD(
    input clock,
    input reset,
    
    // control signal
    input RdD_31_Control,
    
    // input 
    input [`R_SIZE] rd,
    
    // output 
    output reg[`R_SIZE] RdD
    );
    
    always@(*)begin
        if(reset == `RESETABLE)begin
            RdD <= 5'b00000;
        end else begin
            if(RdD_31_Control == 1'b1)begin
                RdD <= 5'b11111;
            end else begin
                RdD <= rd;
            end
        end
    end
    
endmodule
