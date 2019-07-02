`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2019 06:05:50 AM
// Design Name: 
// Module Name: get_J_PCBranchD
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
module get_J_PCBranchD(
    input reset,
    
    // control signal
    input J_Imi_ControlD,
    input J_Rs_ControlD,
    // input
    input [`PCSIZE]PCPlus4D,
    input [`INSTR_INDEX] instrIndex,
    input [`PCSIZE] RD1,
    // output 
    output [`PCSIZE]J_PCBranchD
    );
    
    assign J_PCBranchD = (reset == `RESETABLE) ? `ZEROWORD :
                        (J_Imi_ControlD == 1'b1)? {PCPlus4D[31:28],instrIndex,2'b00}:
                        (J_Rs_ControlD == 1'b1)? RD1
                        :`ZEROWORD;
endmodule
