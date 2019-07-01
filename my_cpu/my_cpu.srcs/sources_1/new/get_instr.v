`timescale 1ns / 1ps
// get instrcment from instr memary
`include "defines.vh"

module get_instr(
    input wire clock,      
    input wire reset, 
    
  //  input 
    input wire[`PCSIZE] instr_addr,
    input wire[`PCSIZE] instr_from_ram,     
    
    output reg[`INSTRSIZE] InstrI,   // instrcment
    output reg inst_sram_en,
    output reg [3:0] inst_sram_wen,
    output reg [`ADDRLENGTH] inst_sram_addr,
    output reg [`DATALENGTH] inst_sram_wdata
    
    );
      
        always @ (*) begin
            if (reset == `RESETABLE) begin
                inst_sram_en<='b0;
                inst_sram_wen<='b0000;
                InstrI<=`ZEROWORD;
            end else begin
                inst_sram_en<='b1;
                inst_sram_wen<='b0000;
                inst_sram_addr<=instr_addr;
                inst_sram_wdata<=0;
                InstrI <= (instr_from_ram[instr_addr[17:2]] & 32'h000000FF) << 24 | (instr_from_ram[instr_addr[17:2]] & 32'h0000FF00) << 8 | 
                           (instr_from_ram[instr_addr[17:2]] & 32'h00FF0000) >> 8 | (instr_from_ram[instr_addr[17:2]] & 32'hFF000000) >> 24;    // because pc + 4, the lowest two bits are 00
            end
        end
        
    endmodule
