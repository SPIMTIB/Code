`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2019 07:20:18 AM
// Design Name: 
// Module Name: mips
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
module mips(
    input wire clock,
    input wire reset,
    input wire [5:0] int,
    
    output wire inst_sram_en,
    output wire [3:0] inst_sram_wen,
    output wire [31:0] inst_sram_addr,
    output wire [31:0] inst_sram_wdata,
    input wire [31:0] inst_sram_rdata,
    
    output wire data_sram_en,
    output wire [3:0] data_sram_wen,
    output wire [31:0] data_sram_addr,
    output wire [31:0] data_sram_wdata,
    input wire [31:0] data_sram_rdata,
    
    output wire [31:0] debug_wb_pc,
    output wire [3:0] debug_wb_rf_wen,
    output wire [4:0] debug_wb_rf_wnum,
    output wire [31:0] debug_wb_rf_wdata
    
    );
    
        //  wires
    wire [`PCSIZE] PCPlus4F;
    wire [`PCSIZE] PCBranchD;
    wire [`PCSIZE] PCF;
    wire [`INSTRSIZE] InstrI;
    wire StallF;
    
    wire StallD;
    wire PCSrcD;
    wire [`INSTRSIZE]InstrD;
    wire [`PCSIZE] PCPlus4D;
    wire [`PCSIZE] PCPlus8D;
    wire [`PCSIZE] PCD; //for debug //hjw
    
    wire[`R_SIZE] rs;
    wire[`R_SIZE] rt;
    wire[`R_SIZE] rd;
    wire[`IMI_SIZE] im;
	wire[`OP_SIZE] sa;	//hjw
    wire[`OP_SIZE] opcode;
    wire[`OP_SIZE] funccode;
    
    wire [`R_SIZE] RdD;

    wire [`EXTENDSIGNAL_SIZE] SigExtendSignalD;
    wire RegWriteD;
    wire MemtoRegD;
    wire MemWriteD;
    wire [`ALUCONTROL_SIZE] ALUControlD;
    wire ALUSrcD;
    wire RegDstD;
    wire BranchD;
	wire ShiftSrcD;	//hjw
    wire [`CONTROL_EQUALD_SIZE]EqualDControl;       //
    wire RdD_31_Control;                            //
    wire HiWriteD;
    wire LoWriteD;
    wire HiReadD;
    wire LoReadD;
    wire HilotoRegD;
    wire PCtoRegD;      // **added for PC
    
    wire [1:0] isDivD;
    wire [1:0] isDivE;
     
    
    wire EqualD;
    wire [`OP_SIZE]opcode_out_opcodeD;
    
    wire RegWriteW;                 // 
    
  //  wire[`DATALENGTH] WD3;          //
   
    wire[`DATALENGTH] RD1;          //
    wire[`DATALENGTH] RD2;          //
    
    wire ForwardAD;                  //
    wire ForwardBD;                 //
    wire [`ADDRLENGTH]ALUOutM;      //
    wire[`DATALENGTH] RD1_out;      //
    wire[`DATALENGTH] RD2_out;      //

    wire[`DATALENGTH] SignImmD;     //
    
    wire[`DATALENGTH] SignImmD_shift2; //
    
    wire FlushE;            //
    wire RegWriteE;
    wire MemtoRegE;
    wire MemWriteE;
    wire[`ALUCONTROL_SIZE] ALUControlE;
    wire ALUSrcE;
    wire RegDstE;
	wire ShiftSrcE;	//hjw
    wire HiWriteE;
    wire LoWriteE;
    wire HiReadE;
    wire LoReadE;
    wire HilotoRegE;
    wire PCtoRegE;      // **added for PC
    wire [`DATALENGTH]RD1E;
    wire [`DATALENGTH]RD2E;
    wire [`R_SIZE]RsE;
    wire [`R_SIZE]RtE;
    wire [`R_SIZE]RdE;
    wire [`DATALENGTH]SignImmE;
    wire [`PCSIZE] PCPlus8E;   // added for PC
    wire [`PCSIZE] PCE; //for debug //hjw
    wire [`R_SIZE] WriteRegE;       //
    wire [`OP_SIZE] opcodeE;
    
    wire[1:0] ForwardAE;
    wire[`DATALENGTH] ResultW;
    wire [`DATALENGTH] SrcAE;
    
    wire [`DATALENGTH] WriteDataE;
    wire [`DATALENGTH] SrcBE;
    
	wire [`R_SIZE] ShiftsE;	//hjw

    wire [1:0]ForwardBE;
    
    wire [`DATALENGTH] ALUOutE;
    wire [`DATALENGTH] ALUOutHighE;
    wire RegWriteM;
    wire MemtoRegM;
    wire MemWriteM;
    wire HiReadM;
    wire LoReadM;
    wire HilotoRegM;
    wire PCtoRegM;      // **added for PC
    wire [`PCSIZE] PCPlus8M;   // added for PC
    wire [`PCSIZE] PCM; //for debug //hjw
   // wire [`DATALENGTH]ALUOutM;
    wire [`DATALENGTH]WriteDataM;
    wire [`R_SIZE] WriteRegM;
    
    wire [`DATALENGTH] ReadDataM;
    wire HiWriteM;
    wire LoWriteM;
    wire [`DATALENGTH] write_hi_dataM;
    wire [`DATALENGTH] write_lo_dataM;
    wire [`OP_SIZE] opcodeM;
    
    wire MemtoRegW;
    wire [`DATALENGTH] ReadDataW;
    wire [`DATALENGTH] ALUOutW;
    wire [`R_SIZE] WriteRegW;
    wire [`PCSIZE] PCPlus8W;   // added for PC
    wire HiReadW;
    wire LoReadW;
    wire HilotoRegW;
    wire PCtoRegW;      // **added for PC
    wire HiWriteW;
    wire LoWriteW;
    wire [`DATALENGTH] write_hi_dataW;
    wire [`DATALENGTH] write_lo_dataW;
    
    wire [`DATALENGTH] ResultW_withHilo;
    
    wire [`DATALENGTH] write_hi_dataE;
    wire [`DATALENGTH] write_lo_dataE;
    
    wire [`DATALENGTH] mul_hi;        
    wire [`DATALENGTH] mul_lo; 
    
    wire div_start;
    wire div_end;
    wire [`DATALENGTH] div_hi;        
    wire [`DATALENGTH] div_lo; 
    wire [1:0] status;
    
    wire [`DATALENGTH] hilo_data_out;
    
    wire [`DATALENGTH] ResultW_withHilo_withPC;
    
     wire [`DATALENGTH] ME_databack;
     
     wire J_Imi_ControlD;
     wire J_Rs_ControlD;
     wire [`DATALENGTH] realRD1;
     wire [`INSTR_INDEX]instrIndex;
     wire [`PCSIZE] J_PCBranchD;
     
     wire [`PCSIZE] PCBranchD_final;
    /* below is part1 : get instructment*/
    // get_pc
    get_pc get_pc0(.clock(clock),.reset(reset),.StallF(StallF),.PCSrcD(PCSrcD),.PCPlus4F(PCPlus4F),.PCBranchD(PCBranchD_final),.PCF(PCF));
    // PC_ALU
    PC_ALU PC_ALU0(.reset(reset),.PCF(PCF),.PCPlus4F(PCPlus4F));
    // get_instr
    get_instr get_instr0(.clock(clock),.reset(reset),.instr_addr(PCF),.instr_from_ram(inst_sram_rdata),.InstrI(InstrI),.inst_sram_en(inst_sram_en),.inst_sram_wen(inst_sram_wen),.inst_sram_addr(inst_sram_addr),.inst_sram_wdata(inst_sram_wdata));
    /* get instructment part is over */
    
    // instr_decode
    instr_decode instr_decode0(.clock(clock),.reset(reset),.StallD(StallD),.PCSrcD(PCSrcD),.InstrI(InstrI),.PCPlus4F(PCPlus4F),.PCF(PCF),.InstrD(InstrD),.PCPlus4D(PCPlus4D),.PCD(PCD));
    
    /* below is part2 : decode*/
    //decode 
    decode decode0(.clock(clock),.reset(reset),.InstrD(InstrD),.instrIndex(instrIndex),.rs(rs),.rt(rt),.rd(rd),.im(im),.opcode(opcode),.funccode(funccode));
    wire [3:0] MemCtrlD;
    wire [3:0] MemCtrlE;
    wire [3:0] MemCtrlM;
    // control_unit
    control_unit control_unit0(
    .clock(clock),
    .reset(reset),
    .opcode_in(opcode),
    .funccode_in(funccode),
    .rt(rt),
    .SigExtendSignalD(SigExtendSignalD),
    .RegWriteD(RegWriteD),
    .MemtoRegD(MemtoRegD),
    .MemWriteD(MemWriteD),
    .ALUControlD(ALUControlD),
    .ALUSrcD(ALUSrcD),
    .RegDstD(RegDstD),
    .BranchD(BranchD),
    .ShiftSrcD(ShiftSrcD),
    .EqualDControl(EqualDControl),
    .PCtoRegD(PCtoRegD),
    .RdD_31_Control(RdD_31_Control),
    .J_Imi_ControlD(J_Imi_ControlD),
    .J_Rs_ControlD(J_Rs_ControlD),
    .HiWriteD(HiWriteD),
    .LoWriteD(LoWriteD),
    .HiReadD(HiReadD),
    .LoReadD(LoReadD),
    .HilotoRegD(HilotoRegD),
    .isDivD(isDivD),
    .MemCtrlD(MemCtrlD)
    //.opcode_out(opcode_out_opcodeD)
    );
    // getRdD
    getRdD getRdD0(.clock(clock),.reset(reset),.RdD_31_Control(RdD_31_Control),.rd(rd),.RdD(RdD));
    // regfile
    regfile regfile0(.clock(clock),.reset(reset),.RegWriteW(RegWriteW),.A1(rs),.A2(rt),.A3(WriteRegW),.WD3(ResultW_withHilo_withPC),.RD1(RD1),.RD2(RD2));
    // get_EqualD
    getEqualD getEqualD0(.clock(clock),.reset(reset),.EqualDControl(EqualDControl),.ForwardAD(ForwardAD),.ForwardBD(ForwardBD),.RD1(RD1),.RD2(RD2),.ALUOutM(ME_databack),
    .realRD1(realRD1),.RD1_out(RD1_out),.RD2_out(RD2_out),.EqualD(EqualD));
    // get_PCSrcD
    get_PCSrcD get_PCSrcD0(.reset(reset),.EqualD(EqualD),.BranchD(BranchD),.PCSrcD(PCSrcD));
    // sig_extend
    sig_extend sig_extend0(.clock(clock),.reset(reset),.SigExtendSignalD(SigExtendSignalD),.im(im),.SignImmD(SignImmD));
    // shift_unit
    shift_unit shift_unit0(.clock(clock),.reset(reset),.SignImmD(SignImmD),.SignImmD_shift2(SignImmD_shift2));
    // get_PCBranchD
    get_PCBranchD get_PCBranchD0(.clock(clock),.reset(reset),.SignImmD_shift2(SignImmD_shift2),.PCPlus4D(PCPlus4D),.PCBranchD(PCBranchD));
    // get_J_PCBranchD
    get_J_PCBranchD get_J_PCBranchD0(.reset(reset),.J_Imi_ControlD(J_Imi_ControlD),.J_Rs_ControlD(J_Rs_ControlD),.PCPlus4D(PCPlus4D),.instrIndex(instrIndex),.RD1(realRD1),.J_PCBranchD(J_PCBranchD));
    //get_PCBranchD_final
    get_PCBranchD_final get_PCBranchD_final0(.reset(reset),.J_Imi_ControlD(J_Imi_ControlD),.J_Rs_ControlD(J_Rs_ControlD),.J_PCBranchD(J_PCBranchD),.PCBranchD(PCBranchD),.PCBranchD_final(PCBranchD_final));
    // get_PCPlus8D
    get_PCPLus8 get_PCPLus80(.PCPlus4D(PCPlus4D),.PCPlus8D(PCPlus8D));
    /* decode part is over*/
    
    // decode_exe
    decode_exe decode_exe0(
    .clock(clock),
    .reset(reset),
    .RegWriteD(RegWriteD),
    .MemtoRegD(MemtoRegD),
    .MemWriteD(MemWriteD),
    .ALUControlD(ALUControlD),
    .ALUSrcD(ALUSrcD),
    .RegDstD(RegDstD),
    .HiWriteD(HiWriteD),
    .LoWriteD(LoWriteD),
    .HiReadD(HiReadD),
    .LoReadD(LoReadD),
    .HilotoRegD(HilotoRegD),
    .ShiftSrcD(ShiftSrcD),
    .PCtoRegD(PCtoRegD),
    .FlushE(FlushE),
    .RD1D(RD1_out),
    .RD2D(RD2_out),
    .RsD(rs),
    .RtD(rt),
    .RdD(RdD),
    .SignImmD(SignImmD),
    .PCPlus8D(PCPlus8D),
    .PCD(PCD),
    .isDivD(isDivD),
    .MemCtrlD(MemCtrlD),
    //.opcodeD(opcode_out_opcodeD),
    .RegWriteE(RegWriteE),
    .MemtoRegE(MemtoRegE),
    .MemWriteE(MemWriteE),
    .ALUControlE(ALUControlE),
    .ALUSrcE(ALUSrcE),
    .RegDstE(RegDstE),
    .ShiftSrcE(ShiftSrcE),
    .HiWriteE(HiWriteE),
    .LoWriteE(LoWriteE),
    .HiReadE(HiReadE),
    .LoReadE(LoReadE),
    .HilotoRegE(HilotoRegE),
    .PCtoRegE(PCtoRegE),
    .PCPlus8E(PCPlus8E),
    .PCE(PCE),
    .RD1E(RD1E),
    .RD2E(RD2E),
    .RsE(RsE),
    .RtE(RtE),
    .RdE(RdE),
    .SignImmE(SignImmE),
    .isDivE(isDivE),
    .MemCtrlE(MemCtrlE)
    //.opcodeE(opcodeE)
    );
    
    /* below is part3 : exe*/
    // get_WriteRegE
    get_WriteRegE get_WriteRegE0(.clock(clock),.reset(reset),.RegDstE(RegDstE),.RtE(RtE),.RdE(RdE),.WriteRegE(WriteRegE));
    // get_SrcAE
    get_SrcAE get_SrcAE0(.clock(clock),.reset(reset),.ForwardAE(ForwardAE),.RD1E(RD1E),.ResultW(ResultW_withHilo_withPC),.ALUOutM(ME_databack),.SrcAE(SrcAE));
    // get_SrcBE
    get_SrcBE get_SrcBE0(.clock(clock),.reset(reset),.ALUSrcE(ALUSrcE),.WriteDataE(WriteDataE),.SignImmE(SignImmE),.SrcBE(SrcBE));
    //get_ShiftSrc  //hjw
    get_ShiftSrc get_ShiftSrc0(.clock(clock),.reset(reset),.ShiftSrcE(ShiftSrcE),.SrcAE(SrcAE),.SignImmE(SignImmE),.ShiftsE(ShiftsE));    //hjw
	// get_WriteDataE
    get_WriteDataE get_WriteDataE0(.clock(clock),.reset(reset),.ForwardBE(ForwardBE),.RD2E(RD2E),.ResultW(ResultW_withHilo_withPC),.ALUOutM(ME_databack),.WriteDataE(WriteDataE));
    // mul_div_choose


   // mul_div_choose mul_div_choose0(.clock(clock),.reset(reset),.ALUControlE(ALUControlE),
  //  .SrcAE(SrcAE),.div_start(div_start),.div_end(div_end),.div_hi_data(div_hi),.div_lo_data(div_lo),.mul_hi_data(mul_hi),.mul_lo_data(mul_lo),.status(status),.write_hi_dataE(write_hi_dataE),.write_lo_dataE(write_lo_dataE));
    // mul

   // mul mul0(.clock(clock),.reset(reset),.ALUControlE(ALUControlE),.SrcAE(SrcAE),.SrcBE(SrcBE),.mul_hi(mul_hi),.mul_lo(mul_lo));
   
    
    // SrcAE_SrcBE_ALU
    SrcAE_SrcBE_ALU SrcAE_SrcBE_ALU0(.clock(clock),.reset(reset),.ALUControlE(ALUControlE),.ShiftsE(ShiftsE),.SrcAE(SrcAE),.SrcBE(SrcBE),.ALUOutE(ALUOutE),.ALUOutHighE(ALUOutHighE));	//hjw
    
            // input
   
   wire [`DATALENGTH] HighE;
   wire [`DATALENGTH] LowE;
   
   wire [`DATALENGTH] HighM;
   wire [`DATALENGTH] LowM;
   wire divBusy;
    //div
    div div0(.clock(clock),.reset(reset),.isDiv(isDivE),.SrcAE(SrcAE),.SrcBE(SrcBE),.div_hi(div_hi),.div_lo(div_lo),.busy(divBusy));
    
    // ALUOut
    ALUOut_Div_Choose ALUOut_Div_Choose0(.isDiv(isDivE[1]^isDivE[0]),.ALUOutHigh(ALUOutHighE),.ALUOutLow(ALUOutE),.DivHigh(div_hi),.DivLow(div_lo),.High(HighE),.Low(LowE));
    /* exe part is over*/

    // exe_accessMem
    exe_accessMem exe_accessMem0(
    .clock(clock),
    .reset(reset),
    .RegWriteE(RegWriteE),
    .MemtoRegE(MemtoRegE),
    .MemWriteE(MemWriteE),
    .HiWriteE(HiWriteE),
    .LoWriteE(LoWriteE),
    .HiReadE(HiReadE),
    .LoReadE(LoReadE),
    .HilotoRegE(HilotoRegE),
    .PCtoRegE(PCtoRegE),
 //   .ALUOutE(ALUOutE),
    .WriteDataE(WriteDataE),
    .WriteRegE(WriteRegE),
 //   .write_hi_dataE(write_hi_dataE),
  //  .write_lo_dataE(write_lo_dataE),
    .HighE(HighE),
    .LowE(LowE),
    .PCPlus8E(PCPlus8E),
    .PCE(PCE),
    .MemCtrlE(MemCtrlE),
    //.opcodeE(opcodeE),
    .RegWriteM(RegWriteM),
    .MemtoRegM(MemtoRegM),
    .MemWriteM(MemWriteM),
  //  .ALUOutM(ALUOutM),
    .WriteDataM(WriteDataM),
    .WriteRegM(WriteRegM),
    .HiWriteM(HiWriteM),
    .LoWriteM(LoWriteM),
    .HiReadM(HiReadM),
    .LoReadM(LoReadM),
    .HilotoRegM(HilotoRegM),
    .PCtoRegM(PCtoRegM),
    .PCPlus8M(PCPlus8M),
    .PCM(PCM),
  //  .write_hi_dataM(write_hi_dataM),
  //  .write_lo_dataM(write_lo_dataM),
    .HighM(HighM),
    .LowM(LowM),
    .MemCtrlM(MemCtrlM)
    //.opcodeM(opcodeM)
    );
    
    /* below is part4 : access memory*/
   
    // access_mem
    access_mem access_mem0(
    .clock(clock),
    .reset(reset),
    //.opcodeM(opcodeM),
    .MemWriteM(MemWriteM),
    .MemCtrlM(MemCtrlM),
    .addr(LowM),        // 7-1 **
    .writeData(WriteDataM),
    .data_from_sram(data_sram_rdata),
    .data_sram_en(data_sram_en),
    .data_sram_wen(data_sram_wen),
    .data_sram_addr(data_sram_addr),
    .data_sram_wdata(data_sram_wdata),
    //.mem_data_i(ram_data_i),
    //.mem_addr_o(ram_addr_o),
    //.mem_we_o(ram_we_o),
    //.mem_sel_o(ram_sel_o),
    //.mem_data_o(ram_data_o),
    //.mem_ce_o(ram_ce_o),
    .readData(ReadDataM)
    
    
    );
     // hilo   *******************
    hilo hilo0(.clock(clock),.reset(reset),.writeHi(HiWriteM),.writeLo(LoWriteM),.readHi(HiReadM),.readLo(LoReadM),.hi_data_in(HighM),.lo_data_in(LowM),.hilo_data_out(hilo_data_out));
     // M_E_databack

    M_E_databack M_E_databack0(.reset(reset),.HilotoRegM(HilotoRegM),.PCtoRegM(PCtoRegM),.ALUOutM(LowM),.hilo_data_out(hilo_data_out),.PCPlus8M(PCPlus8M),.ME_databack(ME_databack));

    /* access memory part is over*/
    
    // accessMem_writeback
    wire [`DATALENGTH] HiloDataW;
    accessMem_writeback accessMem_writeback0(.clock(clock),.reset(reset),.RegWriteM(RegWriteM),.MemtoRegM(MemtoRegM),.HilotoRegM(HilotoRegM),
    .PCtoRegM(PCtoRegM),.ReadDataM(ReadDataM),.ALUOutM(LowM),.WriteRegM(WriteRegM),.HiloDataM(hilo_data_out),
    .PCPlus8M(PCPlus8M),.PCM(PCM),.RegWriteW(RegWriteW),.MemtoRegW(MemtoRegW),.HilotoRegW(HilotoRegW),
    .PCtoRegW(PCtoRegW),.PCPlus8W(PCPlus8W),.ReadDataW(ReadDataW),.ALUOutW(ALUOutW),.WriteRegW(WriteRegW),
    .HiloDataW(HiloDataW),.PCW(debug_wb_pc),.debug_wb_rf_wen(debug_wb_rf_wen),.debug_wb_rf_wnum(debug_wb_rf_wnum));
    /* below is part5 : writeback*/

   
    // get_ResultW
    get_ResultW get_ResultW0(.clock(clock),.reset(reset),.MemtoRegW(MemtoRegW),.ReadDataW(ReadDataW),.ALUOutW(ALUOutW),.ResultW(ResultW));
    // get_ResultW_withHilo
    get_ResultW_withHilo get_ResultW_withHilo0(.clock(clock),.reset(reset),.HilotoRegW(HilotoRegW),.ResultW(ResultW),.Hilodata(HiloDataW),.ResultW_withHilo(ResultW_withHilo));
    // get_ResultW_withHilo_withPC
    get_ResultW_withHilo_withPC get_ResultW_withHilo_withPC0(.clock(clock),.reset(reset),.PCtoRegW(PCtoRegW),.ResultW_withHilo(ResultW_withHilo),.PCPlus8W(PCPlus8W),.ResultW_withHilo_withPC(ResultW_withHilo_withPC),.debug_wb_rf_wdata(debug_wb_rf_wdata));
    
    /* writeback part is over*/
    
    
    /* below is conflict part*/
    
    // hazard unit
    hazard_unit hazard_unit0(.clock(clock),.reset(reset),.RegWriteW(RegWriteW),.RegWriteM(RegWriteM),.MemtoRegM(MemtoRegM),.RegWriteE(RegWriteE),.MemtoRegE(MemtoRegE),.BranchD(BranchD),.HilotoRegE(HilotoRegE),.WriteRegW(WriteRegW),.WriteRegM(WriteRegM),.WriteRegE(WriteRegE),.RsE(RsE),.RtE(RtE),.RsD(rs),.RtD(rt),
                                .ForwardAE(ForwardAE),.ForwardBE(ForwardBE),.ForwardAD(ForwardAD),.ForwardBD(ForwardBD),.FlushE(FlushE),.StallD(StallD),.StallF(StallF));
    /* confict part is over*/
endmodule
