`timescale 1ns / 1ps
// update PC 
`include "defines.vh"
module regfile(
    input wire clock,
    input wire reset,
    // input signal
    input wire RegWriteW,
    
    // input
    input wire[`R_SIZE] A1,
    input wire[`R_SIZE] A2,
    input wire[`R_SIZE] A3,
    input wire[`DATALENGTH] WD3,
   
   // output
    output [`DATALENGTH] RD1,
    output [`DATALENGTH] RD2
    
    );
    
    // regs
    reg[`DATALENGTH] regs[0:`REGNUM-1];
    
    // write , cost clock 
     always @(posedge clock) begin
           if (reset != `RESETABLE) begin
               if((RegWriteW == 1) &&(A3 != 5'b00000)) begin
                   regs[A3] <= WD3;
               end
           end
       end
    /*
    always @(negedge clock)begin
        if(reset == `RESETABLE || A1 == 5'b00000)begin
            RD1 <= `ZEROWORD;
        end
        else begin
            RD1 <= regs[A1];
        end
    end
    
    always @(negedge clock)begin
        if(reset == `RESETABLE || A2 == 5'b00000)begin
            RD2 <= `ZEROWORD;
        end
        else begin
            RD2 <= regs[A2];
        end
    end
    */
    // read 
    assign RD1 = (reset == `RESETABLE || A1 == 5'b00000)?`ZEROWORD:(A3 == A1)?WD3:regs[A1];
    assign RD2 = (reset == `RESETABLE || A2 == 5'b00000)?`ZEROWORD:(A3 == A2)?WD3:regs[A2];
    //assign RD1 = (reset == `RESETABLE || A1 == 5'b00000)?`ZEROWORD:regs[A1];
   // assign RD2 = (reset == `RESETABLE || A2 == 5'b00000)?`ZEROWORD:regs[A2];

    
endmodule
