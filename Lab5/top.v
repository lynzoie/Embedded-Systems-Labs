`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module top(
    input clk,
    input ScreenSelect,
    output Hsynq,
    output Vsynq,
    output [3:0] Red,
    output [3:0] Green,
    output [3:0] Blue
);

    wire clk_25M; //divided clock variable
    wire enable_V_Counter; //vertical enable variable
    wire [15:0] H_Count_Value; //horiztonal pixel count
    wire [15:0] V_Count_Value; //vertical pixel count
    //wire ScreenSelect_out;

    integer ScreenSelect_flag = 0;
    reg [3:0] Red_temp = 4'h0; //temporary red hex variable
    reg [3:0] Green_temp = 4'h0; //temporary green hex variable
    reg [3:0] Blue_temp = 4'h0; //temporary blue hex variable

    integer counter = 0; //for debouncing the button

    lab5_clock_divider VGA_Clock_gen (clk, clk_25M); //clock divider module
    horizontal_counter VGA_Horiz (clk_25M, enable_V_Counter, H_Count_Value); //hoirzontal (column index) pixel count module
    vertical_counter VGA_Verti (clk_25M, enable_V_Counter, V_Count_Value); //vertical (row index) pixel count module
    //debounce_better_version Lab5_main(ScreenSelect,clk,ScreenSelect_out);                 //debounce button (ScreenSelect)

    assign Hsynq = (H_Count_Value < 96) ? 1'b1:1'b0;
    assign Vsynq = (V_Count_Value < 2) ? 1'b1:1'b0;

    always @(*) begin
        if(ScreenSelect_flag == 0)begin //if button is NOT pressed (after debouncing)
            if(H_Count_Value > 143 && H_Count_Value < 784 && V_Count_Value > 35 && V_Count_Value < 515) begin //if within the screen bounds
                if(H_Count_Value > 143 && H_Count_Value < 143+(80*1)) begin //first strip (white)
                    Red_temp = 4'hF;
                    Green_temp = 4'hF;
                    Blue_temp = 4'hF;
                end
                if(H_Count_Value >= (143+(80*1)) && H_Count_Value < (143+(80*2))) begin //second stripe (cyan)
                    Red_temp = 4'h0;
                    Green_temp = 4'hF;
                    Blue_temp = 4'hF;
                end
                if(H_Count_Value >= (143+(80*2)) && H_Count_Value < (143+(80*3))) begin //third stripe (white)
                    Red_temp = 4'hF;
                    Green_temp = 4'hF;
                    Blue_temp = 4'hF;
                end
                if(H_Count_Value >= (143+(80*3)) && H_Count_Value < (143+(80*4))) begin //third stripe (cyan)
                    Red_temp = 4'h0;
                    Green_temp = 4'hF;
                    Blue_temp = 4'hF;
                end
                if(H_Count_Value >= (143+(80*4)) && H_Count_Value < (143+(80*5))) begin //fourth stripe (white)
                    Red_temp = 4'hF;
                    Green_temp = 4'hF;
                    Blue_temp = 4'hF;
                end
                if(H_Count_Value >= (143+(80*5)) && H_Count_Value < (143+(80*6))) begin //fifth stripe (cyan)
                    Red_temp = 4'h0;
                    Green_temp = 4'hF;
                    Blue_temp = 4'hF;
                end
                if(H_Count_Value >= (143+(80*6)) && H_Count_Value < (143+(80*7))) begin //sixth stripe (white)
                    Red_temp = 4'hF;
                    Green_temp = 4'hF;
                    Blue_temp = 4'hF;
                end
                if(H_Count_Value >= (143+(80*7)) && H_Count_Value < (143+(80*8))) begin //third stripe (cyan)
                    Red_temp = 4'h0;
                    Green_temp = 4'hF;
                    Blue_temp = 4'hF;
                end
            end
            else begin //if outside of the screen bounds
                Red_temp = 4'h0; //black pixels
                Green_temp = 4'h0; //black pixels
                Blue_temp = 4'h0; //black pixels
            end
        end

        else if(ScreenSelect_flag == 1) begin
            if(H_Count_Value > 143 && H_Count_Value < 784 && V_Count_Value > 35 && V_Count_Value < 515) begin //if within the screen bounds
            //Vertical Lines//////////////////////////////////////////////////////////
                if((H_Count_Value >= 315 && H_Count_Value <= 318) || (H_Count_Value >= 342 && H_Count_Value <= 345) || (H_Count_Value >= 360 && H_Count_Value <= 363) || (H_Count_Value >= 410 && H_Count_Value <= 413) || (H_Count_Value >= 452 && H_Count_Value <= 455) || (H_Count_Value >= 483 && H_Count_Value <= 486) || (H_Count_Value >= 510 && H_Count_Value <= 513)) begin
                    if(V_Count_Value >= 176 && V_Count_Value <= 367) begin
                        Red_temp = 4'h0;
                        Green_temp = 4'hF;
                        Blue_temp = 4'hF;
                    end
                    else begin //above and/or below letters
                        Red_temp = 4'h0;
                        Green_temp = 4'h0;
                        Blue_temp = 4'h0;
                    end
                end
                //Not in Vertical Lines//////////////////////////////////////////////// 
                //H
                else if((H_Count_Value >= 319 && H_Count_Value <= 341)) begin
                    if(V_Count_Value >= 259 && V_Count_Value <= 268) begin
                        Red_temp = 4'h0;
                        Green_temp = 4'hF;
                        Blue_temp = 4'hF;
                    end
                    else begin
                        Red_temp = 4'h0;
                        Green_temp = 4'h0;
                        Blue_temp = 4'h0;
                    end
                end
                //E
                else if ((H_Count_Value >= 364 && H_Count_Value <= 386)) begin
                    if((V_Count_Value >= 176 && V_Count_Value <= 184) || (V_Count_Value >= 260 && V_Count_Value <= 268) || (V_Count_Value >= 359 && V_Count_Value <= 367)) begin
                        Red_temp = 4'h0;
                        Green_temp = 4'hF;
                        Blue_temp = 4'hF;
                    end
                    else begin
                        Red_temp = 4'h0;
                        Green_temp = 4'h0;
                        Blue_temp = 4'h0;
                    end
                end
                //L
//                else if ((H_Count_Value >= 414 && H_Count_Value <= 436)) begin
//                    if((V_Count_Value >= 359 && V_Count_Value <= 367)) begin
//                        Red_temp = 4'h0;
//                        Green_temp = 4'hF;
//                        Blue_temp = 4'hF;
//                    end
//                    else begin
//                        Red_temp = 4'h0;
//                        Green_temp = 4'h0;
//                        Blue_temp = 4'h0;
//                    end
//                end
                //L
//                else if ((H_Count_Value >= 456 && H_Count_Value <= 478)) begin
//                    if((V_Count_Value >= 359 && V_Count_Value <= 367)) begin
//                        Red_temp = 4'h0;
//                        Green_temp = 4'hF;
//                        Blue_temp = 4'hF;
//                    end
//                    else begin
//                        Red_temp = 4'h0;
//                        Green_temp = 4'h0;
//                        Blue_temp = 4'h0;
//                    end
//                end
                //O
                else if(H_Count_Value >= 487 && H_Count_Value <= 509) begin
                    if((V_Count_Value >= 176 && V_Count_Value <= 184) || (V_Count_Value >= 359 && V_Count_Value <= 367)) begin
                        Red_temp = 4'h0;
                        Green_temp = 4'hF;
                        Blue_temp = 4'hF;
                    end
                    else begin
                        Red_temp = 4'h0;
                        Green_temp = 4'h0;
                        Blue_temp = 4'h0;
                    end
                end 
                //Debugging//////////////////////////////////////////////////////////// 
                else begin //if not in the letter columns
                    Red_temp = 4'h0;
                    Green_temp = 4'hF;
                    Blue_temp = 4'h0;
                end
            end
            else begin //for debugging, should never enter this
                Red_temp = 4'h0;
                Green_temp = 4'hF;
                Blue_temp = 4'h0;
            end
        end
    end
////////////////////////////////////////////////////
    always @(posedge clk) begin
        if (counter == 25) begin
            if(ScreenSelect == 0) begin
                ScreenSelect_flag = 0;
                counter = 0;
            end
            else begin
                ScreenSelect_flag = 1;
                counter = 0;
            end
        end
        counter = counter + 1;
        //    else if (counter == 10000) begin 
        //        ScreenSelect_flag = 1;
        //    end
        //    else if (counter == 20000) begin
        //        counter = 0;
        //    end
        //increment counter
    end

    assign Red = Red_temp; //assign red hex value
    assign Green = Green_temp; //assign green hex value
    assign Blue = Blue_temp; //assign blue hex value

endmodule
