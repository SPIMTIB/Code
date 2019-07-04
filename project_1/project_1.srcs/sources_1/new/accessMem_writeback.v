`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 03:53:43 AM
// Design Name: 
// Module Name: accessMem_writeback
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
module accessMem_writeback(
    input clock,
    input reset,
    
    // control signal
    input RegWriteM,
    input MemtoRegM,
    
    //input HiWriteM,
    //input LoWriteM,
    //input HiReadM,
    //input LoReadM,
    input HilotoRegM,
    
    input PCtoRegM, // ** added for PC
    
    // input 
    input [`DATALENGTH] ReadDataM,
    input [`DATALENGTH] ALUOutM,
    input [`R_SIZE] WriteRegM,
    
    input [`DATALENGTH] HiloDataM,
    //input [`DATALENGTH] write_hi_dataM,
    //input [`DATALENGTH] write_lo_dataM,
    
    input [`PCSIZE] PCPlus8M,  // ** added for PC
    // output
    output reg RegWriteW,
    output reg MemtoRegW,
    
    //output reg HiWriteW,
    //output reg LoWriteW,
    //output reg HiReadW,
    //output reg LoReadW,
    output reg HilotoRegW,
    
    output reg PCtoRegW,// ** added for PC
    output reg[`PCSIZE] PCPlus8W,// ** added for PC
    
    output reg[`DATALENGTH] ReadDataW,
    output reg[`DATALENGTH] ALUOutW,
    output reg[`R_SIZE] WriteRegW,
    
    //output reg[`DATALENGTH] write_hi_dataW,
    //output reg[`DATALENGTH] write_lo_dataW
    output reg[`DATALENGTH] HiloDataW
    );     
    
    always@(posedge clock)begin
        if(reset == `RESETABLE)begin
            RegWriteW <= 1'b0;
            MemtoRegW <= 1'b0;
            ReadDataW <= `ZEROWORD;
            ALUOutW <= `ZEROWORD;
            WriteRegW <= 5'b00000;
            /*
            HiWriteW <= 1'b0;
            LoWriteW <= 1'b0;
            HiReadW <= 1'b0;
            LoReadW <= 1'b0;

            write_hi_dataW <= `ZEROWORD;
            write_lo_dataW <= `ZEROWORD;
            */
            HilotoRegW <= 1'b0;
            PCtoRegW <= 1'b0;
            PCPlus8W <= `ZEROWORD;
            HiloDataW <= `ZEROWORD;
        end
        else begin
            RegWriteW <= RegWriteM;
            MemtoRegW <= MemtoRegM;
            ReadDataW <= ReadDataM;
            ALUOutW <= ALUOutM;
            WriteRegW <= WriteRegM;
            /*
            HiWriteW <= HiWriteM;
            LoWriteW <= LoWriteM;
            HiReadW <= HiReadM;
            LoReadW <= LoReadM;
            
            write_hi_dataW <= write_hi_dataM;
            write_lo_dataW <= write_lo_dataM;
            */
            HilotoRegW <= HilotoRegM;
            PCtoRegW <= PCtoRegM;
            PCPlus8W <= PCPlus8M;
            HiloDataW <= HiloDataM;
        end
    end
endmodule
