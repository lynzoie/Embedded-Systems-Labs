`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2021 05:54:53 PM
// Design Name: 
// Module Name: lab_1
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


module lab_1(
    input   [3:0] In1,
    input   [3:0] In2, 
    input   [1:0] Ctrl,     // instruction
    input   Clk,            // pushbutton, execute next step
    output  Z,              // if OUT=0, Z=0, else Z=1
    output  Cf,
    output  [3:0] Out,
    reg     state,
    reg     [4:0] Out_Reg,  // [CF + Out]
    reg     Z_Reg
    );
    
    // insert logic
    always @(state) 
    begin
        // case 0 : get instructions, next state <= S1 press button
        // case 1 : get input 1, next state <= S2 press button
        // case 2 : get input 2, next state <= S3 press button
        // case 3 : display output, next state <= S0 
        case(Ctrl)           
          00 : Out_Reg = In1 + In2;       // Add
          01 : Out_Reg = In1 & In2;       // And
          10 : Out_Reg = ~In1;            // Not In1
          11 : Out_Reg = In1 | In2;       // Or
        endcase   
        
        if (Out_Reg == 0) 
          assign Z_Reg = 0;
        else
          assign Z_Reg = 1;
           
    end

    assign Cf = Out_Reg[4];
    assign Out = Out_Reg[3:0];
    assign Z = Z_Reg;
endmodule
