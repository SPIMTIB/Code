`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 04:47:03 AM
// Design Name: 
// Module Name: shift_unit
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
module shift_unit(
    input clock,
    input reset,
    
    // input
    input [`DATALENGTH] SignImmD,
    // output 
    output [`DATALENGTH] SignImmD_shift2
    );
    
    assign SignImmD_shift2 = {SignImmD[29:0],2'b00};
endmodule
