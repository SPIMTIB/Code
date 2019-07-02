`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2019 05:02:51 AM
// Design Name: 
// Module Name: data_ram
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

module data_ram(

	input wire								clock,
	input wire								ce,
	input wire								we,
	input wire[32:0]			            addr,
	input wire[3:0]							sel,
	input wire[32:0]						data_i,
	output reg[32:0]					    data_o
	
);


	
	   
        reg[`BYTELENGTH] data_mem0[0:`DATA_MEM_NUM-1];
        reg[`BYTELENGTH] data_mem1[0:`DATA_MEM_NUM-1];
        reg[`BYTELENGTH] data_mem2[0:`DATA_MEM_NUM-1];
        reg[`BYTELENGTH] data_mem3[0:`DATA_MEM_NUM-1];

	always @ (posedge clock) begin
		if (ce == 1) begin
			//data_o <= `ZEROWORD;
		end else if(we == 1) begin
			  if (sel[3] == 1'b1) begin
		      data_mem3[addr[`DATA_MEM_NUM_LOG2+1:2]] <= data_i[31:24];
		    end
			  if (sel[2] == 1'b1) begin
		      data_mem2[addr[`DATA_MEM_NUM_LOG2+1:2]] <= data_i[23:16];
		    end
		    if (sel[1] == 1'b1) begin
		      data_mem1[addr[`DATA_MEM_NUM_LOG2+1:2]] <= data_i[15:8];
		    end
			  if (sel[0] == 1'b1) begin
		      data_mem0[addr[`DATA_MEM_NUM_LOG2+1:2]] <= data_i[7:0];
		    end			   	    
		end
	end
	
	always @ (*) begin
		if (ce == 1) begin
			data_o <= `ZEROWORD;
	  end else if(we == 0) begin
		    data_o <= {data_mem3[addr[`DATA_MEM_NUM_LOG2+1:2]],
		               data_mem2[addr[`DATA_MEM_NUM_LOG2+1:2]],
		               data_mem1[addr[`DATA_MEM_NUM_LOG2+1:2]],
		               data_mem0[addr[`DATA_MEM_NUM_LOG2+1:2]]};
		end else begin
				data_o <= `ZEROWORD;
		end
	end		

endmodule
