`timescale 1ns / 1ps

module change_light_speed(
    input CLK100MHZ,
    input vauxp6,
    input vauxn6,
    input vauxp7,
    input vauxn7,
    input vauxp15,
    input vauxn15,
    input vauxp14,
    input vauxn14,
    input vp_in,
    input vn_in,
//    input [1:0] sw,
    output reg [15:0] led,
    output [15:0] data_out // don't run Implementation since there's no ports in constraint for data_out
//    output [3:0] an,
//    output dp,
//    output [6:0] seg    
    );
    
    wire enable;  
    wire ready;
    wire [15:0] data;   

    
    xadc_wiz_0  XLXI_7 (
    .daddr_in(8'h16),       // address of Channel 1 ADC
    .dclk_in(CLK100MHZ), 
    .den_in(enable), 
    .di_in(0), 
    .dwe_in(0), 
    .busy_out(),                    
    .vauxp6(vauxp6),
    .vauxn6(vauxn6),
    .vauxp7(vauxp7),
    .vauxn7(vauxn7),
    .vauxp14(vauxp14),
    .vauxn14(vauxn14),
    .vauxp15(vauxp15),
    .vauxn15(vauxn15),
    .vn_in(vn_in), 
    .vp_in(vp_in), 
    .alarm_out(), 
    .do_out(data),          // output data is 16-bits, voltage needs to be between 0-1V 
    //.reset_in(),
    .eoc_out(enable),
    .channel_out(),
    .drdy_out(ready)
    );

    always @(posedge(CLK100MHZ)) begin  // test for ADC value with onboard LEDs    
        if(ready == 1'b1) begin
            case (data[15:12])
            1:  led <= 16'b11;
            2:  led <= 16'b111;
            3:  led <= 16'b1111;
            4:  led <= 16'b11111;
            5:  led <= 16'b111111;
            6:  led <= 16'b1111111; 
            7:  led <= 16'b11111111;
            8:  led <= 16'b111111111;
            9:  led <= 16'b1111111111;
            10: led <= 16'b11111111111;
            11: led <= 16'b111111111111;
            12: led <= 16'b1111111111111;
            13: led <= 16'b11111111111111;
            14: led <= 16'b111111111111111;
            15: led <= 16'b1111111111111111;                        
            default: led <= 16'b1; 
            endcase
        end
    end
    
endmodule
