`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 04:51:07 AM
// Design Name: 
// Module Name: get_PCBranchD
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
module get_PCBranchD(
    input clock,
    input reset,
    
    input [`DATALENGTH]SignImmD_shift2,
    input [`PCSIZE] PCPlus4D,
    
    output [`PCSIZE]PCBranchD
    );
    
    assign PCBranchD = PCPlus4D + SignImmD_shift2;
endmodule
