`timescale 1ns / 1ps
// get instrcment from instr memary
`include "defines.vh"

module get_instr(
    input wire clock,      
    input wire reset, 
    
  //  input 
    input wire[`PCSIZE] instr_addr,
    input wire[`PCSIZE] instr_from_ram,
    
    output wire [`INSTRSIZE] InstrI,   // instrcment
    output wire inst_sram_en,
    output wire [3:0] inst_sram_wen,
    output wire [`ADDRLENGTH] inst_sram_addr,
    output wire [`DATALENGTH] inst_sram_wdata
    
    );
    wire [`INSTRSIZE] Instr;
        //initial $readmemh("/home/forever/works/inst_rom.data",instr_mem);
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
        assign inst_sram_en = 'b1;
        assign inst_sram_wen = 'b0000;
        assign inst_sram_addr = instr_addr;
        assign inst_sram_wdata = 0;
        assign Instr = (reset == 1'b1)?`ZEROWORD : ((instr_from_ram & 32'h000000FF) << 24 | (instr_from_ram & 32'h0000FF00) << 8 | 
                           (instr_from_ram & 32'h00FF0000) >> 8 | (instr_from_ram & 32'hFF000000) >> 24);
        assign InstrI[31:0] = {{Instr[7:0]},{Instr[15:8]},{Instr[23:16]},{Instr[31:24]}};
    endmodule
