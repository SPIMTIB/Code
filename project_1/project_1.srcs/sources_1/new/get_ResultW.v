`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 04:10:41 AM
// Design Name: 
// Module Name: get_ResultW
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

module get_ResultW(
    input clock,
    input reset,
    
    // control signal
    input MemtoRegW,
    
    // input 
    input [`DATALENGTH] ReadDataW,
    input [`DATALENGTH] ALUOutW,
    
    // output
    output [`DATALENGTH] ResultW
    );
    
    assign ResultW = (reset == `RESETABLE)?`ZEROWORD:
                        (MemtoRegW == 1'b0) ? ALUOutW:
                        ReadDataW;
    /*
    always@(*)begin
        if(reset == `RESETABLE)begin
            ResultW <= `ZEROWORD;
        end
        else begin
            case(MemtoRegW)
            1'b0:begin
             ResultW <= ALUOutW;
            end
            1'b1:begin
             ResultW <= ReadDataW;
            end
            endcase
        end
    end
    */
endmodule
