`timescale 1ns / 1ps
// update PC 

module decode(
    input wire clock,
    input wire reset,
    
    // input 
    input wire[`INSTRSIZE] InstrD,
    
    // output
    output [`INSTR_INDEX]instrIndex,
    
    output [`R_SIZE] rs,
    output [`R_SIZE] rt,
    output [`R_SIZE] rd,
    
    output [`IMI_SIZE] im,
    
    output [`OP_SIZE] opcode,
    output [`OP_SIZE] funccode
    );
    
    
    assign instrIndex = (reset == `RESETUNABLE)?InstrD[25:0]:26'b0;
    assign rs = (reset == `RESETUNABLE)?InstrD[25:21]:5'b0;
    assign rt = (reset == `RESETUNABLE)?InstrD[20:16]:5'b0;
    assign rd = (reset == `RESETUNABLE)?InstrD[15:11]:5'b0;
    assign im = (reset == `RESETUNABLE)?InstrD[15:0]:15'b0;
    assign opcode = (reset == `RESETUNABLE)?InstrD[31:26]:6'b0;
    assign funccode = (reset == `RESETUNABLE)?InstrD[5:0]:6'b0;
    /*
    always @ (*) begin
        if(reset == `RESETUNABLE) begin
            opcode <= InstrD[31:26];
            rs <= InstrD[25:21];
            rt <= InstrD[20:16];
            rd <= InstrD[15:11];
            im <= InstrD[15:0];
            funccode <= InstrD[5:0];
            instrIndex <= InstrD[25:0];
        end else begin 
            opcode <= 6'b0;
            rs <= 5'b0;
            rt <= 5'b0;
            rd <= 5'b0;
            im <= 15'b0;
            funccode <= 6'b0;
            instrIndex <= 26'b0;
        end
    end
    */
    
endmodule
