## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
#Bank = 34, Pin name = ,					Sch name = CLK100MHZ
set_property PACKAGE_PIN W5 [get_ports Clk]
set_property IOSTANDARD LVCMOS33 [get_ports Clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports Clk]

# Switches
set_property PACKAGE_PIN V17 [get_ports product_in[0]]  
set_property IOSTANDARD LVCMOS33 [get_ports product_in[0]]  
set_property PACKAGE_PIN V16 [get_ports product_in[1]] 
set_property IOSTANDARD LVCMOS33 [get_ports product_in[1]]
set_property PACKAGE_PIN W16 [get_ports product_in[2]]     
set_property IOSTANDARD LVCMOS33 [get_ports product_in[2]]
set_property PACKAGE_PIN W17 [get_ports {product_in[3]}]     
set_property IOSTANDARD LVCMOS33 [get_ports {product_in[3]}]
set_property PACKAGE_PIN W15 [get_ports {product_in[4]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {product_in[4]}]
set_property PACKAGE_PIN V15 [get_ports {product_in[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {product_in[5]}]
set_property PACKAGE_PIN W14 [get_ports {product_in[6]}]   
set_property IOSTANDARD LVCMOS33 [get_ports {product_in[6]}]
set_property PACKAGE_PIN W13 [get_ports {product_in[7]}]    
set_property IOSTANDARD LVCMOS33 [get_ports {product_in[7]}]
#set_property PACKAGE_PIN V2 [get_ports {SW[8]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SW[8]}]
#set_property PACKAGE_PIN T3 [get_ports {SW[9]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SW[9]}]
#set_property PACKAGE_PIN T2 [get_ports {SW[10]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SW[10]}]
#set_property PACKAGE_PIN R3 [get_ports {SW[11]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SW[11]}]
#set_property PACKAGE_PIN W2 [get_ports {SW[12]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SW[12]}]
#set_property PACKAGE_PIN U1 [get_ports {SW[13]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SW[13]}]
#set_property PACKAGE_PIN T1 [get_ports {SW[14]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SW[14]}]
set_property PACKAGE_PIN R2 [get_ports {dispense}]
set_property IOSTANDARD LVCMOS33 [get_ports {dispense}]


## LEDs
set_property PACKAGE_PIN U16 [get_ports product_out[0]]
set_property IOSTANDARD LVCMOS33 [get_ports product_out[0]]
set_property PACKAGE_PIN E19 [get_ports product_out[1]]
set_property IOSTANDARD LVCMOS33 [get_ports product_out[1]]
set_property PACKAGE_PIN U19 [get_ports product_out[2]]
set_property IOSTANDARD LVCMOS33 [get_ports product_out[2]]
set_property PACKAGE_PIN V19 [get_ports {product_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {product_out[3]}]
set_property PACKAGE_PIN W18 [get_ports {product_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {product_out[4]}]
set_property PACKAGE_PIN U15 [get_ports {product_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {product_out[5]}]
set_property PACKAGE_PIN U14 [get_ports {product_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {product_out[6]}]
set_property PACKAGE_PIN V14 [get_ports {product_out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {product_out[7]}]
#set_property PACKAGE_PIN V13 [get_ports {LED[8]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {LED[8]}]
#set_property PACKAGE_PIN V3 [get_ports {LED[9]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {LED[9]}]
set_property PACKAGE_PIN W3 [get_ports {alert[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {alert[0]}]
set_property PACKAGE_PIN U3 [get_ports {alert[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {alert[1]}]
#set_property PACKAGE_PIN P3 [get_ports {LED[12]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {LED[12]}]
#set_property PACKAGE_PIN N3 [get_ports {LED[13]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {LED[13]}]
set_property PACKAGE_PIN P1 [get_ports {changeLED[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {changeLED[0]}]
set_property PACKAGE_PIN L1 [get_ports {changeLED[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {changeLED[1]}]


##7 segment display
##Bank = 34, Pin name = ,						Sch name = CA
set_property PACKAGE_PIN W7 [get_ports {LED_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[6]}]
##Bank = 34, Pin name = ,					Sch name = CB
set_property PACKAGE_PIN W6 [get_ports {LED_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[5]}]
##Bank = 34, Pin name = ,					Sch name = CC
set_property PACKAGE_PIN U8 [get_ports {LED_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[4]}]
##Bank = 34, Pin name = ,						Sch name = CD
set_property PACKAGE_PIN V8 [get_ports {LED_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[3]}]
##Bank = 34, Pin name = ,						Sch name = CE
set_property PACKAGE_PIN U5 [get_ports {LED_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[2]}]
##Bank = 34, Pin name = ,						Sch name = CF
set_property PACKAGE_PIN V5 [get_ports {LED_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[1]}]
##Bank = 34, Pin name = ,						Sch name = CG
set_property PACKAGE_PIN U7 [get_ports {LED_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[0]}]

##Bank = 34, Pin name = ,						Sch name = DP
set_property PACKAGE_PIN V7 [get_ports {decimal}]
set_property IOSTANDARD LVCMOS33 [get_ports {decimal}]

##Bank = 34, Pin name = ,						Sch name = AN0
set_property PACKAGE_PIN U2 [get_ports {Anode_Activate[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate[0]}]
##Bank = 34, Pin name = ,						Sch name = AN1
set_property PACKAGE_PIN U4 [get_ports {Anode_Activate[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate[1]}]
##Bank = 34, Pin name = ,						Sch name = AN2
set_property PACKAGE_PIN V4 [get_ports {Anode_Activate[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate[2]}]
##Bank = 34, Pin name = ,					Sch name = AN3
set_property PACKAGE_PIN W4 [get_ports {Anode_Activate[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate[3]}]


##Buttons
##Bank = 14, Pin name = ,					Sch name = BTNC
set_property PACKAGE_PIN U18 [get_ports {money_in[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {money_in[1]}]
##Bank = 14, Pin name = ,					Sch name = BTNU
set_property PACKAGE_PIN T18 [get_ports {money_in[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {money_in[3]}]
##Bank = 14, Pin name = ,	Sch name = BTNL
set_property PACKAGE_PIN W19 [get_ports {money_in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {money_in[0]}]
##Bank = 14, Pin name = ,							Sch name = BTNR
set_property PACKAGE_PIN T17 [get_ports {money_in[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {money_in[2]}]
##Bank = 14, Pin name = ,					Sch name = BTND
#set_property PACKAGE_PIN U17 [get_ports {dispense}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dispense}]



##Pmod Header JA
##Bank = 15, Pin name = IO_L1N_T0_AD0N_15,					Sch name = JA1
#set_property PACKAGE_PIN B13 [get_ports Out_South_Turn]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_South_Turn]
##Bank = 15, Pin name = IO_L5N_T0_AD9N_15,					Sch name = JA2
#set_property PACKAGE_PIN F14 [get_ports {JA[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JA[1]}]
##Bank = 15, Pin name = IO_L16N_T2_A27_15,					Sch name = JA3
#set_property PACKAGE_PIN D17 [get_ports {JA[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JA[2]}]
##Bank = 15, Pin name = IO_L16P_T2_A28_15,					Sch name = JA4
#set_property PACKAGE_PIN E17 [get_ports {JA[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JA[3]}]
##Bank = 15, Pin name = IO_0_15,								Sch name = JA7
#set_property PACKAGE_PIN G13 [get_ports {JA[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JA[4]}]
##Bank = 15, Pin name = IO_L20N_T3_A19_15,					Sch name = JA8
#set_property PACKAGE_PIN C17 [get_ports {JA[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JA[5]}]
##Bank = 15, Pin name = IO_L21N_T3_A17_15,					Sch name = JA9
#set_property PACKAGE_PIN D18 [get_ports {JA[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JA[6]}]
##Bank = 15, Pin name = IO_L21P_T3_DQS_15,					Sch name = JA10
#set_property PACKAGE_PIN E18 [get_ports {JA[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JA[7]}]



##Pmod Header JB
#Bank = 15, Pin name = IO_L15N_T2_DQS_ADV_B_15,				Sch name = JB1
#set_property PACKAGE_PIN A14 [get_ports Out_East[0]]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_East[0]]
#Bank = 14, Pin name = IO_L13P_T2_MRCC_14,					Sch name = JB2
#set_property PACKAGE_PIN A16 [get_ports Out_East[1]]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_East[1]]
#Bank = 14, Pin name = IO_L21N_T3_DQS_A06_D22_14,			Sch name = JB3
#set_property PACKAGE_PIN B15 [get_ports Out_East[2]]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_East[2]]
#Bank = CONFIG, Pin name = IO_L16P_T2_CSI_B_14,				Sch name = JB4
#set_property PACKAGE_PIN B16 [get_ports Out_West[0]]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_West[0]]
#Bank = 15, Pin name = IO_25_15,							Sch name = JB7
#set_property PACKAGE_PIN A15 [get_ports Out_West[1]]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_West[1]]
#Bank = CONFIG, Pin name = IO_L15P_T2_DQS_RWR_B_14,			Sch name = JB8
#set_property PACKAGE_PIN A17 [get_ports Out_West[2]]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_West[2]]
#Bank = 14, Pin name = IO_L24P_T3_A01_D17_14,				Sch name = JB9
#set_property PACKAGE_PIN C15 [get_ports Out_North[0]]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_North[0]]
#Bank = 14, Pin name = IO_L19N_T3_A09_D25_VREF_14,			Sch name = JB10
#set_property PACKAGE_PIN C16 [get_ports Out_North[1]]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_North[1]]



##Pmod Header JC
#Bank = 35, Pin name = IO_L23P_T3_35,						Sch name = JC1
#set_property PACKAGE_PIN K17 [get_ports Out_North[2]]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_North[2]]
#Bank = 35, Pin name = IO_L6P_T0_35,						Sch name = JC2
#set_property PACKAGE_PIN M18 [get_ports Out_South[0]]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_South[0]]
#Bank = 35, Pin name = IO_L22P_T3_35,						Sch name = JC3
#set_property PACKAGE_PIN N17 [get_ports Out_South[1]]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_South[1]]
#Bank = 35, Pin name = IO_L21P_T3_DQS_35,					Sch name = JC4
#set_property PACKAGE_PIN P18 [get_ports Out_South[2]]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_South[2]]
#Bank = 35, Pin name = IO_L23N_T3_35,						Sch name = JC7
#set_property PACKAGE_PIN L17 [get_ports Crosswalk_Light[0]]
#set_property IOSTANDARD LVCMOS33 [get_ports Crosswalk_Light[0]]
#Bank = 35, Pin name = IO_L5P_T0_AD13P_35,					Sch name = JC8
#set_property PACKAGE_PIN M19 [get_ports Crosswalk_Light[1]]
#set_property IOSTANDARD LVCMOS33 [get_ports Crosswalk_Light[1]]
#Bank = 35, Pin name = IO_L22N_T3_35,						Sch name = JC9
#set_property PACKAGE_PIN P17 [get_ports Out_North_Turn]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_North_Turn]
#Bank = 35, Pin name = IO_L19P_T3_35,						Sch name = JC10
#set_property PACKAGE_PIN R18 [get_ports Out_South_Turn]
#set_property IOSTANDARD LVCMOS33 [get_ports Out_South_Turn]


##Pmod Header JXADC
##Bank = 15, Pin name = IO_L9P_T1_DQS_AD3P_15,				Sch name = XADC1_P -> XA1_P
#set_property PACKAGE_PIN A13 [get_ports {JXADC[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[0]}]
##Bank = 15, Pin name = IO_L8P_T1_AD10P_15,					Sch name = XADC2_P -> XA2_P
#set_property PACKAGE_PIN A15 [get_ports {JXADC[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[1]}]
##Bank = 15, Pin name = IO_L7P_T1_AD2P_15,					Sch name = XADC3_P -> XA3_P
#set_property PACKAGE_PIN B16 [get_ports {JXADC[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[2]}]
##Bank = 15, Pin name = IO_L10P_T1_AD11P_15,					Sch name = XADC4_P -> XA4_P
#set_property PACKAGE_PIN B18 [get_ports {JXADC[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[3]}]
##Bank = 15, Pin name = IO_L9N_T1_DQS_AD3N_15,				Sch name = XADC1_N -> XA1_N
#set_property PACKAGE_PIN A14 [get_ports {JXADC[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[4]}]
##Bank = 15, Pin name = IO_L8N_T1_AD10N_15,					Sch name = XADC2_N -> XA2_N
#set_property PACKAGE_PIN A16 [get_ports {JXADC[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[5]}]
##Bank = 15, Pin name = IO_L7N_T1_AD2N_15,					Sch name = XADC3_N -> XA3_N
#set_property PACKAGE_PIN B17 [get_ports {JXADC[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[6]}]
##Bank = 15, Pin name = IO_L10N_T1_AD11N_15,					Sch name = XADC4_N -> XA4_N
#set_property PACKAGE_PIN A18 [get_ports {JXADC[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[7]}]



#VGA Connector
#Bank = 14, Pin name = ,					Sch name = VGA_R0
#set_property PACKAGE_PIN G19 [get_ports {VGA_RED[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {VGA_RED[0]}]
##Bank = 14, Pin name = ,					Sch name = VGA_R1
#set_property PACKAGE_PIN H19 [get_ports {VGA_RED[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {VGA_RED[1]}]
##Bank = 14, Pin name = ,					Sch name = VGA_R2
#set_property PACKAGE_PIN J19 [get_ports {VGA_RED[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {VGA_RED[2]}]
##Bank = 14, Pin name = ,					Sch name = VGA_R3
#set_property PACKAGE_PIN N19 [get_ports {VGA_RED[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {VGA_RED[3]}]
##Bank = 14, Pin name = ,					Sch name = VGA_B0
#set_property PACKAGE_PIN N18 [get_ports {VGA_BLUE[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {VGA_BLUE[0]}]
##Bank = 14, Pin name = ,						Sch name = VGA_B1
#set_property PACKAGE_PIN L18 [get_ports {VGA_BLUE[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {VGA_BLUE[1]}]
##Bank = 14, Pin name = ,					Sch name = VGA_B2
#set_property PACKAGE_PIN K18 [get_ports {VGA_BLUE[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {VGA_BLUE[2]}]
##Bank = 14, Pin name = ,						Sch name = VGA_B3
#set_property PACKAGE_PIN J18 [get_ports {VGA_BLUE[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {VGA_BLUE[3]}]
##Bank = 14, Pin name = ,					Sch name = VGA_G0
#set_property PACKAGE_PIN J17 [get_ports {VGA_GREEN[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {VGA_GREEN[0]}]
##Bank = 14, Pin name = ,				Sch name = VGA_G1
#set_property PACKAGE_PIN H17 [get_ports {VGA_GREEN[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {VGA_GREEN[1]}]
##Bank = 14, Pin name = ,					Sch name = VGA_G2
#set_property PACKAGE_PIN G17 [get_ports {VGA_GREEN[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {VGA_GREEN[2]}]
##Bank = 14, Pin name = ,				Sch name = VGA_G3
#set_property PACKAGE_PIN D17 [get_ports {VGA_GREEN[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {VGA_GREEN[3]}]
##Bank = 14, Pin name = ,						Sch name = VGA_HS
#set_property PACKAGE_PIN P19 [get_ports VGA_HS]
#set_property IOSTANDARD LVCMOS33 [get_ports VGA_HS]
##Bank = 14, Pin name = ,				Sch name = VGA_VS
#set_property PACKAGE_PIN R19 [get_ports VGA_VS]
#set_property IOSTANDARD LVCMOS33 [get_ports VGA_VS]


###USB-RS232 Interface
###Bank = 16, Pin name = ,					Sch name = UART_TXD_IN
##set_property PACKAGE_PIN B18 [get_ports RsRx]
##set_property IOSTANDARD LVCMOS33 [get_ports RsRx]
##Bank = 16, Pin name = ,					Sch name = UART_RXD_OUT
#set_property PACKAGE_PIN A18 [get_ports UART_TXD]
#set_property IOSTANDARD LVCMOS33 [get_ports UART_TXD]



##USB HID (PS/2)
##Bank = 16, Pin name = ,					Sch name = PS2_CLK
#set_property PACKAGE_PIN C17 [get_ports PS2_CLK]
#set_property IOSTANDARD LVCMOS33 [get_ports PS2_CLK]
#set_property PULLUP true [get_ports PS2_CLK]
##Bank = 16, Pin name = ,					Sch name = PS2_DATA
#set_property PACKAGE_PIN B17 [get_ports PS2_DATA]
#set_property IOSTANDARD LVCMOS33 [get_ports PS2_DATA]
#set_property PULLUP true [get_ports PS2_DATA]



##Quad SPI Flash
##Bank = CONFIG, Pin name = CCLK_0,							Sch name = QSPI_SCK
#set_property PACKAGE_PIN C11 [get_ports {QspiSCK}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiSCK}]
##Bank = CONFIG, Pin name = IO_L1P_T0_D00_MOSI_14,			Sch name = QSPI_DQ0
#set_property PACKAGE_PIN D18 [get_ports {QspiDB[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[0]}]
##Bank = CONFIG, Pin name = IO_L1N_T0_D01_DIN_14,			Sch name = QSPI_DQ1
#set_property PACKAGE_PIN D19 [get_ports {QspiDB[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[1]}]
##Bank = CONFIG, Pin name = IO_L20_T0_D02_14,				Sch name = QSPI_DQ2
#set_property PACKAGE_PIN G18 [get_ports {QspiDB[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[2]}]
##Bank = CONFIG, Pin name = IO_L2P_T0_D03_14,				Sch name = QSPI_DQ3
#set_property PACKAGE_PIN F18 [get_ports {QspiDB[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[3]}]
##Bank = CONFIG, Pin name = IO_L6P_T0_FCS_B_14,	Sch name = QSPI_CS
#set_property PACKAGE_PIN K19 [get_ports QspiCSn]
#set_property IOSTANDARD LVCMOS33 [get_ports QspiCSn]



set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]