`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 01:18:33 AM
// Design Name: 
// Module Name: get_PCSrcD
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
module get_PCSrcD(
    input reset,
    
    // input
    input EqualD,
    input BranchD,
    
    // output signal
    output  PCSrcD
    );
    assign PCSrcD = (reset == `RESETABLE) ? 1'b0 : 
                    (EqualD & BranchD);
    /*
    always@(*)begin
        if(reset == `RESETABLE)begin
            PCSrcD <= 1'b0;
        end else begin
            PCSrcD <= EqualD & BranchD;
        end
    end
    */
endmodule
