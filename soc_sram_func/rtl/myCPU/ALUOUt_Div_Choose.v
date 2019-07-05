`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2019 12:50:37 AM
// Design Name: 
// Module Name: ALUOUt_Div_Choose
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
module ALUOut_Div_Choose(
    // signal
       input isDiv,
       // input
       input [`DATALENGTH] ALUOutHigh,
       input [`DATALENGTH] ALUOutLow,
       input [`DATALENGTH] DivHigh,
       input [`DATALENGTH] DivLow,
       
       output [`DATALENGTH] High,
       output [`DATALENGTH] Low
);     
      assign High = (isDiv == 1'b1)?DivHigh:ALUOutHigh;
      assign Low = (isDiv == 1'b1)?DivLow:ALUOutLow;
endmodule
