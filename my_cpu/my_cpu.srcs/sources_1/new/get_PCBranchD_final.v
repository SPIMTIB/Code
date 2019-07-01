`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2019 06:16:25 AM
// Design Name: 
// Module Name: get_PCBranchD_final
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
module get_PCBranchD_final(
    input reset,
    // control signal
    input J_Imi_ControlD,
    input J_Rs_ControlD,
    
    input [`PCSIZE]J_PCBranchD,
    input [`PCSIZE]PCBranchD,
    
    output [`PCSIZE]PCBranchD_final
    );
    assign PCBranchD_final = (reset == `RESETABLE) ? `ZEROWORD
                             :(J_Imi_ControlD  == 1'b1 || J_Rs_ControlD == 1'b1)? J_PCBranchD 
                             : PCBranchD;
endmodule
