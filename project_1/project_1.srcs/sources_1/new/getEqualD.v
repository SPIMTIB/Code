`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2019 11:01:43 PM
// Design Name: 
// Module Name: getEqualD
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
module getEqualD(
    input clock,
    input reset,
    
    // control signal
    input [`CONTROL_EQUALD_SIZE] EqualDControl,
    
    input ForwardAD,
    input ForwardBD,
    
    // input
    input [`DATALENGTH] RD1,
    input [`DATALENGTH] RD2,
    input [`ADDRLENGTH]ALUOutM,
    
    // output
    output [`DATALENGTH] realRD1,
    output reg[`DATALENGTH] RD1_out,
    output reg[`DATALENGTH] RD2_out,
    output reg EqualD
    );
    wire [`ADDRLENGTH] choose_1;
    wire [`ADDRLENGTH] choose_2;
    assign choose_1 = (ForwardAD == 1'b1)? ALUOutM : RD1;
    assign choose_2 = (ForwardBD == 1'b1)? ALUOutM : RD2;
    assign realRD1 = choose_1;
    
    wire result;
    assign result = (EqualDControl == `EQC_NONE)? 0 
                    :(EqualDControl == `EQC_EQUAL && choose_1 == choose_2)? 1 
                    :(EqualDControl == `EQC_NOT_EQUAL && choose_1 != choose_2)? 1
                    :(EqualDControl == `EQC_HIGH_EQUAL && choose_1[31] == 1'b0)? 1 
                    :(EqualDControl == `EQC_HIGH && ((choose_1[31] == 1'b0 && RD1 != `ZEROWORD)))? 1
                    :(EqualDControl == `EQC_LOW_EQUAL && (choose_1[31] == 1'b1 || RD1 == `ZEROWORD))? 1 
                    :(EqualDControl == `EQC_LOW && choose_1[31] == 1'b1)? 1
                    :(EqualDControl == `EQC_J)? 1
                    :0;
    always@(*)begin
        if(reset == `RESETABLE)begin
            RD1_out <= `ZEROWORD;
            RD2_out <= `ZEROWORD;
            EqualD <= 1'b0;
        end else begin
            RD1_out <= RD1;
            RD2_out <= RD2;
            EqualD <= result;
        end
    end
endmodule
