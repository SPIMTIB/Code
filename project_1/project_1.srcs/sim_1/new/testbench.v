`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 07:31:43 PM
// Design Name: 
// Module Name: testbench
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


module testbench();
    reg CLOCK_50;
    reg reset;

initial begin
    CLOCK_50 = 1'b0;
    forever #10 CLOCK_50 = ~CLOCK_50;
end

initial begin
    reset = 1'b1;
    #90 reset = 1'b0;//at least 55
    #5000 $stop;
end
    mips_sopc mips_sopc0(
    .clock(CLOCK_50),
    .reset(reset));

endmodule
