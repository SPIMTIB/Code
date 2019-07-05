`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2019 07:02:42 AM
// Design Name: 
// Module Name: mips_sopc
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


//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2019 07:53:45 PM
// Design Name: 
// Module Name: mips_sopc
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

module mips_sopc(

	input	wire										clock,
	input wire										reset
	
);

  //¡¨Ω"÷∏¡Ó¥Ê¥¢∆˜

  wire mem_we_i;
  wire[32:0] mem_addr_i;
  wire[32:0] mem_data_i;
  wire[32:0] mem_data_o;
  wire[3:0] mem_sel_i;
  wire mem_ce_i;    
 

 mips mips0(
		.clock(clock),
		.reset(reset),
	
		


		.ram_we_o(mem_we_i),
		.ram_addr_o(mem_addr_i),
		.ram_sel_o(mem_sel_i),
		.ram_data_o(mem_data_i),
		.ram_data_i(mem_data_o),
		.ram_ce_o(mem_ce_i)		
	
	);
	
	

	data_ram data_ram0(
		.clock(clock),
		.ce(mem_ce_i),
		.we(mem_we_i),
		.addr(mem_addr_i),
		.sel(mem_sel_i),
		.data_i(mem_data_i),
		.data_o(mem_data_o)	
	);

endmodule
