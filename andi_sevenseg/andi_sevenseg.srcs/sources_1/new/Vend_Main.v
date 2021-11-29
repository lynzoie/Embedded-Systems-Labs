`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module Vend_Main(
    input Clk,
    input [1:0] scored_flag, // USER FLAG FROM GAME

    output [1:0] changeLED, //change dispensed
    output [3:0] Anode_Activate, //turn 7-seg on
    output [6:0] LED_out, //display digit on 7-seg
    output decimal //display decimal on 7-seg
    
    //output [11:0] foursOut //-> used for testing purposes only

);
    //track score
    integer score = 0;
    integer tempTensScore = 0;

    //for 7-segment
    integer onesDigit = 0;
    integer twosDigit = 0;
    integer threesDigit = 0;
    integer foursDigit = 0;
    integer decimalValue = 0;
    integer count = 0;
    integer refresh_counter = 0;
    integer LED_activating_counter = 0;
    reg [3:0] Anode_Activate_Var;
    reg [6:0] LED_out_Var;
    reg [3:0] LED_BCD;
    
    reg reset_score;
    reg change_score;

    ////////////////////////////Calculate Input score//////////////////
always@(posedge (scored_flag != 2'b00))              //TODO: CHANGE scored_flag VARIABLE TO FLAG FROM GAME!!!
    begin

    if(scored_flag == 2'b01) begin                   //TODO: MODIFY AS FLAG SHOULD BE
        score = score + 25;                         // user scored 25 points
    end
    else if(scored_flag == 2'b10) begin              // user scored 100 points
        score = score + 100;
    end
    if (scored_flag == 1'b11) begin                  // if reset score flag raised
        score = 0;
        reset_score = 1;
    end 
end


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

always @(posedge Clk) begin //Activate one of four 7-seg displays
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

////////////////////////////Set Displayed Digit/////////////

always @(LED_activating_counter)                    //when 7-seg digit changes
    begin
        //LED_activating_counter = refresh_counter;
        case(LED_activating_counter)                    //activate the digit
            0: begin
                Anode_Activate_Var = 4'b0111;           //activate LED1 and Deactivate LED2, LED3, LED4
                LED_BCD = foursDigit;                   //the first digit of the 16-bit number
                decimalValue = 1;                       //the decimal is off
            end
            1: begin
                Anode_Activate_Var = 4'b1011;           //activate LED2 and Deactivate LED1, LED3, LED4
                LED_BCD = threesDigit;                  //the second digit of the 16-bit number
                decimalValue = 1;                       //decimal is off
            end
            2: begin
                Anode_Activate_Var = 4'b1101;           // activate LED3 and Deactivate LED2, LED1, LED4
                LED_BCD = twosDigit;                    // the third digit of the 16-bit number
                decimalValue = 1;                       //decimal is off
            end
            3: begin
                Anode_Activate_Var = 4'b1110;           // activate LED4 and Deactivate LED2, LED3, LED1
                LED_BCD = onesDigit;                    // the fourth digit of the 16-bit number 
                decimalValue = 1;                       //decimal is off
            end
        endcase
    end

////////////////////////////Display Digit//////////////////

always @(LED_BCD)
    begin
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
assign decimal = decimalValue;
//assign foursOut = threesDigit; //-> used for testing purposes only

endmodule