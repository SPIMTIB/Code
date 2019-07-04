`timescale 1ns / 1ps
// update PC 
`include "defines.vh"
module exec(
    input wire clock,
    input wire reset,
    input wire regwrite_D,
    input wire[`ALUCONTROL_SIZE] alu_controlE,
    input wire[`DATALENGTH] read_data1E,
  //  input wire[`DATALENGTH] read_data2E,
    input wire[`DATALENGTH] im_dataE,
    
    input wire[`R_SIZE] rsE,
    input wire[`R_SIZE] rtE,
    input wire[`R_SIZE] rdE,
    
    input wire regDstE,     //
    
    output reg[`R_SIZE] writeRegE,  //
    
    output reg[`DATALENGTH] alu_resultD,
    output reg regwirte_E
    );
    
    always @ (posedge clock) begin
        regwirte_E <= regwrite_D;
    end
    
    
    always @ (posedge clock) begin
        if(reset == `RESETABLE)begin
        
        end
        else begin
        case (alu_controlE)
            `ALU_ADD:begin
                // add read_data1E and im_dataE
                alu_resultD <= read_data1E + im_dataE;
            end
            `ALU_OR:begin
                alu_resultD <= read_data1E | im_dataE;
                writeRegE <= rtE;
            end
            default: begin
            //    regwriteD <= `WRITEABLE;
            //    alu_controlD <= `ALU_ADD;
            end
        endcase
        end
    end
    

    
endmodule