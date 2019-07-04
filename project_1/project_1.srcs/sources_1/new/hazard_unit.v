`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 04:14:14 AM
// Design Name: 
// Module Name: hazard_unit
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

module hazard_unit(
    input clock,
    input reset,
    
    // control signal
        // from writeback part
        input RegWriteW,
        // from access memory part
        input RegWriteM,
        input MemtoRegM,
        // from exe part
        input RegWriteE,
        input MemtoRegE,
        // from decode part
        input BranchD,
        input HilotoRegE,           // 5.6 
   
   // input 
        //from writeback part
        input [`R_SIZE] WriteRegW,
        //from access memory pary
        input [`R_SIZE] WriteRegM,
        //from exe part
        input [`R_SIZE] WriteRegE,
        input [`R_SIZE] RsE,
        input [`R_SIZE] RtE,
        // from decode part
        input [`R_SIZE] RsD,
        input [`R_SIZE] RtD,  
    
   // output 
   output [1:0] ForwardAE,
   output [1:0] ForwardBE,
   
   output [1:0] ForwardAD,
   output [1:0] ForwardBD,
   
   output  FlushE,
   
   output  StallD,
   output  StallF
    );
    
    //reg control;
    
    // zhe li tian jia le xiu gai, xie ru de mu biao ji cun qi bu neng shi $0
    // zhe shi wei le bi mian qing kong shi hou chu cuo
    wire lwstall;
    assign lwstall = ((RsD == RtE) || (RtD == RtE)) && MemtoRegE && (RtE != 0);
    wire branchstall;
    assign branchstall = ((BranchD) && (RegWriteE) && ((WriteRegE == RsD) || (WriteRegE == RtD)) && WriteRegE != 0)
                      || ((BranchD) && (MemtoRegM) && ((WriteRegM == RsD) || (WriteRegM == RtD)) && WriteRegM != 0);

    assign StallF = (reset == `RESETABLE) ? 1'b0:(lwstall || branchstall);
    assign StallD = (reset == `RESETABLE) ? 1'b0:(lwstall || branchstall);
    assign FlushE = (reset == `RESETABLE) ? 1'b0:(lwstall || branchstall);
    
    assign ForwardAD = (reset == `RESETABLE) ? 1'b0:
                        ((RsD != 5'b00000) && (RsD == WriteRegM) && (RegWriteM == 1'b1)) ? 1'b1:
                        1'b0;
    assign ForwardBD = (reset == `RESETABLE) ? 1'b0:
                    ((RtD != 5'b00000) && (RtD == WriteRegM) && (RegWriteM == 1'b1)) ? 1'b1:
                    1'b0;
    
    
    assign ForwardAE = (reset == `RESETABLE) ? 2'b00:
                    ((RsE != 5'b00000) &&( RsE == WriteRegM) && (RegWriteM == 1'b1)) ? 2'b10:
                    ((RsE != 5'b00000) &&( RsE == WriteRegW) && (RegWriteW == 1'b1)) ? 2'b01:
                    2'b00;
    assign ForwardBE = (reset == `RESETABLE) ? 2'b00:
                    ((RtE != 5'b00000) &&( RtE == WriteRegM) && (RegWriteM == 1'b1)) ? 2'b10:
                    ((RtE != 5'b00000) &&( RtE == WriteRegW) && (RegWriteW == 1'b1)) ? 2'b01:
                    2'b00;
                    
    /*
    always@(*)begin
        if(reset == `RESETABLE)begin
            ForwardAE <= 2'b00;
            ForwardBE <= 2'b00;
            StallF <= 1'b0;
            StallD <= 1'b0;
            FlushE <= 1'b0;
        end
        else begin
            //ForwardAE
            if((RsE != 5'b00000) &&( RsE == WriteRegM) && (RegWriteM == 1'b1))begin
                ForwardAE <= 2'b10;
            end
            else if((RsE != 5'b00000) &&( RsE == WriteRegW) && (RegWriteW == 1'b1))begin
                ForwardAE <= 2'b01;
            end else begin
                ForwardAE <= 2'b00;
            end
            //ForwardBE
            if((RtE != 5'b00000) &&( RtE == WriteRegM) && (RegWriteM == 1'b1))begin
                ForwardBE <= 2'b10;
            end
            else if((RtE != 5'b00000) &&( RtE == WriteRegW) && (RegWriteW == 1'b1))begin
                ForwardBE <= 2'b01;
            end else begin
                ForwardBE <= 2'b00;
            end
            // 5.6
            StallF <= (lwstall || branchstall);
            StallD <= (lwstall || branchstall);
            FlushE <= (lwstall || branchstall);
            
            // ForwardAD
            if((RsD != 5'b00000) && (RsD == WriteRegM) && (RegWriteM == 1'b1))begin
                ForwardAD <= 1'b1;
            end
            else begin
                ForwardAD <= 1'b0;
            end
            // ForwardBD
            if((RtD != 5'b00000) && (RtD == WriteRegM) && (RegWriteM == 1'b1))begin
                ForwardBD <= 1'b1;
            end
            else begin
                ForwardBD <= 1'b0;
            end
        end
    end
    */
endmodule
