`timescale 1ns / 1ps
// get instrcment from instr memary
`include "defines.vh"

module get_instr(
    input wire clock,      
    input wire reset, 
    
  //  input 
    input wire[`PCSIZE] instr_addr,       
    
    output [`INSTRSIZE] InstrI   // instrcment
    
    );
    
reg[`INSTRLENGTH]  instr_mem[0:`INSTR_MEM_NUM-1];
        initial $readmemh("/home/forever/works/inst_rom.data",instr_mem);
        /*
        always @ (*) begin
            if (reset == 1'b1) begin
                InstrI <= `ZEROWORD;
            end else begin
                
                 InstrI <= (instr_mem[instr_addr[17:2]] & 32'h000000FF) << 24 | (instr_mem[instr_addr[17:2]] & 32'h0000FF00) << 8 | 
                           (instr_mem[instr_addr[17:2]] & 32'h00FF0000) >> 8 | (instr_mem[instr_addr[17:2]] & 32'hFF000000) >> 24;    // because pc + 4, the lowest two bits are 00
            end
        end
        */
        assign InstrI = (reset == 1'b1)?`ZEROWORD : ((instr_mem[instr_addr[17:2]] & 32'h000000FF) << 24 | (instr_mem[instr_addr[17:2]] & 32'h0000FF00) << 8 | 
                           (instr_mem[instr_addr[17:2]] & 32'h00FF0000) >> 8 | (instr_mem[instr_addr[17:2]] & 32'hFF000000) >> 24);
    endmodule
