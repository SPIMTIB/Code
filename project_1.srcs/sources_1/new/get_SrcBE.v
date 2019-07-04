`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 02:58:50 AM
// Design Name: 
// Module Name: get_SrcBE
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

module get_SrcBE(
    input clock,
    input reset,
    
    // control signal
    input ALUSrcE,        // for conflict 
    
    // input
    input [`DATALENGTH] WriteDataE,
    input [`DATALENGTH] SignImmE,

    // output
    output [`DATALENGTH]SrcBE
  
    );
    assign SrcBE = (reset == `RESETABLE) ? `ZEROWORD : 
                    (ALUSrcE == 1'b0) ? WriteDataE :
                    SignImmE;
    /*
    always@(*)begin
        if(reset == `RESETABLE)begin
            SrcBE <= `ZEROWORD;
        end
        else begin
            case(ALUSrcE)
            1'b0:begin
                SrcBE <= WriteDataE;
            end
            1'b1:begin
                SrcBE <= SignImmE;
            end
            endcase
        end
    end
    */
endmodule
