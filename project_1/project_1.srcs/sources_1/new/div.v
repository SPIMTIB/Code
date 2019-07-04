`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2019 05:17:22 AM
// Design Name: 
// Module Name: div
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


module div(
    input clock,
    input reset,
    
    input [1:0]isDiv,
    
    input [`DATALENGTH] SrcAE,
    input [`DATALENGTH] SrcBE,
    
    output [`DATALENGTH] div_hi,
    output [`DATALENGTH] div_lo,
    output busy
    
    );
    
   
endmodule
