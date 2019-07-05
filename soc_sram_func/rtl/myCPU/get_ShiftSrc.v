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
module get_ShiftSrc(
    input clock,
    input reset,
    
    // control signal
    input ShiftSrcE,
    
    // input 
    input [`DATALENGTH] SrcAE,
    input [`DATALENGTH] SignImmE,
    
    // output
    output [`R_SIZE] ShiftsE
    );
    assign ShiftsE = (reset == `RESETABLE) ? 5'b00000:
                       (ShiftSrcE == 1'b0) ? SrcAE[4:0]:
                        SignImmE[10:6];
    /*
    always@(*)begin
        if(reset == `RESETABLE)begin
            ShiftsE <= 5'b00000;
        end
        else begin
            case(ShiftSrcE)
            1'b0:begin
                ShiftsE <= SrcAE[4:0];
            end
            1'b1:begin
                ShiftsE <= SignImmE[10:6];
            end
            endcase
        end
    end
    */
endmodule
