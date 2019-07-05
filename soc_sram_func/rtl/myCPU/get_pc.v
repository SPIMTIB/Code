`timescale 1ns / 1ps
// update PC 
`include "defines.vh"
module get_pc(
    input clock,
    input reset,
    
    // control signals
    input StallF,
    input PCSrcD,
    
    // input 
    input [`PCSIZE] PCPlus4F,
    input [`PCSIZE] PCBranchD,
    
    // output
    output reg[`PCSIZE] PCF
    );
    
    wire [`PCSIZE] PC_;
    
    assign PC_ = (reset == `RESETABLE)?32'hbfc00000
                :(PCSrcD == 1'b1)? PCBranchD
                :PCPlus4F;
 
    
    always @ (posedge clock) begin
        if (reset == `RESETABLE) begin 
            PCF <= 32'hbfc00000;
        end
        else if(StallF == 1'b1) begin
            PCF <= PCF;
        end else begin
            PCF <= PC_;
        end
    end
    
    
   

          
    


endmodule
