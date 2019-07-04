`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 02:58:50 AM
// Design Name: 
// Module Name: decode_exe
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

module get_SrcAE(
    input clock,
    input reset,
    
    // control signal
    input [1:0]ForwardAE,        // for conflict 
    
    // input
    input [`DATALENGTH] RD1E,
    input [`DATALENGTH] ResultW,
    input [`DATALENGTH] ALUOutM,

    // output
    output [`DATALENGTH]SrcAE
  
    );
    assign SrcAE = (reset == `RESETABLE) ? `ZEROWORD :
                    (ForwardAE == 2'b00) ? RD1E    :
                    (ForwardAE == 2'b01) ? ResultW :
                    (ForwardAE == 2'b10) ? ALUOutM :
                    `ZEROWORD;
     /*       
    always@(*)begin
        if(reset == `RESETABLE)begin
            SrcAE <= `ZEROWORD;
        end
        else begin
            case(ForwardAE)
            2'b00:begin
                SrcAE <= RD1E;
            end
            2'b01:begin
                SrcAE <= ResultW;
            end
            2'b10:begin
                SrcAE <= ALUOutM;
            end
            2'b11:begin
                SrcAE <= `ZEROWORD;
            end
            endcase
        end
    end
    */
endmodule
