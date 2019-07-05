`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2019 07:48:36 PM
// Design Name: 
// Module Name: mycpu_top
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


module mycpu_top(
    input wire clk,
    input wire resetn,
    input wire [5:0] int,
    
    input wire inst_sram_en,
    input wire [3:0] inst_sram_wen,
    input wire [31:0] inst_sram_addr,
    input wire [31:0] inst_sram_wdata,
    input wire [31:0] inst_sram_rdata,
    
    input wire data_sram_en,
    input wire [3:0] data_sram_wen,
    input wire [31:0] data_sram_addr,
    input wire [31:0] data_sram_wdata,
    input wire [31:0] data_sram_rdata,
    
    input wire [31:0] debug_wb_pc,
    input wire [3:0] debug_wb_rf_wen,
    input wire [4:0] debug_wb_rf_wnum,
    input wire [31:0] debug_wb_rf_wdata
    );
    
    wire _resetn;
    assign _resetn = ~resetn;
    
    mips core(
        .clock(clk),
        .reset(_resetn),
        .int(int),
        
        .inst_sram_en(inst_sram_en),
        .inst_sram_wen(inst_sram_wen),
        .inst_sram_addr(inst_sram_addr),
        .inst_sram_wdata(inst_sram_wdata),
        .inst_sram_rdata(inst_sram_rdata),
        
        .data_sram_en(data_sram_en),
        .data_sram_wen(data_sram_wen),
        .data_sram_addr(data_sram_addr),
        .data_sram_wdata(data_sram_wdata),
        .data_sram_rdata(data_sram_rdata),
        
        .debug_wb_pc(debug_wb_pc),
        .debug_wb_rf_wen(debug_wb_rf_wen),
        .debug_wb_rf_wnum(debug_wb_rf_wnum),
        .debug_wb_rf_wdata(debug_wb_rf_wdata)
    );
    
endmodule
