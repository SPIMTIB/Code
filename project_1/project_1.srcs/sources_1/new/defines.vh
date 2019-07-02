
module defines();

`define WRITEABLE 1'b1
`define UNWRITEABLE 1'b0

`define RESETABLE 1'b1
`define RESETUNABLE 1'b0
`define ChipEnable 1'b1

`define ZEROWORD 32'h00000000

`define INSTRLENGTH 31:0
`define DATALENGTH 31:0 
`define BYTELENGTH 7:0
`define ADDRLENGTH 31:0

`define INSTR_MEM_NUM 131071
`define DATA_MEM_NUM 131071
`define DATA_MEM_NUM_LOG2 17

`define INSTRSIZE 31:0
`define PCSIZE 31:0

`define INSTR_INDEX 25:0

`define OP_SIZE 5:0
`define R_SIZE 4:0
`define IMI_SIZE 15:0
//`define SIG_IMI_SIZE 31:0

`define ALUCONTROL_SIZE 4:0
`define EXTENDSIGNAL_SIZE 1:0   //hjw

`define CONTROL_EQUALD_SIZE 2:0

`define REGNUM 32
// opcode
`define OP_REGIMM 6'b000001
`define OP_LW 6'b100011
`define OP_ORI 6'b001101
`define OP_ADDI 6'b001000
`define OP_ADDIU 6'b001001
`define OP_ALL_ZERO 6'b000000
`define OP_SLTI 6'b001010
`define OP_SLTIU 6'b001011
`define OP_BEQ 6'b000100
`define OP_BNE 6'b000101
`define OP_BGTZ 6'b000111
`define OP_BLEZ 6'b000110
`define OP_J 6'b000010
`define OP_JAL 6'b000011
`define OP_ANDI 6'b001100  //hjw
`define OP_XORI 6'b001110  //hjw
`define OP_LUI 6'b001111  //hjw
/*****  load and store instr  *******/
`define OP_LB  6'b100000 
`define OP_LBU 6'b100100
`define OP_LH 6'b100001
`define OP_LHU 6'b100101
`define OP_LW 6'b100011
`define OP_SB 6'b101000
`define OP_SH 6'b101001
`define OP_SW 6'b101011
`define OP_LWL 6'b100010
`define OP_LWR 6'b100110
`define OP_SWL 6'b101010
`define OP_SWR 6'b101110


// opcode over

// for fen zhi zhi ling SEGIMM
`define RT_BLTZ 5'b00000
`define RT_BGEZ 5'b00001
`define RT_BLTZAL 5'b10000
`define RT_BGEZAL 5'b10001
// SEGIMM rt over

// EqualDControl encode
`define EQC_NONE 3'b000
`define EQC_EQUAL 3'b001
`define EQC_NOT_EQUAL 3'b010
`define EQC_HIGH_EQUAL 3'b011
`define EQC_HIGH 3'b100
`define EQC_LOW_EQUAL 3'b101
`define EQC_LOW 3'b110
`define EQC_J   3'b111      // for J instr
// EqualDCOntrol encode over 

// funccode
`define FUNC_ADD 6'b100000
`define FUNC_ADDU 6'b100001
`define FUNC_SUBU 6'b100011
`define FUNC_SUB 6'b100010
`define FUNC_SLT 6'b101010
`define FUNC_SLTU 6'b101011
`define FUNC_MUL 6'b011000
`define FUNC_MULU 6'b011001
`define FUNC_DIV 6'b011010
`define FUNC_DIVU 6'b011011
`define FUNC_MTHI 6'b010001
`define FUNC_MTLO 6'b010011
`define FUNC_MFHI 6'b010000
`define FUNC_MFLO 6'b010010
`define FUNC_JR 6'b001000
`define FUNC_JALR 6'b001001
`define FUNC_AND 6'b100100  //hjw
`define FUNC_OR 6'b100101  //hjw
`define FUNC_XOR 6'b100110  //hjw
`define FUNC_NOR 6'b100111  //hjw
`define FUNC_SLL 6'b000000  //hjw
`define FUNC_SLLV 6'b000100  //hjw
`define FUNC_SRA 6'b000011  //hjw
`define FUNC_SRAV 6'b000111  //hjw
`define FUNC_SRL 6'b000010  //hjw
`define FUNC_SRLV 6'b000110  //hjw
// funccode over
// ALU code
`define ALU_NONE 5'b00000 // new
`define ALU_ADD 5'b00010
`define ALU_OR 5'b00001
`define ALU_SUB 5'b00110
`define ALU_SLT 5'b00111
`define ALU_SLTU 5'b00011  // new
`define ALU_MUL 5'b00100  // new
`define ALU_MULU 5'b00101 // new
`define ALU_DIV 5'b01000  // new
`define ALU_DIVU 5'b01001   //new
`define ALU_MTHI 5'b01010 // new
`define ALU_MTLO 5'b01011   // same as last
`define ALU_ADD_OVERFLOW 5'b01100
`define ALU_SUB_OVERFLOW 5'b01101
`define ALU_XOR 5'b01100	//hjw
`define ALU_NOR 5'b01101	//hjw
`define ALU_AND 5'b01110	//hjw
`define ALU_SLL 5'b01111	//hjw
`define ALU_SRA 5'b10000	//hjw
`define ALU_SRL 5'b10001	//hjw

// access memory instrument control signal
`define MEM_LB 4'b0001
`define MEM_LBU 4'b0010
`define MEM_LH 4'b0011
`define MEM_LHU 4'b0100
`define MEM_LW 4'b0101
`define MEM_LWL 4'b0110
`define MEM_LWR 4'b0111
`define MEM_SB 4'b1000
`define MEM_SH 4'b1001
`define MEM_SW 4'b1010
`define MEM_SWL 4'b1011
`define MEM_SWR 4'b1100

`define ZeroWord 32'h00000000

// ALU code over
endmodule