`timescale 1ns / 1ps
// update PC 
`include "defines.vh"
module access_mem(
    input wire clock,
    input wire reset,
    
    // control signal
    input MemWriteM,
    
    input wire[`OP_SIZE] opcodeM,
    // input 
    input wire[`ADDRLENGTH] addr,
    input wire [`DATALENGTH]writeData,
    input wire[`DATALENGTH] mem_data_i,

    
    // output
    output reg[32:0]          mem_addr_o,
    output reg                mem_we_o,
    output reg[3:0]           mem_sel_o,
    output reg[32:0]          mem_data_o,
    output reg                mem_ce_o,
    
    output reg[`DATALENGTH]   readData
    );
    
    wire [32:0] zero32;
    assign zero32 =`ZeroWord;
   
        always @(*)begin
        case(opcodeM)
        
        `OP_LB:        begin
                            mem_addr_o <= addr;
                            mem_we_o <= MemWriteM;
                            mem_ce_o <= `ChipEnable;
                            case (addr[1:0])
                                2'b00:    begin
                                    readData <= {{24{mem_data_i[31]}},mem_data_i[31:24]};
                                    mem_sel_o <= 4'b1000;
                                end
                                2'b01:    begin
                                    readData <= {{24{mem_data_i[23]}},mem_data_i[23:16]};
                                    mem_sel_o <= 4'b0100;
                                end
                                2'b10:    begin
                                    readData <= {{24{mem_data_i[15]}},mem_data_i[15:8]};
                                    mem_sel_o <= 4'b0010;
                                end
                                2'b11:    begin
                                    readData <= {{24{mem_data_i[7]}},mem_data_i[7:0]};
                                    mem_sel_o <= 4'b0001;
                                end
                                default:    begin
                                    readData <= `ZeroWord;
                                end
                            endcase
                        end
                        `OP_LBU:        begin
                            mem_addr_o <= addr;
                            mem_we_o <= MemWriteM;
                            mem_ce_o <= `ChipEnable;
                            case (addr[1:0])
                                2'b00:    begin
                                    readData <= {{24{1'b0}},mem_data_i[31:24]};
                                    mem_sel_o <= 4'b1000;
                                end
                                2'b01:    begin
                                    readData <= {{24{1'b0}},mem_data_i[23:16]};
                                    mem_sel_o <= 4'b0100;
                                end
                                2'b10:    begin
                                    readData <= {{24{1'b0}},mem_data_i[15:8]};
                                    mem_sel_o <= 4'b0010;
                                end
                                2'b11:    begin
                                    readData <= {{24{1'b0}},mem_data_i[7:0]};
                                    mem_sel_o <= 4'b0001;
                                end
                                default:    begin
                                    readData <= `ZeroWord;
                                end
                            endcase                
                        end
                        `OP_LH:        begin
                            mem_addr_o <= addr;
                            mem_we_o <= MemWriteM;
                            mem_ce_o <= `ChipEnable;
                            case (addr[1:0])
                                2'b00:    begin
                                    readData <= {{16{mem_data_i[31]}},mem_data_i[31:16]};
                                    mem_sel_o <= 4'b1100;
                                end
                                2'b10:    begin
                                  readData <= {{16{mem_data_i[15]}},mem_data_i[15:0]};
                                    mem_sel_o <= 4'b0011;
                                end
                                default:    begin
                                    readData <= `ZeroWord;
                                end
                            endcase                    
                        end
                        `OP_LHU:        begin
                            mem_addr_o <= addr;
                            mem_we_o <= MemWriteM;
                            mem_ce_o <= `ChipEnable;
                            case (addr[1:0])
                                2'b00:    begin
                                    readData <= {{16{1'b0}},mem_data_i[31:16]};
                                    mem_sel_o <= 4'b1100;
                                end
                                2'b10:    begin
                                    readData <= {{16{1'b0}},mem_data_i[15:0]};
                                    mem_sel_o <= 4'b0011;
                                end
                                default:    begin
                                    readData <= `ZeroWord;
                                end
                            endcase                
                        end
                        `OP_LW:        begin
                            mem_addr_o <= addr;
                            mem_we_o <= MemWriteM;
                            readData <= mem_data_i;
                            mem_sel_o <= 4'b1111;
                            mem_ce_o <= `ChipEnable;        
                        end
                       
                        `OP_LWL:        begin
                            mem_addr_o <= {addr[31:2], 2'b00};
                            mem_we_o <= MemWriteM;
                            mem_sel_o <= 4'b1111;
                            mem_ce_o <= `ChipEnable;
                            case (addr[1:0])
                                2'b00:    begin
                                    readData <= mem_data_i[31:0];
                                end
                                2'b01:    begin
                                    readData <= {mem_data_i[23:0],writeData[7:0]};
                                end
                                2'b10:    begin
                                    readData <= {mem_data_i[15:0],writeData[15:0]};
                                end
                                2'b11:    begin
                                    readData <= {mem_data_i[7:0],writeData[23:0]};    
                                end
                                default:    begin
                                    readData <= `ZeroWord;
                                end
                            endcase                
                        end
                        `OP_LWR:        begin
                            mem_addr_o <= {addr[31:2], 2'b00};
                            mem_we_o <= MemWriteM;
                            mem_sel_o <= 4'b1111;
                            mem_ce_o <= `ChipEnable;
                            case (addr[1:0])
                                2'b00:    begin
                                    readData <= {writeData[31:8],mem_data_i[31:24]};
                                end
                                2'b01:    begin
                                    readData <= {writeData[31:16],mem_data_i[31:16]};
                                end
                                2'b10:    begin
                                    readData <= {writeData[31:24],mem_data_i[31:8]};
                                end
                                2'b11:    begin
                                    readData <= mem_data_i;    
                                end
                                default:    begin
                                    readData <= `ZeroWord;
                                end
                            endcase                    
                        end
                        
                        `OP_SB:        begin
                            mem_addr_o <= addr;
                            mem_we_o <= MemWriteM;
                            mem_data_o <= {writeData[7:0],writeData[7:0],writeData[7:0],writeData[7:0]};
                            mem_ce_o <= `ChipEnable;
                            case (addr[1:0])
                                2'b00:    begin
                                    mem_sel_o <= 4'b1000;
                                end
                                2'b01:    begin
                                    mem_sel_o <= 4'b0100;
                                end
                                2'b10:    begin
                                    mem_sel_o <= 4'b0010;
                                end
                                2'b11:    begin
                                    mem_sel_o <= 4'b0001;    
                                end
                                default:    begin
                                    mem_sel_o <= 4'b0000;
                                end
                            endcase                
                        end
                        `OP_SH:        begin
                            mem_addr_o <= addr;
                            mem_we_o <= MemWriteM;
                            mem_data_o <= {writeData[15:0],writeData[15:0]};
                            mem_ce_o <= `ChipEnable;
                            case (addr[1:0])
                                2'b00:    begin
                                    mem_sel_o <= 4'b1100;
                                end
                                2'b10:    begin
                                    mem_sel_o <= 4'b0011;
                                end
                                default:    begin
                                    mem_sel_o <= 4'b0000;
                                end
                            endcase                        
                        end
                        `OP_SW:        begin
                            mem_addr_o <= addr;
                            mem_we_o <= MemWriteM;
                            mem_data_o <= writeData;
                            mem_sel_o <= 4'b1111;    
                            mem_ce_o <= `ChipEnable;        
                        end
                        
                        `OP_SWL:        begin
                            mem_addr_o <= {addr[31:2], 2'b00};
                            mem_we_o <= MemWriteM;
                            mem_ce_o <= `ChipEnable;
                            case (addr[1:0])
                                2'b00:    begin                          
                                    mem_sel_o <= 4'b1111;
                                    readData <= writeData;
                                end
                                2'b01:    begin
                                    mem_sel_o <= 4'b0111;
                                    readData <= {zero32[7:0],writeData[31:8]};
                                end
                                2'b10:    begin
                                    mem_sel_o <= 4'b0011;
                                    readData <= {zero32[15:0],writeData[31:16]};
                                end
                                2'b11:    begin
                                    mem_sel_o <= 4'b0001;    
                                    readData <= {zero32[23:0],writeData[31:24]};
                                end
                                default:    begin
                                    mem_sel_o <= 4'b0000;
                                end
                            endcase                            
                        end
                        `OP_SWR:        begin
                            mem_addr_o <= {addr[31:2], 2'b00};
                            mem_we_o <= MemWriteM;
                            mem_ce_o <= `ChipEnable;
                            case (addr[1:0])
                                2'b00:    begin                          
                                    mem_sel_o <= 4'b1000;
                                    mem_data_o <= {writeData[7:0],zero32[23:0]};
                                end
                                2'b01:    begin
                                    mem_sel_o <= 4'b1100;
                                    mem_data_o <= {writeData[15:0],zero32[15:0]};
                                end
                                2'b10:    begin
                                    mem_sel_o <= 4'b1110;
                                    mem_data_o <= {writeData[23:0],zero32[7:0]};
                                end
                                2'b11:    begin
                                    mem_sel_o <= 4'b1111;    
                                    mem_data_o <= writeData[31:0];
                                end
                                default:    begin
                                    mem_sel_o <= 4'b0000;
                                end
                            endcase                                            
                        end
                        
                        default:        begin
                  // ≤√¥"≤≤ª◊ˆ
                        
                     end
                    endcase                            
                end    //if
                 //always
            
      

endmodule