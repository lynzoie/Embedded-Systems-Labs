// test bench for traffic light lab 02
// Will Breen, Anna Lanzillotta, Lynzie Romero, Andi Thomas

module tb_lab2(); 

  reg Clk;
  reg clk2; 
  reg [1:0] TurnLane_NS;
  reg [1:0] Broken;

  wire [2:0] Out_East;
  wire [2:0] Out_West;
  wire [2:0] Out_North;
  wire [2:0] Out_South;
  wire [1:0] Crosswalk_Light; //[0]-NS, [1]-EW 
  wire Out_North_Turn;
  wire Out_South_Turn;
    
  localparam period = 1000000000;  // 10 ns delay

  lab2 UUT (.Clk(Clk), .TurnLane_NS(TurnLane_NS), .Broken(Broken), .Out_East(Out_East), .Out_West(Out_West), .Out_North(Out_North), .Out_South(Out_South), .Crosswalk_Light(Crosswalk_Light), .Out_North_Turn(Out_North_Turn), .Out_South_Turn(Out_South_Turn));

  // initialize the clock
  always begin 
    clk2 = 1'b1;
    #1000000000; // high for 10 ns
    clk2 = 1'b0;
    #1000000000;     // low for 10 ns
  end
  
    // initialize the clock
  always begin 
    Clk = 1'b1;
    #10; // high for 10 ns
    Clk = 1'b0; 
    #10;     // low for 10 ns
  end
  
  initial begin 
    TurnLane_NS = 2'b00; 
    Broken = 2'b00; 
  end

 always @(posedge clk2) 
 begin
      #period // wait for period 
      TurnLane_NS = 2'b00; Broken = 2'b00;
      #period // wait for period 
      TurnLane_NS = 2'b01; Broken = 2'b00;
      #period // wait for period 
      TurnLane_NS = 2'b10; Broken = 2'b00;
      #period // wait for period 
      TurnLane_NS = 2'b11; Broken = 2'b00;
      #period // wait for period 
      TurnLane_NS = 2'b00; Broken = 2'b00;
      #period // wait for period 
      TurnLane_NS = 2'b00; Broken = 2'b01;
      #period // wait for period 
      TurnLane_NS = 2'b00; Broken = 2'b10;
      #period // wait for period 
      TurnLane_NS = 2'b00; Broken = 2'b11;
  end

endmodule