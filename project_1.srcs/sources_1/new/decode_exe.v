`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 02:58:50 AM
// Design Name: 
// Module Name: decode_exe
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

module decode_exe(
    input clock,
    input reset,
    
    // control signal
    input RegWriteD,
    input MemtoRegD,
    input MemWriteD,
    input [`ALUCONTROL_SIZE]ALUControlD,
    input ALUSrcD,
    input RegDstD,
    input HiWriteD,
    input LoWriteD,
    input HiReadD,
    input LoReadD,
    input HilotoRegD,
	input ShiftSrcD,	//hjw
	input [1:0]isDivD,
	//input [`OP_SIZE] opcodeD,
	input [3:0]MemCtrlD,
	
    
    input PCtoRegD,             //  ** added for PC
    
    input FlushE,           // for conflict , to be done
    // input
    input [`DATALENGTH]RD1D,
    input [`DATALENGTH]RD2D,
    input [`R_SIZE]RsD,
    input [`R_SIZE]RtD,
    input [`R_SIZE]RdD,
    
    input [`DATALENGTH]SignImmD,
    
    input [`PCSIZE] PCPlus8D,          // **added for PC
    
    // output
    output reg RegWriteE,
    output reg MemtoRegE,
    output reg MemWriteE,
    output reg[`ALUCONTROL_SIZE] ALUControlE,
    output reg ALUSrcE,
    output reg RegDstE,
	output reg ShiftSrcE,   //hjw
    output reg HiWriteE,
    output reg LoWriteE,
    output reg HiReadE,
    output reg LoReadE,
    output reg HilotoRegE,
   
    
    output reg PCtoRegE,
    output reg [`PCSIZE] PCPlus8E,
    
    output reg [`DATALENGTH]RD1E,
    output reg [`DATALENGTH]RD2E,
    output reg [`R_SIZE]RsE,
    output reg [`R_SIZE]RtE,
    output reg [`R_SIZE]RdE,
    
    output reg [`DATALENGTH]SignImmE,
    output reg [1:0] isDivE,
    output reg [3:0]MemCtrlE
    //output reg[`OP_SIZE] opcodeE
    );
    
    always@(posedge clock)begin
        if(reset == `RESETABLE || FlushE == 1'b1)begin
            RegWriteE <= 1'b0;
            MemtoRegE <= 1'b0;
            MemWriteE <= 1'b0;
            ALUSrcE <= 1'b0;
            RegDstE <= 1'b0;
            ALUControlE <= 3'b000;
			ShiftSrcE <= 'b0;   //hjw
            RD1E <= `ZEROWORD;
            RD2E <= `ZEROWORD;
            SignImmE <= `ZEROWORD;
            RsE <= 5'b00000;
            RtE <= 5'b00000;
            RdE <= 5'b00000;
            HiWriteE <= 1'b0;
            LoWriteE <= 1'b0;
            HiReadE <= 1'b0;
            LoReadE <= 1'b0;
            HilotoRegE <= 1'b0;
            PCtoRegE <= 1'b0;
            PCPlus8E <= `ZEROWORD;
            isDivE <= 2'b00;
            MemCtrlE <= 4'b0000;
            //opcodeE <= 6'b000000;
        end
        else begin
            RegWriteE <= RegWriteD;
            MemtoRegE <= MemtoRegD;
            MemWriteE <= MemWriteD;
            ALUSrcE <= ALUSrcD;
            RegDstE <= RegDstD;
            ALUControlE <= ALUControlD;
			ShiftSrcE <= ShiftSrcD;     //hjw
            RD1E <= RD1D;
            RD2E <= RD2D;
            SignImmE <= SignImmD;
            RsE <= RsD;
            RtE <= RtD;
            RdE <= RdD; 
            HiWriteE <= HiWriteD;
            LoWriteE <= LoWriteD;
            HiReadE <= HiReadD;
            LoReadE <= LoReadD;
            HilotoRegE <= HilotoRegD;
            PCtoRegE <= PCtoRegD;
            PCPlus8E <= PCPlus8D;
            isDivE <= isDivD;
            MemCtrlE <= MemCtrlD;
           // opcodeE <= opcodeD;
     
        end
    end
endmodule
