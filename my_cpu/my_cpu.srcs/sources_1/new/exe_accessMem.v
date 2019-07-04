`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 03:42:26 AM
// Design Name: 
// Module Name: exe_accessMem
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
module exe_accessMem(
    input clock,
    input reset,
    
    // control signal
    input RegWriteE,
    input MemtoRegE,
    input MemWriteE,
    input HiWriteE,
    input LoWriteE,
    input HiReadE,
    input LoReadE,
    input HilotoRegE,
    
    
    input PCtoRegE,         // ** added for PC
    
    // input
    input [`DATALENGTH]ALUOutE,
    input [`DATALENGTH]WriteDataE,
    input [`R_SIZE] WriteRegE,
    

    input [`DATALENGTH]write_hi_dataE,
    input [`DATALENGTH]write_lo_dataE,
    
    input [`PCSIZE] PCPlus8E, // ** added for PC
    input [`OP_SIZE] opcodeE,
    // output 
    output reg RegWriteM,
    output reg MemtoRegM,
    output reg MemWriteM,
    
    output reg[`DATALENGTH]ALUOutM,
    output reg[`DATALENGTH]WriteDataM,
    output reg[`R_SIZE] WriteRegM,
    
    output reg HiWriteM,
    output reg LoWriteM,
    output reg HiReadM,
    output reg LoReadM,
    output reg HilotoRegM,
 
     
    output reg PCtoRegM,        // ** added for PC
    output reg [`PCSIZE] PCPlus8M,// ** added for PC
    
    
    output reg[`DATALENGTH] write_hi_dataM,
    output reg[`DATALENGTH] write_lo_dataM,
    output reg[`OP_SIZE] opcodeM
    );
    
    always @(posedge clock)begin
        if(reset == `RESETABLE)begin
            RegWriteM <= 1'b0;
            MemtoRegM <= 1'b0;
            MemWriteM <= 1'b0;
            ALUOutM <= `ZEROWORD;
            WriteDataM <= `ZEROWORD;
            WriteRegM <= 5'b00000;
            HiWriteM <= 1'b0;
            LoWriteM <= 1'b0;
            HiReadM <= 1'b0;
            LoReadM <= 1'b0;
            HilotoRegM <= 1'b0;
            write_hi_dataM <= `ZEROWORD;
            write_lo_dataM <= `ZEROWORD;
            PCtoRegM <= 1'b0;
            PCPlus8M <= `ZEROWORD;
            opcodeM <= 6'b000000;
        end
        else begin
            RegWriteM <= RegWriteE;
            MemtoRegM <= MemtoRegE;
            MemWriteM <= MemWriteE;
            ALUOutM <= ALUOutE;
            WriteDataM <= WriteDataE;
            WriteRegM <= WriteRegE;

            HiWriteM <= HiWriteE;
            LoWriteM <= LoWriteE;
            HiReadM <= HiReadE;
            LoReadM <= LoReadE;
            HilotoRegM <= HilotoRegE;
            write_hi_dataM <= write_hi_dataE;
            write_lo_dataM <= write_lo_dataE;
            PCtoRegM <= PCtoRegE;
            PCPlus8M <= PCPlus8E;
            opcodeM <= opcodeE;
        end
    end
endmodule
