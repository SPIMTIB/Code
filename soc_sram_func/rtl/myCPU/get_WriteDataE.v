`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 03:15:08 AM
// Design Name: 
// Module Name: get_WriteDataE
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


module get_WriteDataE(
    input clock,
    input reset,
    
    // control signal
    input [1:0] ForwardBE,
    
    // input 
    input [`DATALENGTH] RD2E,
    input [`DATALENGTH] ResultW,
    input [`DATALENGTH] ALUOutM,
    
    // output
    output [`DATALENGTH] WriteDataE
    );
    assign WriteDataE = (reset == `RESETABLE) ? `ZEROWORD :
                        (ForwardBE == 2'b00) ? RD2E:
                        (ForwardBE == 2'b01) ? ResultW:
                        (ForwardBE == 2'b10) ? ALUOutM:
                        `ZEROWORD;
    /*
    always@(*)begin
        if(reset == `RESETABLE)begin
            WriteDataE <= `ZEROWORD;
        end
        else begin
            case(ForwardBE)
            2'b00:begin
                WriteDataE <= RD2E;
            end
            2'b01:begin
                WriteDataE <= ResultW;
            end
            2'b10:begin
                WriteDataE <= ALUOutM;
            end
            2'b11:begin
                WriteDataE <= `ZEROWORD;
            end
            endcase
        end
    end
    */
endmodule
