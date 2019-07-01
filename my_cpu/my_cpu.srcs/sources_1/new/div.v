`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2019 05:17:22 AM
// Design Name: 
// Module Name: div
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


module div(
    input clock,
    input reset,
    
    input start,
    input ifSig,
    
    input [`DATALENGTH] SrcAE,
    input [`DATALENGTH] SrcBE,
    
    output [`DATALENGTH] div_hi,
    output [`DATALENGTH] div_lo,
    output div_busy
    
    );
    
    reg [5:0] cnt;
    reg active;
    reg[63:0] divided;
    reg[63:0] divisor;
    reg[`DATALENGTH] quot;
    
    always@(posedge  clock)begin
        if(reset == `RESETABLE)begin
            cnt <= 6'b000000;
            divided <= 16'h0000000000000000;
            divisor <= 16'h0000000000000000;
            quot <= `ZEROWORD;
        end
        else begin
            if(start)begin
                active <= 1'b1;
                cnt <= 32;
                divided <= {32'h0,SrcAE};
                divisor <= {SrcBE,32'h0};
            end else if(active == 1'b1)begin
                cnt <= cnt - 1;
                
                if(cnt > 0)begin
                    
                end else if (cnt == 0)begin
                    
                end
                

            end
        end
    end
endmodule
