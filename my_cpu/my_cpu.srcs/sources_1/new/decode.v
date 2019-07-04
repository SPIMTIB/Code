`timescale 1ns / 1ps
// update PC 
`include "defines.vh"
module decode(
    input wire clock,
    input wire reset,
    
    // input 
    input wire[`INSTRSIZE] InstrD,
    
    // output
    output reg[`INSTR_INDEX]instrIndex,
    
    output reg[`R_SIZE] rs,
    output reg[`R_SIZE] rt,
    output reg[`R_SIZE] rd,
    
    output reg[`IMI_SIZE] im,
    
    output reg[`OP_SIZE] opcode,
    output reg[`OP_SIZE] funccode
    );
    
    
    
    always @ (*) begin
        if(reset == `RESETUNABLE) begin
            opcode <= InstrD[31:26];
            rs <= InstrD[25:21];
            rt <= InstrD[20:16];
            rd <= InstrD[15:11];
            im <= InstrD[15:0];
            funccode <= InstrD[5:0];
            instrIndex <= InstrD[25:0];
        end else begin 
            opcode <= 6'b0;
            rs <= 5'b0;
            rt <= 5'b0;
            rd <= 5'b0;
            im <= 15'b0;
            funccode <= 6'b0;
            instrIndex <= 26'b0;
        end
    end
    
    
endmodule
