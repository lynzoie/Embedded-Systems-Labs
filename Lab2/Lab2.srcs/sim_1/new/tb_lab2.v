// test bench for traffic light lab 02
// Will Breen, Anna Lanzillotta, Lynzie Romero, Andi Thomas

module tb_lab2(); 
  reg [1:0] Crosswalk_NS, Crosswalk_EW;
  reg Clk; 
  reg clk2;

  wire [2:0] Out_East;
  wire [2:0] Out_West;
  wire [2:0] Out_North;
  wire [2:0] Out_South;
  wire [1:0] Crosswalk_Light; //[0]-NS, [1]-EW 
  wire Out_North_Turn;
  wire Out_South_Turn;

  localparam period = 10;  // 10 ns delay

  lab2 UUT (.Clk(Clk), .Crosswalk_NS(Crosswalk_NS), .Crosswalk_EW(Crosswalk_EW));


  // initialize the clock
  always begin 
    clk2 = 1'b1; 
    Clk = 1'b1;
    #10; // high for 50 ns
    clk2 = 1'b0;
    Clk = 1'b0; 
    #10;     // low for 50 ns
  end

 always @(posedge clk2) begin
      #period // wait for period 
      Crosswalk_NS = 0; Crosswalk_EW = 0;
      #period // wait for period 
      Crosswalk_NS = 0; Crosswalk_EW = 0; 
      #period // wait for period 
      Crosswalk_NS = 0; Crosswalk_EW = 1;
      #period // wait for period 
      #period
      #period
      #period
      #period // wait for period 
      #period
      #period
      #period
      #period // wait for period 
      #period
      #period
      #period
      #period // wait for period 
      #period
      #period
      #period

      Crosswalk_NS = 0; Crosswalk_EW = 1; 
      #period // wait for period 
      Crosswalk_NS = 0; Crosswalk_EW = 0;
      #period // wait for period 
      Crosswalk_NS = 0; Crosswalk_EW = 0;
      #period // wait for period 
//      Crosswalk_NS = 1; Crosswalk_EW = 1; Clk = 1;
//      #period // wait for period
//      Crosswalk_NS = 1; Crosswalk_EW = 1; Clk = 0;
//      #period // wait for period
      $stop;
  end

endmodule