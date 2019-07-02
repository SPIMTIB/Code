`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2019 08:32:25 PM
// Design Name: 
// Module Name: M_E_databack
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
module M_E_databack(
    input reset,
    
    // control signal
    input HilotoRegM,
    input PCtoRegM,
    
    // input 
    input [`DATALENGTH] ALUOutM,
    input [`DATALENGTH] hilo_data_out,
    input [`DATALENGTH] PCPlus8M,
    
    // output 
    output [`DATALENGTH] ME_databack
    
    );
    
    assign ME_databack =(reset == `RESETABLE)? `ZEROWORD : 
                        (HilotoRegM == 1'b1)? hilo_data_out :
                        (PCtoRegM == 1'b1) ? PCPlus8M : ALUOutM;
                     
endmodule
