`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2019 10:53:17 PM
// Design Name: 
// Module Name: get_ResultW_withHilo
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
module get_ResultW_withHilo(
    input clock,
    input reset,
    // control signal
    input HilotoRegW,
    // input
    input [`DATALENGTH] ResultW,
    input [`DATALENGTH] Hilodata,
    
    output reg[`DATALENGTH] ResultW_withHilo
    );
    
    always @(*)begin
        if(reset == `RESETABLE)begin
            ResultW_withHilo <= `ZEROWORD;
        end else begin
            if(HilotoRegW == 1'b1)begin
                ResultW_withHilo <= Hilodata;
            end else begin
                ResultW_withHilo <= ResultW;
            end
        end
    end
endmodule
