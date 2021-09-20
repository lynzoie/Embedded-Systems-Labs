`timescale 1s / 1ms
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2021 03:19:36 PM
// Design Name: 
// Module Name: lab_2
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


module lab2(
  input Clk,
  input [1:0] Crosswalk_NS,
  input [1:0] Crosswalk_EW,

  output [2:0] Out_East,
  output [2:0] Out_West,
  output [2:0] Out_North,
  output [2:0] Out_South,
  output [1:0] Crosswalk_Light, //[0]-NS, [1]-EW 
  output Out_North_Turn,
  output Out_South_Turn
    );

localparam red_light = 200000000; // ns
localparam green_light = 800000000; //ns

reg [2:0] state = 3'b000;
reg [1:0] crosswalk_reg = 2'b00;
reg [2:0] east_reg = 3'b000;
reg [2:0] west_reg = 3'b000; 
reg [2:0] north_reg = 3'b000;
reg [2:0] south_reg = 3'b000; 
reg north_turn_reg = 1'b0;
reg south_turn_reg = 1'b0;

always @(posedge Clk)
begin 
  case(state)
    0 : // case 0 : all red
    begin 
      east_reg = 3'b100;
      west_reg = 3'b100;
      north_reg = 3'b100;
      south_reg = 3'b100;
      
      north_turn_reg = 1'b0;
      south_turn_reg = 1'b0;
      
      crosswalk_reg = 2'b00;

      // wait 2 seconds   
      
      if (Crosswalk_EW > 0)
        state <= #2 1;
      else
        state <= #2 3;
    end 
    1 : // case 1 : 2-4 green, 1-3 are red, crosswalk on
    begin 
      east_reg = 3'b001;
      west_reg = 3'b001;
      north_reg = 3'b100;
      south_reg = 3'b100;
      
      north_turn_reg = 1'b0;
      south_turn_reg = 1'b0;
      
      crosswalk_reg = 2'b01;
      
      // wait 8 
      state = #8 2;
      
    end
    2 : // case 2 : 2-4 yellow, 1-3 are red, crosswalk off
    begin 
      east_reg = 3'b010;
      west_reg = 3'b010;
      north_reg = 3'b100;
      south_reg = 3'b100;
      
      north_turn_reg = 1'b0;
      south_turn_reg = 1'b0;
      
      crosswalk_reg = 2'b00;
      // wait 2 seconds
      
      state <= #2 0;
    end
    3 : // case 3 : 1-3 green, 2-4 are red, crosswalk on
    begin 
      //wait 8 seconds
      east_reg = 3'b100;
      west_reg = 3'b100;
      north_reg = 3'b001;
      south_reg = 3'b001;
      north_turn_reg = 1'b0;
      south_turn_reg = 1'b0;
      
      crosswalk_reg = 2'b10;

      
      state <= #8 4;
  
    end
    4 : // case 4 : 1-3 yellow, 2-4 red, crosswalk off
    begin 
      // wait 2 seconds
      east_reg = 3'b100;
      west_reg = 3'b100;
      north_reg = 3'b010;
      south_reg = 3'b010;
      
      north_turn_reg = 1'b0;
      south_turn_reg = 1'b0;
      
      crosswalk_reg = 2'b00;
      
      
      state <= #2 0;
        
    end
    5 : // case 5 : 1 green, all red, crosswalk off
    begin 
      // wait 2 seconds with green/left signal 1/4, then 6 seconds for crosswalk
      east_reg  = 3'b100;
      west_reg = 3'b100;
      north_reg = 3'b001;
      south_turn_reg = 1'b0;
     
      
      north_reg = 1'b1;
      south_reg = 3'b100;
      crosswalk_reg = 2'b00;
      #2
     
      north_reg = 1'b0;
      south_reg = 3'b001;
      crosswalk_reg = 2'b10;
      #60; 
      state = 3;

    end
    6 : // case 6 : 3 green, all red, crosswalk off
    begin 
      // wait 2 seconds with green/left signal 1/4, then 6 seconds for crosswalk
      east_reg = 3'b100;
      west_reg = 3'b100;
      south_reg = 3'b001;
      north_turn_reg = 1'b0;
     
      south_turn_reg = 1'b1;
      north_reg = 3'b100;
      crosswalk_reg = 2'b00;
      #2
      
      south_turn_reg = 1'b0;
      north_reg = 3'b001;
      crosswalk_reg = 2'b10;
      #60;
      state = 3; 
    end 
  default : state = 0;
  endcase
end

assign Crosswalk_Light = crosswalk_reg;
assign Out_East = east_reg;
assign Out_West = west_reg; 
assign Out_North = north_reg;
assign Out_South = south_reg; 
assign Out_North_Turn = north_turn_reg;
assign Out_South_Turn = south_turn_reg;

endmodule
