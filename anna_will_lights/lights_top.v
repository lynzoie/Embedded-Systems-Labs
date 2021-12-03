`timescale 1ns / 1ps

module lights_top(
    input clk, //board clock
    input catch_switch, //switch to catch light
    input reset_button, //button to reset score
    output [3:0] Anode_Activate, //turn 7-seg on
    output [6:0] LED_out, //display digit on 7-seg
    output [15:0] lights //output lights to catch
);
wire lights_clk; //divided clock variable
integer light_select = 0; //select what light is on
integer direction_flag = 1; //start by going to the left
integer score = 0;
reg [15:0] light_enable; //output register for light assignment
integer score_trigger = 0; //Andi's variable for display

//if light is caught
always @(posedge(clk)) begin
    
    //check if light is caught, if caught only increase score for 1 clk cycle
    if (light_enable == 16'b0000000010000000) begin
        if((catch_switch == 1) && (score_trigger == 0)) begin //check if light is caught
            score = score + 25;
            score_trigger = 1;
        end
    end
    //if going to the left, at the next light, check if light was caught, if not then reset score
    else if(light_enable == 16'b0000000100000000) begin //going to left
        if ((direction_flag == 1) && (score_trigger == 0)) begin
            score = 0;
        end
    end
    //if going to the right, at the next light, check if light was caught, if not then reset score
    else if(light_enable == 16'b0000000001000000) begin //going to right
        if ((direction_flag == 0) && (score_trigger == 0)) begin
            score = 0;
        end
    end
    else score_trigger = 0;

    if (reset_button == 1) begin
        score = 0;
    end
    refresh_counter = refresh_counter + 1;      //increment counter
    if(refresh_counter == 5000)                 //at 500
        LED_activating_counter = 0;             //light onesDigit
    if(refresh_counter == 10000)                //at 1,000
        LED_activating_counter = 1;             //light twosDigit
    if(refresh_counter == 15000)                //at 1,500
        LED_activating_counter = 2;             //light threesDigit
    if(refresh_counter == 20000)                //at 20,000
        LED_activating_counter = 3;             //light foursDigit
    if(refresh_counter == 25000)                //at 25,000
        refresh_counter = 0;                    //start over at 0
end

lights_clock_divider (clk, lights_clk); //clock divider module (idk what VGA_Clock_gen is... oops)

always @(posedge lights_clk) begin
    if(direction_flag == 1) begin
        case(light_select)
            0: begin light_enable = 16'b0000000000000001; light_select = 1; end
            1: begin light_enable = 16'b0000000000000010; light_select = 2; end
            2: begin light_enable = 16'b0000000000000100; light_select = 3; end
            3: begin light_enable = 16'b0000000000001000; light_select = 4; end
            4: begin light_enable = 16'b0000000000010000; light_select = 5; end
            5: begin light_enable = 16'b0000000000100000; light_select = 6; end
            6: begin light_enable = 16'b0000000001000000; light_select = 7; end
            7: begin light_enable = 16'b0000000010000000; light_select = 8; end
            8: begin light_enable = 16'b0000000100000000; light_select = 9; end
            9: begin light_enable = 16'b0000001000000000; light_select = 10; end
            10: begin light_enable = 16'b0000010000000000; light_select = 11; end
            11: begin light_enable = 16'b0000100000000000; light_select = 12; end
            12: begin light_enable = 16'b0001000000000000; light_select = 13; end
            13: begin light_enable = 16'b0010000000000000; light_select = 14; end
            14: begin light_enable = 16'b0100000000000000; light_select = 15; end
//            15: begin light_enable = 16'b1000000000000000; light_select = 14; direction_flag = 2; end
            15: begin light_enable = 16'b1000000000000000; light_select = 14; direction_flag = 0; end
        endcase
    end
    else begin
        case(light_select)
            0: begin light_enable = 16'b0000000000000001; light_select = 1; direction_flag = 1; end
            1: begin light_enable = 16'b0000000000000010; light_select = 0; end
            2: begin light_enable = 16'b0000000000000100; light_select = 1; end
            3: begin light_enable = 16'b0000000000001000; light_select = 2; end
            4: begin light_enable = 16'b0000000000010000; light_select = 3; end
            5: begin light_enable = 16'b0000000000100000; light_select = 4; end
            6: begin light_enable = 16'b0000000001000000; light_select = 5; end
            7: begin light_enable = 16'b0000000010000000; light_select = 6; end
            8: begin light_enable = 16'b0000000100000000; light_select = 7; end
            9: begin light_enable = 16'b0000001000000000; light_select = 8; end
            10: begin light_enable = 16'b0000010000000000; light_select = 9; end
            11: begin light_enable = 16'b0000100000000000; light_select = 10; end
            12: begin light_enable = 16'b0001000000000000; light_select = 11; end
            13: begin light_enable = 16'b0010000000000000; light_select = 12; end
            14: begin light_enable = 16'b0100000000000000; light_select = 13; end
            //15: begin light_enable = 16'b1000000000000000; light_select = 14; direction_flag = 2; end
        endcase
    end
end
assign lights = light_enable;

///////////////////////////////////////////////////////////////////////////////////////////////
///// Display Score Code
//for 7-segment
    integer onesDigit = 0;
    integer twosDigit = 0;
    integer threesDigit = 0;
    integer foursDigit = 0;
    integer decimalValue = 0;
    integer count = 0;
    integer refresh_counter = 0;
    integer LED_activating_counter = 0;
    integer score_increase = 0;
    integer tempTensScore = 0;
    integer reset_flag = 0;
    reg [3:0] Anode_Activate_Var;
    reg [6:0] LED_out_Var = 7'b0000001;
    reg [3:0] LED_BCD;
    
    reg reset_score;
    reg change_score;

    ////////////////////////////Calculate Input score//////////////////
//always@(posedge(clk)) begin              //TODO: CHANGE scored_flag VARIABLE TO FLAG FROM GAME!!!
//    if (score_trigger == 1) begin
//        score = score + 25;                         // user scored 25 points
//    end
//    if (reset_button == 1) begin
//        score = 0;
//    end
//end

//always @(reset_button) begin                  // if reset score flag raised
//    if (reset_button == 1) begin
//        reset_flag = 1;
//    end
//    else begin
//        reset_flag = 0;
//    end
//end 

//always@(score_increase || reset_flag) begin
//    if (reset_flag == 1) begin
//        score = 0;
//    end
//    else begin
//        score = score + 25;
//    end
//end

    //////////////////Set score Display Variables/////////////////
always @(score) begin
    if(score < 100) begin //displays 0###
        foursDigit = 0;
        threesDigit = 0;
        
        case(score)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((score >= 100) && (score < 200)) begin //displays 1###
        foursDigit = 0;
        threesDigit = 1;
        tempTensScore = score - 100;
        case(tempTensScore)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((score >= 200) && (score < 300)) begin //displays 2###
        foursDigit = 0;
        threesDigit = 2;
        tempTensScore = score - 200;
        case(tempTensScore)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((score >= 300) && (score < 400)) begin //displays 3###
        foursDigit = 0;
        threesDigit = 3;
        tempTensScore = score - 300;
        case(tempTensScore)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((score >= 400) && (score < 500)) begin //displays 4###
        foursDigit = 0;
        threesDigit = 4;
        tempTensScore = score - 400;
        case(tempTensScore)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((score >= 50) && (score < 60)) begin //displays 5###
        foursDigit = 0;
        threesDigit = 5;
        tempTensScore = score - 500;
        case(tempTensScore)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((score >= 60) && (score < 70)) begin //displays 6###
        foursDigit = 0;
        threesDigit = 6;
        tempTensScore = score - 600;
        case(tempTensScore)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((score >= 700) && (score < 800)) begin //displays 7###
        foursDigit = 0;
        threesDigit = 7;
        tempTensScore = score - 700;
        case(tempTensScore)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((score >= 800) && (score < 900)) begin //displays 8###
        foursDigit = 0;
        threesDigit = 8;
        tempTensScore = score - 800;
        case(tempTensScore)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((score >= 900) && (score < 1000)) begin //displays 9###
        foursDigit = 0;
        threesDigit = 9;
        tempTensScore = score - 900;
        case(tempTensScore)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((score >= 1000) && (score < 1100)) begin //displays 9###
        foursDigit = 1;
        threesDigit = 0;
        tempTensScore = score - 1000;
        case(tempTensScore)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((score >= 1100) && (score < 1200)) begin //displays 9###
        foursDigit = 1;
        threesDigit = 1;
        tempTensScore = score - 1100;
        case(tempTensScore)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
end

////////////////////////////Select Lit 7-Seg//////////////////

//always @(posedge clk) begin //Activate one of four 7-seg displays
//        refresh_counter = refresh_counter + 1;      //increment counter
//        if(refresh_counter == 5000)                 //at 500
//            LED_activating_counter = 0;             //light onesDigit
//        if(refresh_counter == 10000)                //at 1,000
//            LED_activating_counter = 1;             //light twosDigit
//        if(refresh_counter == 15000)                //at 1,500
//            LED_activating_counter = 2;             //light threesDigit
//        if(refresh_counter == 20000)                //at 20,000
//            LED_activating_counter = 3;             //light foursDigit
//        if(refresh_counter == 25000)                //at 25,000
//            refresh_counter = 0;                    //start over at 0
//end

////////////////////////////Set Displayed Digit/////////////

always @(LED_activating_counter)                    //when 7-seg digit changes
    begin
        //LED_activating_counter = refresh_counter;
        case(LED_activating_counter)                    //activate the digit
            0: begin
                Anode_Activate_Var = 4'b0111;           //activate LED1 and Deactivate LED2, LED3, LED4
                LED_BCD = foursDigit;                   //the first digit of the 16-bit number
//                decimalValue = 1;                       //the decimal is off
            end
            1: begin
                Anode_Activate_Var = 4'b1011;           //activate LED2 and Deactivate LED1, LED3, LED4
                LED_BCD = threesDigit;                  //the second digit of the 16-bit number
//                decimalValue = 1;                       //decimal is off
            end
            2: begin
                Anode_Activate_Var = 4'b1101;           // activate LED3 and Deactivate LED2, LED1, LED4
                LED_BCD = twosDigit;                    // the third digit of the 16-bit number
//                decimalValue = 1;                       //decimal is off
            end
            3: begin
                Anode_Activate_Var = 4'b1110;           // activate LED4 and Deactivate LED2, LED3, LED1
                LED_BCD = onesDigit;                    // the fourth digit of the 16-bit number 
//                decimalValue = 1;                       //decimal is off
            end
        endcase
    end

////////////////////////////Display Digit//////////////////

always @(LED_BCD) begin
    case(LED_BCD)
        4'b0000: LED_out_Var = 7'b0000001; // "0"     
        4'b0001: LED_out_Var = 7'b1001111; // "1" 
        4'b0010: LED_out_Var = 7'b0010010; // "2" 
        4'b0011: LED_out_Var = 7'b0000110; // "3" 
        4'b0100: LED_out_Var = 7'b1001100; // "4" 
        4'b0101: LED_out_Var = 7'b0100100; // "5" 
        4'b0110: LED_out_Var = 7'b0100000; // "6" 
        4'b0111: LED_out_Var = 7'b0001111; // "7" 
        4'b1000: LED_out_Var = 7'b0000000; // "8"     
        4'b1001: LED_out_Var = 7'b0000100; // "9" 
        default: LED_out_Var = 7'b0000001; // "0"
    endcase
end

///////////////////////////Output Display///////////////////////////
assign Anode_Activate = Anode_Activate_Var;
assign LED_out = LED_out_Var;
//assign decimal = decimalValue;

endmodule

