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
    integer tempQuarters = 0;

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
    
    //dispense money
    reg [7:0] productDispensed;
    reg [7:0] productSelect;
    reg [1:0] alert_reg;
    reg [1:0] needMoney;

    //state machine
    reg [2:0] state = 3'b000;
    reg [2:0] cstate = 3'b000;
    reg [2:0] pstate = 3'b000;
    reg [2:0] nstate = 3'b000;
    reg [2:0] change_state = 3'b000;
    reg reset_money;
    reg change_money;

    ////////////////////////////Calculate Input Money//////////////////
always@(posedge (money_in != 4'b0000) || reset_money)              //when dollars, quarters, bearcat card are entered
    begin
    
    if(money_in == 4'b0001) begin                   //if quarter button pressed
        money = money + 25;
    end
    else if(money_in == 4'b0010) begin              //if dollar entered
        money = money + 100;
    end
    else if(money_in == 4'b0100) begin              //reset aka give change
        money = 0;
    end
    else if(money_in == 4'b1000) begin              //bearcat card entered (needs work)
        money = 0;
    end
    if (reset_money == 1'b1) begin
        money = 0;
    end 
end


    //////////////////Set Money Display Variables/////////////////
always @(money) begin
    if(money < 100) begin //displays 0#.##
        foursDigit = 0;
        threesDigit = 0;
        
        case(money)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((money >= 100) && (money < 200)) begin //displays 1#.##
        foursDigit = 0;
        threesDigit = 1;
        tempQuarters = money - 100;
        case(tempQuarters)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((money >= 200) && (money < 300)) begin //displays 2#.##
        foursDigit = 0;
        threesDigit = 2;
        tempQuarters = money - 200;
        case(tempQuarters)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((money >= 300) && (money < 400)) begin //displays 3#.##
        foursDigit = 0;
        threesDigit = 3;
        tempQuarters = money - 300;
        case(tempQuarters)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((money >= 400) && (money < 500)) begin //displays 4#.##
        foursDigit = 0;
        threesDigit = 4;
        tempQuarters = money - 400;
        case(tempQuarters)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((money >= 50) && (money < 60)) begin //displays 5#.##
        foursDigit = 0;
        threesDigit = 5;
        tempQuarters = money - 500;
        case(tempQuarters)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((money >= 60) && (money < 70)) begin //displays 6#.##
        foursDigit = 0;
        threesDigit = 6;
        tempQuarters = money - 600;
        case(tempQuarters)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((money >= 700) && (money < 800)) begin //displays 7#.##
        foursDigit = 0;
        threesDigit = 7;
        tempQuarters = money - 700;
        case(tempQuarters)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((money >= 800) && (money < 900)) begin //displays 8#.##
        foursDigit = 0;
        threesDigit = 8;
        tempQuarters = money - 800;
        case(tempQuarters)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((money >= 900) && (money < 1000)) begin //displays 9#.##
        foursDigit = 0;
        threesDigit = 9;
        tempQuarters = money - 900;
        case(tempQuarters)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((money >= 1000) && (money < 1100)) begin //displays 9#.##
        foursDigit = 1;
        threesDigit = 0;
        tempQuarters = money - 1000;
        case(tempQuarters)
            25: begin twosDigit = 2; onesDigit = 5; end
            50: begin twosDigit = 5; onesDigit = 0; end
            75: begin twosDigit = 7; onesDigit = 5; end
            00: begin twosDigit = 0; onesDigit = 0; end
        endcase
    end
    else if((money >= 1100) && (money < 1200)) begin //displays 9#.##
        foursDigit = 1;
        threesDigit = 1;
        tempQuarters = money - 1100;
        case(tempQuarters)
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


/////////////////////////Dispense Product////////////////////////
always @(posedge Clk) begin
        reset_money = 1'b0;
        alert_reg = 2'b00;
        productSelect = product_in;         //record product selection
        cstate = dispense;                  //check enable
        case(state)                         //move to state
            3'b000: begin                   // State 0: check product price
            reset_money = 1'b0;
            alert_reg = 2'b00;
            productDispensed = 8'b00000000; 
                
                if((productSelect == 8'b00000001) || (productSelect == 8'b00000010)) begin
                    nstate = 3'b001;             //$0.50 state
                end
                else if((productSelect == 8'b00000100) || (productSelect == 8'b00001000)) begin
                    nstate = 3'b010;             //$0.75 state
                end
                else if((productSelect == 8'b00010000) || (productSelect == 8'b00100000) || (productSelect == 8'b01000000) || (productSelect == 8'b10000000)) begin
                    nstate = 3'b011;             //$1.25 state
                end
                else begin
                    nstate = 3'b000;             //stay put
                end
                if(cstate == 3'b001) begin       //if ready to switch states
                    state = nstate;              //do itttttt :)
                end
            end

            3'b001: begin                        //state 1, $0.50
                alert_reg = 2'b00;
                if (money >= 50) begin //$0.50
                    state = 3'b100;
                    reset_money = 1'b1;
                    alert_reg = 2'b00;
                    if (productSelect == 8'b00000001)
                        productDispensed = 8'b00000001;

                    if (productSelect == 8'b00000010)
                        productDispensed = 8'b00000010;
                end
                else begin 
                    state = 3'b001;
                        alert_reg = 2'b01;
                end
            end

            3'b010: begin // State 2
                alert_reg = 2'b00;
                if (money >= 75) begin //$0.75
                    state = 3'b100;
                    reset_money = 1'b1;
                    alert_reg = 2'b00;
                    if (productSelect == 8'b00000100)
                        productDispensed = 8'b00000100;

                    if (productSelect == 8'b00001000)
                        productDispensed = 8'b00001000;
                end
                else begin
                state = 3'b010;
                alert_reg = 2'b01;
                end
            end

            3'b011: begin // State 3
                alert_reg = 2'b00;
                if (money >= 125) begin //$1.25
                    state = 3'b100;
                    reset_money = 1'b1;
                    alert_reg = 2'b00;
                    if (productSelect == 8'b00010000)
                        productDispensed = 8'b00010000;

                    if (productSelect == 8'b00100000)
                        productDispensed = 8'b00100000;

                    if (productSelect == 8'b01000000)
                        productDispensed = 8'b01000000;

                    if (productSelect == 8'b10000000)
                        productDispensed = 8'b10000000;
                end
                else begin
                state = 3'b011;
                alert_reg = 2'b01;
                end 
            end
            3'b100: begin //State 4, prevent ghosting and reset money spent      
                if(cstate == 1) begin       //if enable switch is still up
                    state = 3'b100;              //stay here
                    reset_money = 1'b1;
                end
                else 
                    state = 3'b000;             //if enable switch is off, restart
                    reset_money = 1'b0;
                end
        endcase
    end

assign product_out = productDispensed;
assign alert = alert_reg;


endmodule