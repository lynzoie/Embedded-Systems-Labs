`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2021 10:53:00 AM
// Design Name: 
// Module Name: tb_Vend_Main
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


module tb_Vend_Main();

  // declare inputs
  reg Clk;
  reg clk2;
  reg [1:0] scored_flag;

  // declare outputs
  wire [1:0] changeLED;        //change dispensed
  wire [3:0] Anode_Activate;    //turn 7-seg on
  wire [6:0] LED_out;           //display digit on 7-seg
  wire decimal;                  //display decimal on 7-seg
  wire [11:0] foursOut; 
    
  localparam period = 100;  // 10 ns delay

  // map to lab2 module
  Vend_Main UUT (.Clk(Clk), .scored_flag(scored_flag), .changeLED(changeLED), .Anode_Activate(Anode_Activate), .LED_out(LED_out), .decimal(decimal), .foursOut(foursOut));

  // initialize the clock for simulation
  always begin 
    clk2 = 1'b1;
    #20;     // high for 10 ns
    clk2 = 1'b0;
    #20;     // low for 10 ns
  end
  
    // initialize the internal clock for board
  always begin 
    Clk = 1'b1;
    #10; // high for 10 ns
    Clk = 1'b0; 
    #10;     // low for 10 ns
  end
  
  initial begin 
    scored_flag = 2'b00;
    end

 always @(posedge clk2) 
 begin
    // iterate through test cases
      #period // wait for period 
      scored_flag = 2'b01; //25
      $monitor("score=%16d", foursOut); 
      #period // wait for period 
      scored_flag = 2'b00; //25
      $monitor("score=%16d", foursOut);
      #period // wait for period 
      scored_flag = 2'b01; //50
      $monitor("score=%16d", foursOut);
      #period // wait for period 
      scored_flag = 2'b00; //50
      $monitor("score=%16d", foursOut);
      #period // wait for period 
      scored_flag = 2'b10; //150
      $monitor("score=%16d", foursOut);
      #period // wait for period 
      scored_flag = 2'b00; //150
      $monitor("score=%16d", foursOut);
      #period // wait for period 
      scored_flag = 2'b10; //250
      $monitor("score=%16d", foursOut);
      #period // wait for period 
      scored_flag = 2'b00; //250
      $monitor("score=%16d", foursOut);
      #period // wait for period 
      scored_flag = 2'b00; //250
      $monitor("score=%16d", foursOut);
      scored_flag = 2'b11; //reset
      $monitor("score=%16d", foursOut);
  end
   
endmodule