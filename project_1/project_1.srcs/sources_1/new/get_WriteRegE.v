`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 03:37:38 AM
// Design Name: 
// Module Name: get_WriteRegE
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
module get_WriteRegE(
    input clock,
    input reset,
    
    // control signal
    input RegDstE,
    
    // input 
    input [`R_SIZE] RtE,
    input [`R_SIZE] RdE,
    
    // output
    output reg[`R_SIZE] WriteRegE
    );
    
    always@(*)begin
        if(reset == `RESETABLE)begin
            WriteRegE <= 5'b00000;
        end
        else begin
            case(RegDstE)
            1'b0:begin
                WriteRegE <= RtE;
            end
            1'b1:begin
                WriteRegE <= RdE;
            end
            endcase
        end
    end
endmodule
