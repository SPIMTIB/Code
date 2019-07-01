`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 12:56:24 AM
// Design Name: 
// Module Name: instr_decode
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


module instr_decode(
    input clock,
    input reset,
    
    // control signal
    input StallD,       // deal with conflict, to be done
    input PCSrcD,       // for clear , to be done
    
    // input 
    input [`INSTRLENGTH] InstrI,
    input [`PCSIZE] PCPlus4F,
    
    
    // output
    output reg[`INSTRLENGTH] InstrD,
    output reg[`PCSIZE] PCPlus4D
    
    );
    
    always@(posedge clock)begin
        if(reset == `RESETABLE || PCSrcD == 1'b1)begin
            InstrD <= `ZEROWORD;
        end else if(StallD == 1'b1 )begin
            InstrD <= InstrD;
            PCPlus4D <= PCPlus4D;   
        end else begin
            InstrD <= InstrI;
            PCPlus4D <= PCPlus4F;
        end
    end
endmodule
