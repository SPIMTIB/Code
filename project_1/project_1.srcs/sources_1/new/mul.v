`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2019 07:09:49 AM
// Design Name: 
// Module Name: mul
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

module mul(
    input clock,
    input reset,
    
    input [`ALUCONTROL_SIZE] ALUControlE,
    input [`DATALENGTH]SrcAE,
    input [`DATALENGTH]SrcBE,
    
    output [`DATALENGTH] mul_hi,        // for mul
    output [`DATALENGTH] mul_lo        // for mul
    );
    
    wire [63:0]mul_result;
    wire if_sig;
    wire [`DATALENGTH] mul_data_1;
    wire [`DATALENGTH] mul_data_2;
    
    assign if_sig = (ALUControlE == `ALU_MUL)?1'b1:1'b0;
    assign mul_data_1 = (if_sig && SrcAE[31] == 1'b1)?(~SrcAE+1'b1):SrcAE;
    assign mul_data_2 = (if_sig && SrcBE[31] == 1'b1)?(~SrcBE+1'b1):SrcBE;
    assign mul_result = (SrcAE[31] ^ SrcBE[31] == 1'b1)?(~(mul_data_1 * mul_data_2)+1'b1):(mul_data_1 * mul_data_2);
    
    assign mul_hi = (reset == `RESETABLE) ?`ZEROWORD :mul_result[63:32];
    assign mul_lo = (reset == `RESETABLE) ?`ZEROWORD :mul_result[31:0];
    /*
    always @ (*) begin
        if(reset == `RESETABLE)begin
            mul_hi <= `ZEROWORD;
            mul_lo <= `ZEROWORD;
        end
        else begin
            mul_hi <= mul_result[63:32];
            mul_lo <= mul_result[31:0];              
        end
    end
    */
endmodule
