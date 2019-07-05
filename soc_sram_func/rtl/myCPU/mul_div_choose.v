`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2019 07:04:34 AM
// Design Name: 
// Module Name: mul_div_choose
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
module mul_div_choose(
    input clock,
    input reset,
    
    input [`ALUCONTROL_SIZE] ALUControlE,
    input [`DATALENGTH] SrcAE,
    
    input  div_start,
    input  div_end,
    input [`DATALENGTH] div_hi_data,
    input [`DATALENGTH] div_lo_data,
    
    input [`DATALENGTH] mul_hi_data,
    input [`DATALENGTH] mul_lo_data,
    
    // to be added diving ? ?  for harzard
    output reg [1:0] status,
    
    
    output reg[`DATALENGTH]write_hi_dataE,
    output reg[`DATALENGTH]write_lo_dataE
    
    
    );
    
    always @ (*) begin
        if(reset == `RESETABLE)begin
            write_hi_dataE <= `ZEROWORD;
            write_lo_dataE <= `ZEROWORD;
        end
        else begin
            case(ALUControlE)
                `ALU_MUL,`ALU_MULU:begin
                    write_hi_dataE <= mul_hi_data;
                    write_lo_dataE <= mul_lo_data;
                    status <= 2'b00;
                end
               `ALU_DIV,`ALU_DIVU:begin

                    if(div_start == 1'b0 && div_end == 1'b0)begin
                        status <= 2'b01;
                    end else if(div_start == 1'b0 && div_end == 1'b1)begin
                        status <= 2'b00;
                        write_hi_dataE <= div_hi_data;
                        write_lo_dataE <= div_lo_data;
                    end else if(div_start == 1'b1 && div_end == 1'b0)begin
                        status <= 2'b10;
                    end
                end
                `ALU_MTHI:begin
                    status <= 2'b00;
                    write_lo_dataE <= `ZEROWORD;
                    write_hi_dataE <= SrcAE;
                end
                `ALU_MTLO:begin
                    status <= 2'b00;
                    write_lo_dataE <= SrcAE;
                    write_hi_dataE <= `ZEROWORD;
                end
                default:begin
                    write_hi_dataE <= `ZEROWORD;
                    write_lo_dataE <= `ZEROWORD;
                end
            endcase
        end
    end
    
    
  
endmodule
