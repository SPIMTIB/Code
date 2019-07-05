`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2019 03:28:18 AM
// Design Name: 
// Module Name: hilo
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

module hilo(
    input clock,
    input reset,
    
    // control signal
    input writeHi,
    input writeLo,
    
    // input 
    input readHi,
    input readLo,
    input [`DATALENGTH] hi_data_in,
    input [`DATALENGTH] lo_data_in,
    
    output [`DATALENGTH] hilo_data_out
    );
    
    reg [`DATALENGTH] hi;
    reg [`DATALENGTH] lo;
    
    assign hilo_data_out = (reset == `RESETABLE) ? `ZEROWORD:
                            (readHi == 1'b1) ? hi:
                            lo;
    
    always @ (posedge clock)begin
        if(reset == `RESETUNABLE) begin
            if(writeHi == 1'b1)begin
                hi <= hi_data_in;
            end
            if(writeLo == 1'b1)begin
                lo <= lo_data_in;
            end
        end
    end
    /*
    always @ (*)begin
        if(reset == `RESETABLE)begin
            hilo_data_out <= `ZEROWORD;
        end else begin
            if(readHi == 1'b1)begin
                hilo_data_out <= hi;
            end else if (readLo == 1'b1)begin
                hilo_data_out <= lo;
            end
        end
        
    end
    */
   // assign hilo_data_out = {(writeHi == 1'b1) ? hi_data_in:hi,(writeLo == 1'b1) ? lo_data_in:lo};
    
endmodule
