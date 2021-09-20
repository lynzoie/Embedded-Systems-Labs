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
  input [1:0] TurnLane_NS,
  input [1:0] Broken,

  output [2:0] Out_East,
  output [2:0] Out_West,
  output [2:0] Out_North,
  output [2:0] Out_South,
  output [1:0] Crosswalk_Light, //[0]-NS, [1]-EW 
  output Out_North_Turn,
  output Out_South_Turn
    );

//reg [25:0] FrequencyCount = 0;
//reg [3:0] LightDelay = 0;

integer FrequencyCount = 0;
integer LightDelay = 0;
reg Clk_Out;

//reg [2:0] state = 3'b000;
integer state = 0;  //current state
integer Pstate = 0; //previous state

reg [1:0] crosswalk_reg = 2'b00;
reg [2:0] east_reg = 3'b000;
reg [2:0] west_reg = 3'b000; 
reg [2:0] north_reg = 3'b000;
reg [2:0] south_reg = 3'b000; 
reg north_turn_reg = 1'b0;
reg south_turn_reg = 1'b0;

always @(posedge Clk)
begin
//FrequencyCount<=FrequencyCount+1;
FrequencyCount = FrequencyCount + 1;
if (FrequencyCount == 50000000) //if 1s passes (1MHz)

begin
//FrequencyCount<=0; //restart clock
FrequencyCount = 0;
//LightDelay<=LightDelay+1; //delay = + 1 second
LightDelay = LightDelay+1;

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
      
      if (Broken != 0) begin
           LightDelay = 0;
           state = 6;
       end

      //wait 2 seconds   
        if (LightDelay == 4) begin
              if((TurnLane_NS != 0) && (Pstate == 2))begin
                LightDelay = 0;
                state = 5;
            end
             else if(Pstate == 2)begin
                LightDelay = 0;
                state = 3;
            end
            else begin
                LightDelay = 0;
                state = 1;
            end
        end
        if(LightDelay == 4)begin
              LightDelay = 0;
              if(Pstate == 2)
                state = 3;
              else
                state = 1;
        end
    end
      
       /*wait 2 seconds   
        if (LightDelay == 4) begin
          LightDelay = 0;
              if(Pstate == 2)
                state = 3;
                else
                state = 1;
        end*/

          /* wait 2 seconds   
          if (LightDelay == 4) begin
              LightDelay = 0;
              if (Crosswalk_EW > 0)
                state = 1;
              else
                state = 3;
          end*/
    1 : // case 1 : E-W green, N-S are red, E-W crosswalk on
    begin 
      east_reg = 3'b001;
      west_reg = 3'b001;
      north_reg = 3'b100;
      south_reg = 3'b100;
      
      north_turn_reg = 1'b0;
      south_turn_reg = 1'b0;
      
      crosswalk_reg = 2'b01;
      
      // wait 8
      if (LightDelay == 8) begin
          LightDelay = 0; 
          state = 2;
      end
      
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
      // wait 4 seconds
      if (LightDelay == 4) begin
          Pstate = 2;
          LightDelay = 0;
          state = 0;
      end
    end
    3 : // case 3 : N-S green, E-W are red, N-S crosswalk on
    begin 
          east_reg = 3'b100;
          west_reg = 3'b100;
          north_reg = 3'b001;
          south_reg = 3'b001;
          north_turn_reg = 1'b0;
          south_turn_reg = 1'b0;
          
         crosswalk_reg = 2'b10;
        
          //wait 8 seconds
          if (LightDelay == 8) begin
              LightDelay = 0;
              //crosswalk_reg = 2'b10;
              state = 4;
          end
      end
    4 : // case 4 : 1-3 yellow, 2-4 red, crosswalk off
    begin 
          east_reg = 3'b100;
          west_reg = 3'b100;
          north_reg = 3'b010;
          south_reg = 3'b010;
          
          north_turn_reg = 1'b0;
          south_turn_reg = 1'b0;
          
          crosswalk_reg = 2'b00;
          
          // wait 4 seconds
          if (LightDelay == 4) begin
              LightDelay = 0;
              Pstate = 4;
              state = 0;
          end
     end
    
    ///////////////////////Turn Lane Activate////////////////////////////
    
    5 : // case 5 : 1 green, all red, crosswalk off
    begin 
      // wait 2 seconds with green/left signal 1/4, then 6 seconds for crosswalk
          east_reg  = 3'b100;
          west_reg = 3'b100;
          north_reg = 3'b001;
          south_reg = 3'b001;
          
          if(LightDelay<4) begin
              north_turn_reg = 1'b1;
              south_turn_reg = 1'b1;
          end
          //wait 2 seconds
          if (LightDelay == 4) begin     
              /*north_reg = 1'b1;
              south_reg = 3'b100;
              crosswalk_reg = 2'b00;*/
             north_turn_reg = 1'b0;
             south_turn_reg = 1'b0;
             crosswalk_reg = 2'b10;
          end
              //crosswalk_reg = 2'b10;
              if (LightDelay == 10) begin
                  LightDelay = 0;
                  state = 4;
             end
    end
    6 : // case 6 : Broken
    begin 
      // wait 1 second on, 1 second off, until Broken == 0
          
      //wait 1 second to turn off
              east_reg  = 3'b000;
              west_reg = 3'b000;
              north_reg = 3'b000;
              south_reg = 3'b000;
 
           if (LightDelay == 2) begin
                  LightDelay = 0;
                  state = 0;
           end
    end
  default : state = 0;
  endcase
  end
  end

assign Out_North_Turn = north_turn_reg;
assign Out_South_Turn = south_turn_reg;
assign Crosswalk_Light = crosswalk_reg;
assign Out_East = east_reg;
assign Out_West = west_reg; 
assign Out_North = north_reg;
assign Out_South = south_reg; 
endmodule