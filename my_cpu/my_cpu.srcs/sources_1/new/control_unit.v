`timescale 1ns / 1ps
// update PC 
`include "defines.vh"
module control_unit(
    input wire clock,
    input wire reset,
    
    // input
    input wire[`OP_SIZE] opcode_in,
    input wire[`OP_SIZE] funccode_in,
    input wire[`R_SIZE] rt,         // added ** for fenzhi
    
    // output . these are all control signal
    output reg [`EXTENDSIGNAL_SIZE] SigExtendSignalD,
    output reg RegWriteD,
    output reg MemtoRegD,
    output reg MemWriteD,
    output reg[`ALUCONTROL_SIZE] ALUControlD,
    output reg ALUSrcD,
    output reg RegDstD,
    output reg BranchD,
	output reg ShiftSrcD,

    
    output reg[`CONTROL_EQUALD_SIZE] EqualDControl,     // added ** for fenzhi
    output reg PCtoRegD,                             // if PC needed to write to $31
    output reg RdD_31_Control,                           // for reg writed Rd or $31
    // for J instr:
    output reg J_Imi_ControlD,
    output reg J_Rs_ControlD,
    
    // for hilo
    output reg HiWriteD,
    output reg LoWriteD,
    output reg HiReadD,
    output reg LoReadD,
    output reg HilotoRegD,
    
    
    output wire[`OP_SIZE] opcode_out
    );
    
    // cal ALUControlD
    assign opcode_out = opcode_in;
     
    
    always @ (*) begin
        if(reset == 1'b0) begin
            case (opcode_in)
                `OP_ALL_ZERO:begin
                   case (funccode_in)
                        `FUNC_ADD:begin
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_ADD_OVERFLOW;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0; 
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `FUNC_ADDU:begin
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_ADD;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0; 
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `FUNC_SUB:begin
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_SUB_OVERFLOW;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0;
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `FUNC_SUBU:begin
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_SUB;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0;
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `FUNC_SLT:begin
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_SLT;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0;
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `FUNC_SLTU:begin
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_SLTU;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0;
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `FUNC_MUL:begin
                            RegWriteD <= 1'b0;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_MUL;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b0;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b1;
                            LoWriteD <= 1'b1;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0;
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `FUNC_MULU:begin
                            RegWriteD <= 1'b0;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_MULU;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b0;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b1;
                            LoWriteD <= 1'b1;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0;
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `FUNC_DIV:begin
                            // tbd
                        end
                        `FUNC_DIVU:begin
                        // tbd
                            RegWriteD <= 1'b0;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_DIVU;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b0;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b1;
                            LoWriteD <= 1'b1;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0;
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `FUNC_MTHI:begin
                            RegWriteD <= 1'b0;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_MTHI;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b0;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b1;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0;
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `FUNC_MTLO:begin
                            RegWriteD <= 1'b0;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_MTLO;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b0;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b1;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0;
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `FUNC_MFHI:begin
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_NONE;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b1;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b1;
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `FUNC_MFLO:begin
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_NONE;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b1;
                            HilotoRegD <=1'b1;
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `FUNC_JR:begin
                            RegWriteD <= 1'b0;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_NONE;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b0;
                            BranchD <= 1'b1;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0;
                            EqualDControl <= `EQC_J;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b1;
                        end
                        `FUNC_JALR:begin
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_NONE;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b1;
                            SigExtendSignalD <= 1'b00;  // whatever
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0;
                            EqualDControl <= `EQC_J;
                            PCtoRegD <= 1'b1;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b1;
                        end
						//********************hjw************************//
						`FUNC_AND:begin
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_AND;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 2'b00;   //whatever
                            ShiftSrcD <= 1'b0;
							HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0; 
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
						end
						  
						`FUNC_XOR:begin
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_XOR;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 2'b00;   //whatever
                            ShiftSrcD <= 1'b0;
							HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0; 
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
						end
						`FUNC_NOR:begin  //hjw
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_NOR;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 2'b00;   //whateverv
                            ShiftSrcD <= 1'b0;
							HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0; 
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
						`FUNC_OR:begin  //hjw
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_OR;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 2'b00;   //whatever
                            ShiftSrcD <= 1'b0;
							HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0; 
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
						`FUNC_SLL:begin  //hjw
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_SLL;
                            ALUSrcD <= 'b0;
                            RegDstD <= 'b1;
                            BranchD <= 'b0;
                            SigExtendSignalD <= 2'b00;    //whatever
                            ShiftSrcD <= 1'b1;
							HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0; 
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
						`FUNC_SLLV:begin  //hjw
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_SLL;
                            ALUSrcD <= 'b0;
                            RegDstD <= 'b1;
                            BranchD <= 'b0;
                            SigExtendSignalD <= 2'b00;    //whatever
                            ShiftSrcD <= 1'b0;
							HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0; 
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
						`FUNC_SRA:begin  //hjw
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_SRA;
                            ALUSrcD <= 'b0;
                            RegDstD <= 'b1;
                            BranchD <= 'b0;
                            SigExtendSignalD <= 2'b00;    //whatever
                            ShiftSrcD <= 1'b1;
							HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0; 
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
						`FUNC_SRAV:begin  //hjw
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_SRA;
                            ALUSrcD <= 'b0;
                            RegDstD <= 'b1;
                            BranchD <= 'b0;
                            SigExtendSignalD <= 2'b00;    //whatever
                            ShiftSrcD <= 1'b0;
							HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0; 
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
						`FUNC_SRL:begin  //hjw
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_SRL;
                            ALUSrcD <= 'b0;
                            RegDstD <= 'b1;
                            BranchD <= 'b0;
                            SigExtendSignalD <= 2'b00;    //whatever
                            ShiftSrcD <= 1'b1;
							HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0; 
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `FUNC_SRLV:begin  //hjw
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_SRL;
                            ALUSrcD <= 'b0;
                            RegDstD <= 'b1;
                            BranchD <= 'b0;
                            SigExtendSignalD <= 2'b00;    //whatever
                            ShiftSrcD <= 1'b0;
							HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0; 
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
						//********************hjw*************************//
                        default:begin
                            RegWriteD <= 1'b0;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_NONE;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b0;
                            BranchD <= 1'b0;
                            SigExtendSignalD <= 1'b00;       // 1 extend
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            HiReadD <= 1'b0;
                            LoReadD <= 1'b0;
                            HilotoRegD <=1'b0;
                            EqualDControl <= 3'b000;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                   endcase
                end
                `OP_REGIMM:begin
                    case(rt)
                        `RT_BLTZ:begin
                            RegWriteD <= 1'b0;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_NONE;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b1;
                            SigExtendSignalD <= 1'b01;       
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            EqualDControl <= `EQC_LOW;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            HilotoRegD <=1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `RT_BGEZ:begin
                            RegWriteD <= 1'b0;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_NONE;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b1;
                            SigExtendSignalD <= 1'b01;       
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            EqualDControl <= `EQC_HIGH_EQUAL;
                            PCtoRegD <= 1'b0;
                            RdD_31_Control <= 1'b0;
                            HilotoRegD <=1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `RT_BGEZAL:begin
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_NONE;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b1;
                            SigExtendSignalD <= 1'b01;       
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            EqualDControl <= `EQC_HIGH_EQUAL;
                            PCtoRegD <= 1'b1;
                            RdD_31_Control <= 1'b1;
                            HilotoRegD <=1'b0;
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                        `RT_BLTZAL:begin
                            RegWriteD <= 1'b1;
                            MemtoRegD <= 1'b0;
                            MemWriteD <= 1'b0;
                            ALUControlD <= `ALU_NONE;
                            ALUSrcD <= 1'b0;
                            RegDstD <= 1'b1;
                            BranchD <= 1'b1;
                            SigExtendSignalD <= 1'b01;      
							ShiftSrcD <= 'b0;
                            HiWriteD <= 1'b0;
                            LoWriteD <= 1'b0;
                            EqualDControl <= `EQC_LOW;
                            PCtoRegD <= 1'b1;
                            RdD_31_Control <= 1'b1;
                            HilotoRegD <=1'b0;  
                            J_Imi_ControlD <= 1'b0;
                            J_Rs_ControlD <= 1'b0;
                        end
                    endcase
                end
                `OP_ADDI:begin
                    RegWriteD <= 1'b1;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_ADD_OVERFLOW;
                    ALUSrcD <= 1'b1;
                    RegDstD <= 1'b0;
                    BranchD <= 1'b0;
                    SigExtendSignalD <= 1'b01;       // 1 extend
					ShiftSrcD <= 'b0;
                    HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= 3'b000;
                    PCtoRegD <= 1'b0;
                    RdD_31_Control <= 1'b0;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b0;
                    J_Rs_ControlD <= 1'b0;
                end
                `OP_ADDIU:begin
                    RegWriteD <= 1'b1;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_ADD;
                    ALUSrcD <= 1'b1;
                    RegDstD <= 1'b0;
                    BranchD <= 1'b0;
                    SigExtendSignalD <= 1'b01;       // 1 extend
					ShiftSrcD <= 'b0;
                    HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= 3'b000;
                    PCtoRegD <= 1'b0;
                    RdD_31_Control <= 1'b0;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b0;
                    J_Rs_ControlD <= 1'b0;
            end
                `OP_ORI:begin
                    RegWriteD <= 1'b1;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_OR;
                    ALUSrcD <= 1'b1;
                    RegDstD <= 1'b0;
                    BranchD <= 1'b0;
                    SigExtendSignalD <= 1'b00;       // 0 extend
					ShiftSrcD <= 'b0;
                    HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= 3'b000;
                    PCtoRegD <= 1'b0;
                    RdD_31_Control <= 1'b0;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b0;
                    J_Rs_ControlD <= 1'b0;
                end
                `OP_ANDI:begin
                    RegWriteD <= 1'b1;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_AND;
                    ALUSrcD <= 1'b1;
                    RegDstD <= 1'b0;
                    BranchD <= 1'b0;
                    SigExtendSignalD <= 1'b00;       // 0 extend
                    ShiftSrcD <= 'b0;
                    HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= 3'b000;
                    PCtoRegD <= 1'b0;
                    RdD_31_Control <= 1'b0;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b0;
                    J_Rs_ControlD <= 1'b0; 
                end 
                `OP_XORI:begin
                    RegWriteD <= 1'b1;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_XOR;
                    ALUSrcD <= 1'b1;
                    RegDstD <= 1'b0;
                    BranchD <= 1'b0;
                    SigExtendSignalD <= 1'b00;       // 0 extend
                    ShiftSrcD <= 'b0;
                    HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= 3'b000;
                    PCtoRegD <= 1'b0;
                    RdD_31_Control <= 1'b0;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b0;
                    J_Rs_ControlD <= 1'b0; 
                end 
                         
                `OP_SLTI:begin
                    RegWriteD <= 1'b1;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_SLT;
                    ALUSrcD <= 1'b1;
                    RegDstD <= 1'b0;
                    BranchD <= 1'b0;
                    SigExtendSignalD <= 1'b01;       // 1 extend
					ShiftSrcD <= 'b0;
                    HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= 3'b000;
                    PCtoRegD <= 1'b0;
                    RdD_31_Control <= 1'b0;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b0;
                    J_Rs_ControlD <= 1'b0;
                end
                
                `OP_SLTIU:begin
                    RegWriteD <= 1'b1;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_SLTU;
                    ALUSrcD <= 1'b1;
                    RegDstD <= 1'b0;
                    BranchD <= 1'b0;
                    SigExtendSignalD <= 1'b01;       // 1 extend
					ShiftSrcD <= 'b0;
                    HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= 3'b000;
                    PCtoRegD <= 1'b0;
                    RdD_31_Control <= 1'b0;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b0;
                    J_Rs_ControlD <= 1'b0;
                end
                `OP_BEQ:begin
                    RegWriteD <= 1'b0;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_NONE;
                    ALUSrcD <= 1'b0;
                    RegDstD <= 1'b1;
                    BranchD <= 1'b1;
                    SigExtendSignalD <= 1'b01;       // 1 extend
					ShiftSrcD <= 'b0;
                    HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= `EQC_EQUAL;
                    PCtoRegD <= 1'b0;
                    RdD_31_Control <= 1'b0;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b0;
                    J_Rs_ControlD <= 1'b0;
                end
                `OP_BNE:begin
                    RegWriteD <= 1'b0;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_NONE;
                    ALUSrcD <= 1'b0;
                    RegDstD <= 1'b1;
                    BranchD <= 1'b1;
                    SigExtendSignalD <= 1'b01;       // 1 extend
					ShiftSrcD <= 'b0;
                    HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= `EQC_NOT_EQUAL;
                    PCtoRegD <= 1'b0;
                    RdD_31_Control <= 1'b0;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b0;
                    J_Rs_ControlD <= 1'b0;
                end
                `OP_BGTZ:begin
                    RegWriteD <= 1'b0;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_NONE;
                    ALUSrcD <= 1'b0;
                    RegDstD <= 1'b1;
                    BranchD <= 1'b1;
                    SigExtendSignalD <= 1'b01;       // 1 extend
					ShiftSrcD <= 'b0;
                    HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= `EQC_HIGH;
                    PCtoRegD <= 1'b0;
                    RdD_31_Control <= 1'b0;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b0;
                    J_Rs_ControlD <= 1'b0;
                end
                `OP_BLEZ:begin
                    RegWriteD <= 1'b0;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_NONE;
                    ALUSrcD <= 1'b0;
                    RegDstD <= 1'b1;
                    BranchD <= 1'b1;
                    SigExtendSignalD <= 1'b01;       // 1 extend
					ShiftSrcD <= 'b0;
                    HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= `EQC_LOW_EQUAL;
                    PCtoRegD <= 1'b0;
                    RdD_31_Control <= 1'b0;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b0;
                    J_Rs_ControlD <= 1'b0;
                end
                `OP_J:begin
                    RegWriteD <= 1'b0;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_NONE;
                    ALUSrcD <= 1'b0;
                    RegDstD <= 1'b0;
                    BranchD <= 1'b1;
                    SigExtendSignalD <= 1'b00;       // 1 extend
					ShiftSrcD <= 'b0;
                    HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= `EQC_J;
                    PCtoRegD <= 1'b0;
                    RdD_31_Control <= 1'b0;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b1;
                    J_Rs_ControlD <= 1'b0;
                end
                `OP_JAL:begin
                    RegWriteD <= 1'b1;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_NONE;
                    ALUSrcD <= 1'b0;
                    RegDstD <= 1'b1;
                    BranchD <= 1'b1;
                    SigExtendSignalD <= 1'b00;       // 1 extend
					ShiftSrcD <= 'b0;
                    HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= `EQC_J;
                    PCtoRegD <= 1'b1;
                    RdD_31_Control <= 1'b1;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b1;
                    J_Rs_ControlD <= 1'b0;
                end
				//********************hjw*************************//
				`OP_LUI:begin   //hjw
                    RegWriteD <= 1'b1;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_NONE;
                    ALUSrcD <= 1'b1;
                    RegDstD <= 1'b0;
                    BranchD <= 1'b0;
                    SigExtendSignalD <= 2'b10;
                    ShiftSrcD <= 1'b0;
					HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= 3'b000;
                    PCtoRegD <= 1'b0;
                    RdD_31_Control <= 1'b0;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b0;
                    J_Rs_ControlD <= 1'b0;
                end
             `OP_LB:begin
                RegWriteD <= 1'b1;
                MemtoRegD <= 1'b1;
                MemWriteD <= 1'b0;
                ALUControlD <= `ALU_ADD;
                ALUSrcD <= 1'b1;
                RegDstD <= 1'b0;
                BranchD <= 1'b0;
                SigExtendSignalD <= 2'b01;
                ShiftSrcD <= 1'b0;
                HiWriteD <= 1'b0;
                LoWriteD <= 1'b0;
                EqualDControl <= 3'b000;
                PCtoRegD <= 1'b0;
                RdD_31_Control <= 1'b0;
                HilotoRegD <=1'b0;
                J_Imi_ControlD <= 1'b0;
                J_Rs_ControlD <= 1'b0;
           end
           `OP_LBU:begin
                RegWriteD <= 1'b1;
                MemtoRegD <= 1'b1;
                MemWriteD <= 1'b0;
                ALUControlD <= `ALU_ADD;
                ALUSrcD <= 1'b1;
                RegDstD <= 1'b0;
                BranchD <= 1'b0;
                SigExtendSignalD <= 2'b01;
                ShiftSrcD <= 1'b0;
                HiWriteD <= 1'b0;
                LoWriteD <= 1'b0;
                EqualDControl <= 3'b000;
                PCtoRegD <= 1'b0;
                RdD_31_Control <= 1'b0;
                HilotoRegD <=1'b0;
                J_Imi_ControlD <= 1'b0;
                J_Rs_ControlD <= 1'b0;
          end
          `OP_LH:begin
                RegWriteD <= 1'b1;
                MemtoRegD <= 1'b1;
                MemWriteD <= 1'b0;
                ALUControlD <= `ALU_ADD;
                ALUSrcD <= 1'b1;
                RegDstD <= 1'b0;
                BranchD <= 1'b0;
                SigExtendSignalD <= 2'b01;
                ShiftSrcD <= 1'b0;
                HiWriteD <= 1'b0;
                LoWriteD <= 1'b0;
                EqualDControl <= 3'b001;
                PCtoRegD <= 1'b0;
                RdD_31_Control <= 1'b0;
                HilotoRegD <=1'b0;
                J_Imi_ControlD <= 1'b0;
                J_Rs_ControlD <= 1'b0;
             
         end
         `OP_LHU:begin
                RegWriteD <= 1'b1;
                MemtoRegD <= 1'b1;
                MemWriteD <= 1'b0;
                ALUControlD <= `ALU_ADD;
                ALUSrcD <= 1'b1;
                RegDstD <= 1'b0;
                BranchD <= 1'b0;
                SigExtendSignalD <= 2'b01;
                ShiftSrcD <= 1'b0;
                HiWriteD <= 1'b0;
                LoWriteD <= 1'b0;
                EqualDControl <= 3'b000;
                PCtoRegD <= 1'b0;
                RdD_31_Control <= 1'b0;
                HilotoRegD <=1'b0;
                J_Imi_ControlD <= 1'b0;
                J_Rs_ControlD <= 1'b0;

         end
         `OP_LW:begin
                RegWriteD <= 1'b1;
                MemtoRegD <= 1'b1;
                MemWriteD <= 1'b0;
                ALUControlD <= `ALU_ADD;
                ALUSrcD <= 1'b1;
                RegDstD <= 1'b0;
                BranchD <= 1'b0;
                SigExtendSignalD <= 2'b01;
                ShiftSrcD <= 1'b0;
                HiWriteD <= 1'b0;
                LoWriteD <= 1'b0;
                EqualDControl <= 3'b000;
                PCtoRegD <= 1'b0;
                RdD_31_Control <= 1'b0;
                HilotoRegD <=1'b0;
                J_Imi_ControlD <= 1'b0;
                J_Rs_ControlD <= 1'b0;

        end
        `OP_LWL:begin
                RegWriteD <= 1'b1;
                MemtoRegD <= 1'b1;
                MemWriteD <= 1'b0;
                ALUControlD <= `ALU_ADD;
                ALUSrcD <= 1'b1;
                RegDstD <= 1'b0;
                BranchD <= 1'b0;
                SigExtendSignalD <= 2'b01;
                ShiftSrcD <= 1'b0;
                HiWriteD <= 1'b0;
                LoWriteD <= 1'b0;
                EqualDControl <= 3'b000;
                PCtoRegD <= 1'b0;
                RdD_31_Control <= 1'b0;
                HilotoRegD <=1'b0;
                J_Imi_ControlD <= 1'b0;
                J_Rs_ControlD <= 1'b0;

end
        `OP_LWR:begin
                RegWriteD <= 1'b1;
                MemtoRegD <= 1'b1;
                MemWriteD <= 1'b0;
                ALUControlD <= `ALU_ADD;
                ALUSrcD <= 1'b1;
                RegDstD <= 1'b0;
                BranchD <= 1'b0;
                SigExtendSignalD <= 2'b01;
                ShiftSrcD <= 1'b0;
                HiWriteD <= 1'b0;
                LoWriteD <= 1'b0;
                EqualDControl <= 3'b000;
                PCtoRegD <= 1'b0;
                RdD_31_Control <= 1'b0;
                HilotoRegD <=1'b0;
                J_Imi_ControlD <= 1'b0;
                J_Rs_ControlD <= 1'b0;

        end
        `OP_SB:begin
                RegWriteD <= 1'b0;
                MemtoRegD <= 1'b1;
                MemWriteD <= 1'b1;
                ALUControlD <= `ALU_ADD;
                ALUSrcD <= 1'b1;
                RegDstD <= 1'b0;
                BranchD <= 1'b0;
                SigExtendSignalD <= 2'b01;
                ShiftSrcD <= 1'b0;
                HiWriteD <= 1'b0;
                LoWriteD <= 1'b0;
                EqualDControl <= 3'b000;
                PCtoRegD <= 1'b0;
                RdD_31_Control <= 1'b0;
                HilotoRegD <=1'b0;
                J_Imi_ControlD <= 1'b0;
                J_Rs_ControlD <= 1'b0;

        end
        `OP_SH:begin
                RegWriteD <= 1'b0;
                MemtoRegD <= 1'b1;
                MemWriteD <= 1'b1;
                ALUControlD <= `ALU_ADD;
                ALUSrcD <= 1'b1;
                RegDstD <= 1'b0;
                BranchD <= 1'b0;
                SigExtendSignalD <= 2'b01;
                ShiftSrcD <= 1'b0;
                HiWriteD <= 1'b0;
                LoWriteD <= 1'b0;
                EqualDControl <= 3'b000;
                PCtoRegD <= 1'b0;
                RdD_31_Control <= 1'b0;
                HilotoRegD <=1'b0;
                J_Imi_ControlD <= 1'b0;
                J_Rs_ControlD <= 1'b0;

        end
        `OP_SW:begin
                RegWriteD <= 1'b0;
                MemtoRegD <= 1'b1;
                MemWriteD <= 1'b1;
                ALUControlD <= `ALU_ADD;
                ALUSrcD <= 1'b1;
                RegDstD <= 1'b0;
                BranchD <= 1'b0;
                SigExtendSignalD <= 2'b01;
                ShiftSrcD <= 1'b0;
                HiWriteD <= 1'b0;
                LoWriteD <= 1'b0;
                EqualDControl <= 3'b000;
                PCtoRegD <= 1'b0;
                RdD_31_Control <= 1'b0;
                HilotoRegD <=1'b0;
                J_Imi_ControlD <= 1'b0;
                J_Rs_ControlD <= 1'b0;

        end               
        `OP_SWL:begin
                RegWriteD <= 1'b0;
                MemtoRegD <= 1'b1;
                MemWriteD <= 1'b1;
                ALUControlD <= `ALU_ADD;
                ALUSrcD <= 1'b1;
                RegDstD <= 1'b0;
                BranchD <= 1'b0;
                SigExtendSignalD <= 2'b01;
                ShiftSrcD <= 1'b0;
                HiWriteD <= 1'b0;
                LoWriteD <= 1'b0;
                EqualDControl <= 3'b000;
                PCtoRegD <= 1'b0;
                RdD_31_Control <= 1'b0;
                HilotoRegD <=1'b0;
                J_Imi_ControlD <= 1'b0;
                J_Rs_ControlD <= 1'b0;

        end 
        `OP_SWR:begin
                RegWriteD <= 1'b0;
                MemtoRegD <= 1'b1;
                MemWriteD <= 1'b1;
                ALUControlD <= `ALU_ADD;
                ALUSrcD <= 1'b1;
                RegDstD <= 1'b0;
                BranchD <= 1'b0;
                SigExtendSignalD <= 2'b01;
                ShiftSrcD <= 1'b0;
                HiWriteD <= 1'b0;
                LoWriteD <= 1'b0;
                EqualDControl <= 3'b000;
                PCtoRegD <= 1'b0;
                RdD_31_Control <= 1'b0;
                HilotoRegD <=1'b0;
                J_Imi_ControlD <= 1'b0;
                J_Rs_ControlD <= 1'b0;

        end                            
 
 
				//********************hjw*************************//
                default: begin
                    RegWriteD <= 1'b0;
                    MemtoRegD <= 1'b0;
                    MemWriteD <= 1'b0;
                    ALUControlD <= `ALU_NONE;
                    ALUSrcD <= 1'b0;
                    RegDstD <= 1'b0;
                    BranchD <= 1'b0;
                    SigExtendSignalD <= 1'b00;       // 1 extend
					ShiftSrcD <= 'b0;
                    HiWriteD <= 1'b0;
                    LoWriteD <= 1'b0;
                    EqualDControl <= 3'b000;
                    PCtoRegD <= 1'b0;
                    RdD_31_Control <= 1'b0;
                    HilotoRegD <=1'b0;
                    J_Imi_ControlD <= 1'b0;
                    J_Rs_ControlD <= 1'b0;

                end
            endcase
        end
        else begin
            RegWriteD <= 1'b0;
            MemtoRegD <= 1'b0;
            MemWriteD <= 1'b0;
            ALUControlD <= `ALU_NONE;
            ALUSrcD <= 1'b0;
            RegDstD <= 1'b0;
            BranchD <= 1'b0;
            SigExtendSignalD <= 1'b00;       // 1 extend
			ShiftSrcD <= 'b0;
            HiWriteD <= 1'b0;
            LoWriteD <= 1'b0;
            EqualDControl <= 3'b000;
            PCtoRegD <= 1'b0;
            RdD_31_Control <= 1'b0;
            HilotoRegD <=1'b0;
            J_Imi_ControlD <= 1'b0;
            J_Rs_ControlD <= 1'b0;
        end

    end
    
endmodule
