`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2019 01:18:20 AM
// Design Name: 
// Module Name: get_PCPLus8
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
module get_PCPLus8(
    input [`PCSIZE]PCPlus4D,
    output [`PCSIZE] PCPlus8D
    );
    assign PCPlus8D = PCPlus4D + 4;
endmodule
