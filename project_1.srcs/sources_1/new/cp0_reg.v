`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2019 10:40:57 PM
// Design Name: 
// Module Name: cp0_reg
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


module cp0_reg(
    input wire clk,
    input wire rst,
    
    input wire we_i,
    input[4:0] waddr_i,
    input[4:0] raddr_i,
    input[31:0] data_i,
    //6 ge interrupts 
    input wire[5:0]int_i,
    
    
    output [`DATALENGTH]           data_o,
	output reg[`DATALENGTH]           count_o,
	output reg[`DATALENGTH]           compare_o,
	output reg[`DATALENGTH]           status_o,
	output reg[`DATALENGTH]           cause_o,
	output reg[`DATALENGTH]           epc_o,
	output reg[`DATALENGTH]           config_o,
	output reg[`DATALENGTH]           prid_o,
	
	output reg                   timer_int_o   
    

    );
    always @ (posedge clk) begin
		if(rst == 1'b1) begin
			count_o <= `ZeroWord;
			compare_o <= `ZeroWord;
			//statusºƒ¥Ê∆˜µƒCUŒ™0001£¨±Ì æ-≠¥¶¿Ì∆˜CP0¥Ê'⁄
			status_o <= 32'b00010000000000000000000000000000;
			cause_o <= `ZeroWord;
			epc_o <= `ZeroWord;
			//configºƒ¥Ê∆˜µƒBEŒ™1£¨±Ì æBig-Endian£ªMTŒ™00£¨±Ì æ√ª"-MMU
			config_o <= 32'b00000000000000001000000000000000;
			//÷∆◊˜'ﬂ «L£¨∂'"¶µƒ «0x48£¨¿‡-Õ «0x1£¨ª˘±æ¿‡-Õ£¨∞Ê±æ∫≈ «1.0
			prid_o <= 32'b00000000010011000000000100000010;
      timer_int_o <= `InterruptNotAssert;
		end else begin
		  count_o <= count_o + 1 ;
		  cause_o[15:10] <= int_i;
		
			if(compare_o != `ZeroWord && count_o == compare_o) begin
				timer_int_o <= `InterruptAssert;
			end
					
			if(we_i == `WRITEABLE) begin
				case (waddr_i) 
					`CP0_REG_COUNT:		begin
						count_o <= data_i;
					end
					`CP0_REG_COMPARE:	begin
						compare_o <= data_i;
						//count_o <= `ZeroWord;
            timer_int_o <= `InterruptNotAssert;
					end
					`CP0_REG_STATUS:	begin
						status_o <= data_i;
					end
					`CP0_REG_EPC:	begin
						epc_o <= data_i;
					end
					`CP0_REG_CAUSE:	begin
					  //causeºƒ¥Ê∆˜÷ª"-IP[1:0]°¢IV°¢WP◊÷∂Œ «ø…-¥µƒ
						cause_o[9:8] <= data_i[9:8];
						cause_o[23] <= data_i[23];
						cause_o[22] <= data_i[22];
					end					
				endcase  //case addr_i
			end
			
			
		end    //if
	end      //always

/*			
	always @ (*) begin
		if(rst == 1'b1) begin
			data_o <= `ZeroWord;
		end else begin
				case (raddr_i) 
					`CP0_REG_COUNT:		begin
						data_o <= count_o ;
					end
					`CP0_REG_COMPARE:	begin
						data_o <= compare_o ;
					end
					`CP0_REG_STATUS:	begin
						data_o <= status_o ;
					end
					`CP0_REG_CAUSE:	begin
						data_o <= cause_o ;
					end
					`CP0_REG_EPC:	begin
						data_o <= epc_o ;
					end
					`CP0_REG_PrId:	begin
						data_o <= prid_o ;
					end
					`CP0_REG_CONFIG:	begin
						data_o <= config_o ;
					end	
					default: 	begin
					end			
				endcase  //case addr_i			
		end    //if
	end      //always
*/

        assign data_o = (rst == 1'b1) ? `ZeroWord :
                        (raddr_i == `CP0_REG_COUNT) ? count_o:
                        (raddr_i == `CP0_REG_COMPARE) ? compare_o:
                        (raddr_i == `CP0_REG_STATUS) ? status_o:
                        (raddr_i == `CP0_REG_CAUSE) ? cause_o:
                        (raddr_i == `CP0_REG_EPC) ? epc_o:
                        (raddr_i == `CP0_REG_PrId) ? prid_o:
                        (raddr_i == `CP0_REG_CONFIG) ? config_o:32'h00000000;
        
endmodule
