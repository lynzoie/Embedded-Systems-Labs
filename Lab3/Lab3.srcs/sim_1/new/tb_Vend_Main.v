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
  reg [3:0] money_in; 
  reg [7:0] product_in;
  reg dispense;

  // declare outputs
  wire [7:0] product_out;
  wire [1:0] changeLED;        //change dispensed
  wire [1:0] alert;             //not enough money or out of stock
  wire [3:0] Anode_Activate;    //turn 7-seg on
  wire [6:0] LED_out;           //display digit on 7-seg
  wire decimal;                  //display decimal on 7-seg
    
  localparam period = 100;  // 10 ns delay

  // map to lab2 module
  Vend_Main UUT (.Clk(Clk), .money_in(money_in), .product_in(product_in), .dispense(dispense), .product_out(product_out), .changeLED(changeLED), .alert(alert), .Anode_Activate(Anode_Activate), .LED_out(LED_out), .decimal(decimal));

  // initialize the clock for simulation
  always begin 
    clk2 = 1'b1;
    #10;     // high for 10 ns
    clk2 = 1'b0;
    #10;     // low for 10 ns
  end
  
    // initialize the internal clock for board
  always begin 
    Clk = 1'b1;
    #10; // high for 10 ns
    Clk = 1'b0; 
    #10;     // low for 10 ns
  end
  
  initial begin 
    money_in = 4'b0000;
    product_in = 8'b00000000;
    dispense = 1'b0;
  end

 always @(posedge clk2) 
 begin
    // iterate through test cases
      #period // wait for period 
      money_in = 4'b0000; product_in = 8'b00000000; dispense = 1'b0;
      #period // wait for period 
      money_in = 4'b0001; product_in = 8'b00000000; dispense = 1'b0;
      #period // wait for period 
      money_in = 4'b0001; product_in = 8'b00000000; dispense = 1'b0;
      #period // wait for period 
      money_in = 4'b0000; product_in = 8'b00000000; dispense = 1'b0; // 1.50 is in bank
      #period // wait for period 
      money_in = 4'b0010; product_in = 8'b00000000; dispense = 1'b0; // 2.50 is in bank 
      #period // wait for period 
      money_in = 4'b0010; product_in = 8'b00000000; dispense = 1'b0; // pause
      #period // wait for period 
      money_in = 4'b0000; product_in = 8'b10000000; dispense = 1'b0; //1.25
      #period // wait for period 
      dispense = 1'b1; 
      #period // wait for period 
      money_in = 4'b0000; product_in = 8'b00001000; dispense = 1'b0; //.75
      #period // wait for period 
      dispense = 1'b1; 
      #period; 
      money_in = 4'b0000; product_in = 8'b00000010; dispense = 1'b0; //.50
      #period // wait for period 
      dispense = 1'b1; 
      #period; //wait for period
      #period; //wait for period
  end
   
endmodule