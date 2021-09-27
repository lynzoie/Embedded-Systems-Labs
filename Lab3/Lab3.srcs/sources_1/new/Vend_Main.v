`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module Vend_Main(
    input Clk,
    input [3:0] money_in, //dollars, quarters, and bearcat card
    input [7:0] product_in, //product selection
    input dispense, //switch to enable dispense


    output [7:0] product_out, //product dispensed
    output [1:0] changeLED, //change dispensed
    output [1:0] alert, //not enough money or out of stock
    output [3:0] Anode_Activate, //turn 7-seg on
    output [6:0] LED_out, //display digit on 7-seg
    output decimal //display decimal on 7-seg

);
    //track money
    integer money = 0;
    integer quartersValue = 0;
    integer dollarsValue = 0;
    integer quartersCurrent = 0;
    integer dollarsCurrent = 0;
    integer quartersSpent = 0;
    integer dollarsSpent = 0;

    //for 7-segment
    integer onesDigit = 0;
    integer twosDigit = 0;
    integer threesDigit = 0;
    integer foursDigit = 0;
    integer decimalValue = 0;
    integer count = 0;
    integer seg7_count = 0;
    integer refresh_counter = 0;
    integer LED_activating_counter = 0;
    reg [3:0] Anode_Activate_Var;
    reg [6:0] LED_out_Var;
    reg [3:0] LED_BCD;
    
    //dispense money
    reg [7:0] productDispensed;
    reg [7:0] productSelect;
    reg [1:0] breadcrumb;
    reg [1:0] needMoney;

    //state machine
    reg state = 0;
    reg cstate = 0;
    reg pstate = 0;
    reg nstate = 0;
    reg change_state = 0;
    
    ////////////////////////////Calculate Input Money//////////////////
always@(posedge (money_in != 4'b0000))              //when dollars, quarters, bearcat card are entered
    begin

    //seg7_count = 0; //for button debouncing

    if(money_in == 4'b0001) begin                   //if quarter button pressed
        quartersValue = quartersValue + 1;          //add 1 to quarterValue
        if (quartersValue == 4) begin               //if 4 quarters entered
            dollarsValue = dollarsValue + 1;        //convert to dollar
            quartersValue = 0;                      //reset quarters
        end
    end
    else if(money_in == 4'b0010) begin              //if dollar entered
        dollarsValue = dollarsValue + 1;            //add 1 to dollarValue
    end
    else if(money_in == 4'b0100) begin              //reset aka give change
        dollarsValue = 0;
        quartersValue = 0;
    end
    else if(money_in == 4'b1000) begin              //bearcat card entered (needs work)
        dollarsValue = 0;
        quartersValue = 0;
    end

    /* while (seg7_count < 500) begin                  //for button debouncing
            seg7_count = seg7_count + 1;
        end */

end
    //end

    //////////////////Calculate Spent Money/////////////////
always@((dollarsSpent) or (quartersSpent) or (dollarsValue) or (quartersValue)) begin
    //If money is either entered or spent
    dollarsCurrent = dollarsValue; //move money input into current
    quartersCurrent = quartersValue; //move mpmey input into current

    if((quartersSpent != 0) || (dollarsSpent != 0)) begin //if money was spent
        if (quartersCurrent < quartersSpent) begin //not enough quarters
            dollarsCurrent <= dollarsCurrent - 1; //change for a dollar
            quartersCurrent <= quartersCurrent + 4; //new change
            quartersCurrent <= quartersCurrent - quartersSpent; //new amount
        end
        if (quartersCurrent >= quartersSpent) begin //if you entered enough quarters
            quartersCurrent <= quartersCurrent - quartersSpent; //subtract quarters spent
        end
        if (dollarsCurrent >= dollarsSpent) begin //if enough dollars entered
            dollarsCurrent <= dollarsCurrent - dollarsSpent; //subrtact quarters spent
        end
    end
end

    //////////////////Set Dollar Display Variables/////////////////
always @((dollarsCurrent) or (dollarsValue)) begin
    if(dollarsCurrent < 10) begin //displays 0#.##
        foursDigit = 0;
        threesDigit = dollarsCurrent;
    end
    else if((dollarsCurrent >= 10) && (dollarsCurrent < 20)) begin //displays 1#.##
        foursDigit = 1;
        threesDigit = dollarsCurrent - 10;
    end
    else if((dollarsCurrent >= 20) && (dollarsCurrent < 30)) begin //displays 2#.##
        foursDigit = 2;
        threesDigit = dollarsCurrent - 20;
    end
    else if((dollarsCurrent >= 30) && (dollarsCurrent < 40)) begin //displays 3#.##
        foursDigit = 3;
        threesDigit = dollarsCurrent - 30;
    end
    else if((dollarsCurrent >= 40) && (dollarsCurrent < 50)) begin //displays 4#.##
        foursDigit = 4;
        threesDigit = dollarsCurrent - 40;
    end
    else if((dollarsCurrent >= 50) && (dollarsCurrent < 60)) begin //displays 5#.##
        foursDigit = 5;
        threesDigit = dollarsCurrent - 50;
    end
    else if((dollarsCurrent >= 60) && (dollarsCurrent < 70)) begin //displays 6#.##
        foursDigit = 6;
        threesDigit = dollarsCurrent - 60;
    end
    else if((dollarsCurrent >= 70) && (dollarsCurrent < 80)) begin //displays 7#.##
        foursDigit = 7;
        threesDigit = dollarsCurrent - 70;
    end
    else if((dollarsCurrent >= 80) && (dollarsCurrent < 90)) begin //displays 8#.##
        foursDigit = 8;
        threesDigit = dollarsCurrent - 80;
    end
    else if((dollarsCurrent >= 90) && (dollarsCurrent < 100)) begin //displays 9#.##
        foursDigit = 9;
        threesDigit = dollarsCurrent - 90;
    end
end
        
    //////////////////Set Quarters Display Variables/////////////////
always @((quartersCurrent) or (quartersValue)) begin
    case(quartersCurrent)
        0: begin //0 cents
            onesDigit = 0;
            twosDigit = 0; end
        1: begin //25 cents
            onesDigit = 5;
            twosDigit = 2; end
        2: begin //50 cents
            onesDigit = 0;
            twosDigit = 5; end
        3: begin //75 cents
            onesDigit = 5;
            twosDigit = 7; end
        default: begin //0 cents
            onesDigit = 0;
            twosDigit = 0; end
    endcase
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
                decimalValue = 0;                       //decimal is on*
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

//////////////////Monitors Current State and Debounce//////////////
always@(posedge Clk) begin                  //at clock (synched with state machine)
        cstate = dispense;                  //current state is switch input
        /*if(cstate == 0) begin
            state = 0;                      //restart
            nstate = 0;                     //restart
        end
        else if (cstate == pstate) begin    //check if current state and past statement are the same
            change_state = 0;               //do not change states
        end
        else begin                          //if they are not the same
            change_state = 1;               //do not change states
        end
        pstate = cstate;*/                    //past state is current state
    end

/////////////////////////Dispense Product////////////////////////
always @(posedge Clk) begin
        productSelect = product_in;         //record product selection
        case(state)                         //move to state
            0: begin                        // State 0: check product price
                quartersSpent = 0;          //reset money spent
                dollarsSpent = 0;           //reset money spent
                
                breadcrumb = 2'b01;
                
                if((productSelect == 8'b00000001) || (productSelect == 8'b00000010)) begin
                    nstate = 1;             //$0.50 state
                end
                else if((productSelect == 8'b00000100) || (productSelect == 8'b00001000)) begin
                    nstate = 2;             //$0.75 state
                end
                else if((productSelect == 8'b00010000) || (productSelect == 8'b00100000) || (productSelect == 8'b01000000) || (productSelect == 8'b10000000)) begin
                    nstate = 3;             //$1.25 state
                end
                else begin
                    nstate = 0;             //stay put
                end
                if(cstate == 1) begin       //if ready to switch states
                    state = nstate;         //do itttttt :)
                end
            end

            1: begin                        //state 1, $0.50
                //breadcrumb = 2'b10;

                if ((quartersValue >= 2) || (dollarsValue >= 1)) begin //$0.50
                    quartersSpent = 2;      //amount we will subtract
                    state = 0;
                    if (productSelect == 8'b00000001)
                        productDispensed = 8'b00000001;

                    if (productSelect == 8'b00000010)
                        productDispensed = 8'b00000010;
                end
                else begin 
                    state = 1;
                    //alert need more money
                end
                /*if(change_state == 1) begin //if ready to switch states
                    state = nstate;         //do itttttt :)
                end*/
            end

            2: begin // State 2
                if ((quartersValue >= 3) || (dollarsValue >= 1)) begin //$0.75
                    quartersSpent = 3;
                    state = 0;
                    if (productSelect == 8'b00000100)
                        productDispensed = 8'b00000100;

                    if (productSelect == 8'b00001000)
                        productDispensed = 8'b00001000;
                end
                else state = 2;
            end

            3: begin // State 3
                if ((dollarsValue >= 1) && (quartersValue >= 1)) begin //$1.25
                    quartersSpent = 1;
                    dollarsSpent = 1;
                    state = 0;
                    if (productSelect == 8'b00010000)
                        productDispensed = 8'b00010000;

                    if (productSelect == 8'b00100000)
                        productDispensed = 8'b00100000;

                    if (productSelect == 8'b01000000)
                        productDispensed = 8'b01000000;

                    if (productSelect == 8'b10000000)
                        productDispensed = 8'b10000000;
                end
                else state = 3;
            end
        endcase
    end

assign product_out = productDispensed;
assign alert = breadcrumb;


endmodule