`timescale 1ns / 1ps
// update PC 
`include "defines.vh"
module sig_extend(
    input wire clock,
    input wire reset,
    
    // control signal
    input [`EXTENDSIGNAL_SIZE] SigExtendSignalD,
    // input 
    input [`IMI_SIZE] im,
    
    // output
    output [`DATALENGTH] SignImmD
    );
  // wire [`DATALENGTH]tmpSig;
   //assign tmpSig = (im[15] == 1'b1) ? {4'hffff,im} :{4'h0000,im};
   
   assign SignImmD = (reset == `RESETABLE) ? `ZEROWORD :
                     (SigExtendSignalD == 2'b01) ? {{16{im[15]}},im} :
                     (SigExtendSignalD == 2'b00) ? {4'h0000,im} : 
                     (SigExtendSignalD == 2'b10) ? {im,4'h0000} :
                     `ZEROWORD;
                      
                     
   /*
   always @ (*) begin
        if(reset == `RESETABLE)begin
            
        end else if(SigExtendSignalD == 2'b01) begin
            if(im[15] == 1'b1) begin
                SignImmD[31:16] <= 4'hffff;
                SignImmD[15:0] <= im;
            end else begin
                SignImmD[31:16] <= 4'h0000;
                SignImmD[15:0] <= im;
            end
           end else if(SigExtendSignalD == 2'b00) begin
                SignImmD[31:16] <= 4'h0000;
                SignImmD[15:0] <= im;
           end else if(SigExtendSignalD == 2'b10) begin
                SignImmD[31:16]<=im;
                SignImmD[15:0]<=4'h0000;
           end
   end
   */
endmodule