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
    reg     [1:0] state,
    reg     [4:0] Out_Reg,  // [CF + Out]
    reg     [3:0] In1_Reg,  // store value of In1
    reg     [3:0] In2_Reg,  // store value of In2
    reg     Z_Reg
    );

    always @(state) 
    begin
      case(state)
        2'b00 : // case 0 : get instructions, next state <= S1 press button
        begin 
          if (Clk == 1'b1) 
            state = 2'b01;  
          end
        2'b01 : // case 1 : get input 1, next state <= S2 press button
        begin 
          if (Clk == 1'b1) 
            state = 2'b10;
          else
            In1_Reg = In1;  
          end
        2'b10 : // case 2 : get input 2, next state <= S3 press button
        begin
          if (Clk == 1'b1) 
            state = 2'b01;
          else
            In2_Reg = In2;  
          end
        2'b11 : // case 3 : display output, next state <= S0 
        begin
          // execute instruction
          case(Ctrl)           
            00 : Out_Reg = In1_Reg + In2_Reg;       // Add
            01 : Out_Reg = In1_Reg & In2_Reg;       // And
            10 : Out_Reg = ~In1_Reg;            // Not In1
            11 : Out_Reg = In1_Reg | In2_Reg;       // Or
          endcase   
          
          // assign Z
          if (Out_Reg == 0) 
            Z_Reg = 1'b0;
          else
            Z_Reg = 1'b1;
          
          state = 2'b00;        // go back to the beginning
        end
       endcase
    end

    assign Cf = Out_Reg[4];
    assign Out = Out_Reg[3:0];
    assign Z = Z_Reg;
endmodule
