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
   output reg[1:0] ForwardAE,
   output reg[1:0] ForwardBE,
   
   output reg[1:0] ForwardAD,
   output reg[1:0] ForwardBD,
   
   output reg FlushE,
   
   output reg StallD,
   output reg StallF
    );
    
    //reg control;
    wire lwstall;
    assign lwstall = ((RsD == RsE) || (RtD == RtE)) && MemtoRegE;
    wire branchstall;
    assign branchstall = ((BranchD) && (RegWriteE) && ((WriteRegE == RsD) || (WriteRegE == RtD)))
                      || ((BranchD) && (MemtoRegM) && ((WriteRegM == RsD) || (WriteRegM == RtD)));
   // wire hilostall;
   // assign hilostall = (HilotoRegE) && (RegWriteE) && (WriteRegE == RsD);       // 5.6
    
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
    
endmodule
