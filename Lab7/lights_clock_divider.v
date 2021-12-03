`timescale 1ns / 1ps
//25 MHz

//module lights_clock_divider#(parameter div_value = 25000000) ( //slow speed is 25000000
module lights_clock_divider( //slow speed is 25000000
input wire clk,
input [15:0] div_value,
input light_enable,
output reg divided_clk = 0
);

integer counter_value = 0;
integer speed_value = 0;

always@ (posedge clk)
begin
    ////////////set light change speed value
    if(light_enable == 16'b0000000000000001) begin
        if(div_value < 16384) begin //slowest speed
            speed_value = 25000000;
        end
        else if(div_value < 32768) begin //middle speed
            speed_value = 12000000;
        end
        else begin //fastest speed
            speed_value = 6000000;
        end
    end

    ///////////////output clock based on div_value
    if (counter_value == speed_value)
        counter_value <= 0;
    else
        counter_value <= counter_value + 1;
end
    
always@ (posedge clk)
begin
    if (counter_value == speed_value)
        divided_clk <= ~divided_clk;
    else
        divided_clk <= divided_clk;    
end
endmodule
