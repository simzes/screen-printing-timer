EESchema Schematic File Version 4
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 5D9C1C8E
P 950 1100
F 0 "J1" H 870 775 50  0000 C CNN
F 1 "Conn_01x02" H 870 866 50  0000 C CNN
F 2 "" H 950 1100 50  0001 C CNN
F 3 "~" H 950 1100 50  0001 C CNN
	1    950  1100
	-1   0    0    1   
$EndComp
Wire Wire Line
	1150 1100 1250 1100
$Comp
L power:GND #PWR01
U 1 1 5D9C1E21
P 1250 1250
F 0 "#PWR01" H 1250 1000 50  0001 C CNN
F 1 "GND" H 1255 1077 50  0000 C CNN
F 2 "" H 1250 1250 50  0001 C CNN
F 3 "" H 1250 1250 50  0001 C CNN
	1    1250 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	1150 1000 1450 1000
Wire Wire Line
	1450 1000 1450 800 
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5D9C2024
P 1450 800
F 0 "#FLG01" H 1450 875 50  0001 C CNN
F 1 "PWR_FLAG" H 1450 974 50  0000 C CNN
F 2 "" H 1450 800 50  0001 C CNN
F 3 "~" H 1450 800 50  0001 C CNN
	1    1450 800 
	1    0    0    -1  
$EndComp
Connection ~ 1250 1100
Text Label 1450 1000 0    50   ~ 0
5V+
Wire Wire Line
	1450 1000 2300 1000
Wire Wire Line
	2300 1000 2300 1500
Connection ~ 1450 1000
Wire Wire Line
	2400 3600 2400 3700
Text Label 2400 3700 0    50   ~ 0
GND
NoConn ~ 2300 3600
NoConn ~ 2500 3600
NoConn ~ 2900 1900
NoConn ~ 2900 2100
NoConn ~ 2900 2300
NoConn ~ 2900 3200
NoConn ~ 2900 3300
Wire Wire Line
	2900 2500 3000 2500
Text Label 3000 2500 0    50   ~ 0
UP
Wire Wire Line
	2900 2600 3000 2600
Text Label 3000 2600 0    50   ~ 0
DOWN
Wire Wire Line
	2900 2700 3000 2700
Text Label 3000 2700 0    50   ~ 0
RUN_PAUSE
Wire Wire Line
	2900 2800 3000 2800
Text Label 3000 2800 0    50   ~ 0
LID_OPEN
Wire Wire Line
	2900 2900 3000 2900
Text Label 3000 2900 0    50   ~ 0
LID_OVERRIDE
$Comp
L 74xx-eu:74164N IC1
U 1 1 5D9C297A
P 4950 3200
F 0 "IC1" H 4950 3765 50  0000 C CNN
F 1 "74164N" H 4950 3674 50  0000 C CNN
F 2 "74xx-eu-DIL14" H 4950 3350 50  0001 C CNN
F 3 "" H 4950 3200 50  0001 C CNN
	1    4950 3200
	1    0    0    -1  
$EndComp
$Comp
L common_anode_4x_seven_segment:common_anode_4x_seven_segment U1
U 1 1 5D9C2A8C
P 5050 1900
F 0 "U1" H 5075 2447 60  0000 C CNN
F 1 "common_anode_4x_seven_segment" H 5075 2341 60  0000 C CNN
F 2 "" H 4900 1800 60  0001 C CNN
F 3 "" H 4900 1800 60  0001 C CNN
	1    5050 1900
	1    0    0    -1  
$EndComp
Text Label 5450 2900 0    50   ~ 0
S1
Text Label 5450 3000 0    50   ~ 0
S2
Text Label 5450 3100 0    50   ~ 0
S3
Text Label 5450 3200 0    50   ~ 0
S4
Text Label 5450 3300 0    50   ~ 0
S5
Text Label 5450 3500 0    50   ~ 0
S7
Text Label 5450 3400 0    50   ~ 0
S6
Text Label 5450 3600 0    50   ~ 0
S8
NoConn ~ 4450 3600
Wire Wire Line
	4450 3000 4350 3000
Wire Wire Line
	4350 3000 4350 2900
Wire Wire Line
	4350 2900 4450 2900
Wire Wire Line
	4350 2900 4250 2900
Connection ~ 4350 2900
Text Label 4250 2900 2    50   ~ 0
SR_DATA
Text Label 4700 1750 2    50   ~ 0
DIGIT_0
Text Label 4700 1850 2    50   ~ 0
DIGIT_1
Text Label 4700 1950 2    50   ~ 0
DIGIT_2
Text Label 4700 2050 2    50   ~ 0
DIGIT_3
Text Label 5450 1600 0    50   ~ 0
DOT
Text Label 5450 1700 0    50   ~ 0
TOP
Text Label 5450 1800 0    50   ~ 0
TOP_LEFT
Text Label 5450 1900 0    50   ~ 0
TOP_RIGHT
Text Label 5450 2000 0    50   ~ 0
MIDDLE
Text Label 5450 2100 0    50   ~ 0
BOTTOM_LEFT
Text Label 5450 2200 0    50   ~ 0
BOTTOM_RIGHT
Text Label 5450 2300 0    50   ~ 0
BOTTOM
Wire Wire Line
	4450 3400 4250 3400
Text Label 4250 3400 2    50   ~ 0
SR_CLK
$Comp
L Transistor_BJT:2N3904 Q2
U 1 1 5D9C31E1
P 6850 2000
F 0 "Q2" H 7041 2046 50  0000 L CNN
F 1 "2N3904" H 7041 1955 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 7050 1925 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N3904.pdf" H 6850 2000 50  0001 L CNN
	1    6850 2000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5D9C327D
P 6550 1750
F 0 "R3" V 6343 1750 50  0000 C CNN
F 1 "10K" V 6434 1750 50  0000 C CNN
F 2 "" V 6480 1750 50  0001 C CNN
F 3 "~" H 6550 1750 50  0001 C CNN
	1    6550 1750
	-1   0    0    1   
$EndComp
Wire Wire Line
	6950 2200 6950 2350
Text Label 6950 2350 0    50   ~ 0
GND
Text Label 6950 1500 0    50   ~ 0
BOTTOM
Wire Wire Line
	6550 1600 6550 1500
Text Label 6550 1500 2    50   ~ 0
S1
Wire Wire Line
	6550 1900 6550 2000
Wire Wire Line
	6550 2000 6650 2000
Wire Wire Line
	6950 1500 6950 1800
$Comp
L Transistor_BJT:2N3904 Q4
U 1 1 5D9C4C0D
P 7950 2000
F 0 "Q4" H 8141 2046 50  0000 L CNN
F 1 "2N3904" H 8141 1955 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 8150 1925 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N3904.pdf" H 7950 2000 50  0001 L CNN
	1    7950 2000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 5D9C4C13
P 7650 1750
F 0 "R5" V 7443 1750 50  0000 C CNN
F 1 "10K" V 7534 1750 50  0000 C CNN
F 2 "" V 7580 1750 50  0001 C CNN
F 3 "~" H 7650 1750 50  0001 C CNN
	1    7650 1750
	-1   0    0    1   
$EndComp
Wire Wire Line
	8050 2200 8050 2350
Text Label 8050 2350 0    50   ~ 0
GND
Text Label 8050 1500 0    50   ~ 0
BOTTOM_RIGHT
Wire Wire Line
	7650 1600 7650 1500
Text Label 7650 1500 2    50   ~ 0
S2
Wire Wire Line
	7650 1900 7650 2000
Wire Wire Line
	7650 2000 7750 2000
Wire Wire Line
	8050 1500 8050 1800
$Comp
L Transistor_BJT:2N3904 Q6
U 1 1 5D9C5217
P 9050 2000
F 0 "Q6" H 9241 2046 50  0000 L CNN
F 1 "2N3904" H 9241 1955 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 9250 1925 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N3904.pdf" H 9050 2000 50  0001 L CNN
	1    9050 2000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 5D9C521D
P 8750 1750
F 0 "R7" V 8543 1750 50  0000 C CNN
F 1 "10K" V 8634 1750 50  0000 C CNN
F 2 "" V 8680 1750 50  0001 C CNN
F 3 "~" H 8750 1750 50  0001 C CNN
	1    8750 1750
	-1   0    0    1   
$EndComp
Wire Wire Line
	9150 2200 9150 2350
Text Label 9150 2350 0    50   ~ 0
GND
Text Label 9150 1500 0    50   ~ 0
BOTTOM_LEFT
Wire Wire Line
	8750 1600 8750 1500
Text Label 8750 1500 2    50   ~ 0
S3
Wire Wire Line
	8750 1900 8750 2000
Wire Wire Line
	8750 2000 8850 2000
Wire Wire Line
	9150 1500 9150 1800
$Comp
L Transistor_BJT:2N3904 Q8
U 1 1 5D9C522B
P 10150 2000
F 0 "Q8" H 10341 2046 50  0000 L CNN
F 1 "2N3904" H 10341 1955 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 10350 1925 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N3904.pdf" H 10150 2000 50  0001 L CNN
	1    10150 2000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 5D9C5231
P 9850 1750
F 0 "R9" V 9643 1750 50  0000 C CNN
F 1 "10K" V 9734 1750 50  0000 C CNN
F 2 "" V 9780 1750 50  0001 C CNN
F 3 "~" H 9850 1750 50  0001 C CNN
	1    9850 1750
	-1   0    0    1   
$EndComp
Wire Wire Line
	10250 2200 10250 2350
Text Label 10250 2350 0    50   ~ 0
GND
Text Label 10250 1500 0    50   ~ 0
MIDDLE
Wire Wire Line
	9850 1600 9850 1500
Text Label 9850 1500 2    50   ~ 0
S4
Wire Wire Line
	9850 1900 9850 2000
Wire Wire Line
	9850 2000 9950 2000
Wire Wire Line
	10250 1500 10250 1800
$Comp
L Transistor_BJT:2N3904 Q3
U 1 1 5D9C5AAE
P 6850 3400
F 0 "Q3" H 7041 3446 50  0000 L CNN
F 1 "2N3904" H 7041 3355 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 7050 3325 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N3904.pdf" H 6850 3400 50  0001 L CNN
	1    6850 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 5D9C5AB4
P 6550 3150
F 0 "R4" V 6343 3150 50  0000 C CNN
F 1 "10K" V 6434 3150 50  0000 C CNN
F 2 "" V 6480 3150 50  0001 C CNN
F 3 "~" H 6550 3150 50  0001 C CNN
	1    6550 3150
	-1   0    0    1   
$EndComp
Wire Wire Line
	6950 3600 6950 3750
Text Label 6950 3750 0    50   ~ 0
GND
Text Label 6950 2900 0    50   ~ 0
TOP_RIGHT
Wire Wire Line
	6550 3000 6550 2900
Text Label 6550 2900 2    50   ~ 0
S5
Wire Wire Line
	6550 3300 6550 3400
Wire Wire Line
	6550 3400 6650 3400
Wire Wire Line
	6950 2900 6950 3200
$Comp
L Transistor_BJT:2N3904 Q5
U 1 1 5D9C5AC2
P 7950 3400
F 0 "Q5" H 8141 3446 50  0000 L CNN
F 1 "2N3904" H 8141 3355 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 8150 3325 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N3904.pdf" H 7950 3400 50  0001 L CNN
	1    7950 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 5D9C5AC8
P 7650 3150
F 0 "R6" V 7443 3150 50  0000 C CNN
F 1 "10K" V 7534 3150 50  0000 C CNN
F 2 "" V 7580 3150 50  0001 C CNN
F 3 "~" H 7650 3150 50  0001 C CNN
	1    7650 3150
	-1   0    0    1   
$EndComp
Wire Wire Line
	8050 3600 8050 3750
Text Label 8050 3750 0    50   ~ 0
GND
Text Label 8050 2900 0    50   ~ 0
TOP_LEFT
Wire Wire Line
	7650 3000 7650 2900
Text Label 7650 2900 2    50   ~ 0
S6
Wire Wire Line
	7650 3300 7650 3400
Wire Wire Line
	7650 3400 7750 3400
Wire Wire Line
	8050 2900 8050 3200
$Comp
L Transistor_BJT:2N3904 Q7
U 1 1 5D9C5AD6
P 9050 3400
F 0 "Q7" H 9241 3446 50  0000 L CNN
F 1 "2N3904" H 9241 3355 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 9250 3325 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N3904.pdf" H 9050 3400 50  0001 L CNN
	1    9050 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 5D9C5ADC
P 8750 3150
F 0 "R8" V 8543 3150 50  0000 C CNN
F 1 "10K" V 8634 3150 50  0000 C CNN
F 2 "" V 8680 3150 50  0001 C CNN
F 3 "~" H 8750 3150 50  0001 C CNN
	1    8750 3150
	-1   0    0    1   
$EndComp
Wire Wire Line
	9150 3600 9150 3750
Text Label 9150 3750 0    50   ~ 0
GND
Text Label 9150 2900 0    50   ~ 0
TOP
Wire Wire Line
	8750 3000 8750 2900
Text Label 8750 2900 2    50   ~ 0
S7
Wire Wire Line
	8750 3300 8750 3400
Wire Wire Line
	8750 3400 8850 3400
Wire Wire Line
	9150 2900 9150 3200
$Comp
L Transistor_BJT:2N3904 Q9
U 1 1 5D9C5AEA
P 10150 3400
F 0 "Q9" H 10341 3446 50  0000 L CNN
F 1 "2N3904" H 10341 3355 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 10350 3325 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N3904.pdf" H 10150 3400 50  0001 L CNN
	1    10150 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 5D9C5AF0
P 9850 3150
F 0 "R10" V 9643 3150 50  0000 C CNN
F 1 "10K" V 9734 3150 50  0000 C CNN
F 2 "" V 9780 3150 50  0001 C CNN
F 3 "~" H 9850 3150 50  0001 C CNN
	1    9850 3150
	-1   0    0    1   
$EndComp
Wire Wire Line
	10250 3600 10250 3750
Text Label 10250 3750 0    50   ~ 0
GND
Text Label 10250 2900 0    50   ~ 0
DOT
Wire Wire Line
	9850 3000 9850 2900
Text Label 9850 2900 2    50   ~ 0
S8
Wire Wire Line
	9850 3300 9850 3400
Wire Wire Line
	9850 3400 9950 3400
Wire Wire Line
	10250 2900 10250 3200
$Comp
L MCU_Module:Arduino_UNO_R3 A1
U 1 1 5D9C21C1
P 2400 2500
F 0 "A1" H 2400 3678 50  0000 C CNN
F 1 "Arduino_UNO_R3" H 2400 3587 50  0000 C CNN
F 2 "Module:Arduino_UNO_R3" H 2550 1450 50  0001 L CNN
F 3 "https://www.arduino.cc/en/Main/arduinoBoardUno" H 2200 3550 50  0001 C CNN
	1    2400 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 3000 3000 3000
Text Label 3000 3000 0    50   ~ 0
SR_DATA
Wire Wire Line
	1900 2300 1800 2300
Text Label 1800 2300 2    50   ~ 0
SR_CLK
NoConn ~ 1900 1900
NoConn ~ 1900 2000
Wire Wire Line
	1900 2200 1800 2200
Text Label 1800 2200 2    50   ~ 0
R_LED
Wire Wire Line
	1900 2400 1800 2400
Text Label 1800 2400 2    50   ~ 0
G_LED
Wire Wire Line
	1900 2500 1800 2500
Text Label 1800 2500 2    50   ~ 0
B_LED
Wire Wire Line
	1900 2700 1800 2700
Text Label 1800 2700 2    50   ~ 0
LIGHT_RELAY_INV
$Comp
L Connector_Generic:Conn_01x02 J3
U 1 1 5D9CE4F4
P 4200 4650
F 0 "J3" H 4280 4642 50  0000 L CNN
F 1 "Conn_01x02" H 4280 4551 50  0000 L CNN
F 2 "" H 4200 4650 50  0001 C CNN
F 3 "~" H 4200 4650 50  0001 C CNN
	1    4200 4650
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J4
U 1 1 5D9CE629
P 4200 5200
F 0 "J4" H 4280 5192 50  0000 L CNN
F 1 "Conn_01x02" H 4280 5101 50  0000 L CNN
F 2 "" H 4200 5200 50  0001 C CNN
F 3 "~" H 4200 5200 50  0001 C CNN
	1    4200 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 4750 3800 4750
Wire Wire Line
	3800 4750 3800 5300
Wire Wire Line
	3800 5300 4000 5300
Wire Wire Line
	3800 5300 3800 5550
Connection ~ 3800 5300
Text Label 3800 5550 0    50   ~ 0
GND
Wire Wire Line
	4000 5200 3700 5200
Text Label 3700 5200 2    50   ~ 0
LID_OVERRIDE
Wire Wire Line
	4000 4650 3700 4650
Text Label 3700 4650 2    50   ~ 0
LID_OPEN
$Comp
L Connector_Generic:Conn_01x02 J5
U 1 1 5D9D3210
P 5950 4650
F 0 "J5" H 6030 4642 50  0000 L CNN
F 1 "Conn_01x02" H 6030 4551 50  0000 L CNN
F 2 "" H 5950 4650 50  0001 C CNN
F 3 "~" H 5950 4650 50  0001 C CNN
	1    5950 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 4650 5500 4650
$Comp
L Connector_Generic:Conn_01x02 J6
U 1 1 5D9D5A1B
P 5950 5200
F 0 "J6" H 6030 5192 50  0000 L CNN
F 1 "Conn_01x02" H 6030 5101 50  0000 L CNN
F 2 "" H 5950 5200 50  0001 C CNN
F 3 "~" H 5950 5200 50  0001 C CNN
	1    5950 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 4750 5550 4750
Wire Wire Line
	5550 4750 5550 5300
Wire Wire Line
	5550 5300 5750 5300
$Comp
L Connector_Generic:Conn_01x02 J7
U 1 1 5D9D7057
P 5950 5850
F 0 "J7" H 6030 5842 50  0000 L CNN
F 1 "Conn_01x02" H 6030 5751 50  0000 L CNN
F 2 "" H 5950 5850 50  0001 C CNN
F 3 "~" H 5950 5850 50  0001 C CNN
	1    5950 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5550 5300 5550 5950
Wire Wire Line
	5550 5950 5750 5950
Connection ~ 5550 5300
Wire Wire Line
	5750 5200 5500 5200
Wire Wire Line
	5500 5850 5750 5850
Text Label 5500 4650 2    50   ~ 0
UP
Text Label 5500 5200 2    50   ~ 0
DOWN
Text Label 5500 5850 2    50   ~ 0
RUN_PAUSE
Wire Wire Line
	5550 5950 5550 6200
Connection ~ 5550 5950
Text Label 5550 6200 0    50   ~ 0
GND
$Comp
L Connector_Generic:Conn_01x02 J8
U 1 1 5D9DD116
P 7900 4650
F 0 "J8" H 7980 4642 50  0000 L CNN
F 1 "Conn_01x02" H 7980 4551 50  0000 L CNN
F 2 "" H 7900 4650 50  0001 C CNN
F 3 "~" H 7900 4650 50  0001 C CNN
	1    7900 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	7700 4650 7400 4650
Text Label 7400 4650 2    50   ~ 0
PIEZO
Wire Wire Line
	7700 4750 7450 4750
Wire Wire Line
	7450 4750 7450 4950
Text Label 7450 4950 0    50   ~ 0
GND
$Comp
L Transistor_BJT:2N3904 Q1
U 1 1 5D9E0BE8
P 1600 5450
F 0 "Q1" H 1791 5496 50  0000 L CNN
F 1 "2N3904" H 1791 5405 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 1800 5375 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N3904.pdf" H 1600 5450 50  0001 L CNN
	1    1600 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 5450 1250 5450
$Comp
L Device:R R1
U 1 1 5D9E28A2
P 1250 5000
F 0 "R1" H 1320 5046 50  0000 L CNN
F 1 "R" H 1320 4955 50  0000 L CNN
F 2 "" V 1180 5000 50  0001 C CNN
F 3 "~" H 1250 5000 50  0001 C CNN
	1    1250 5000
	1    0    0    -1  
$EndComp
Text Label 1250 4650 2    50   ~ 0
LIGHT_RELAY_INV
Wire Wire Line
	1700 5250 1700 5200
$Comp
L Device:R R2
U 1 1 5D9E9FE1
P 1700 5000
F 0 "R2" H 1770 5046 50  0000 L CNN
F 1 "R" H 1770 4955 50  0000 L CNN
F 2 "" V 1630 5000 50  0001 C CNN
F 3 "~" H 1700 5000 50  0001 C CNN
	1    1700 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 5150 1250 5450
Wire Wire Line
	1250 4850 1250 4650
Wire Wire Line
	1700 4850 1700 4650
Text Label 1700 4650 2    50   ~ 0
5V+
Wire Wire Line
	1700 5650 1700 5750
Text Label 1700 6000 2    50   ~ 0
GND
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 5D9F4960
P 2450 5200
F 0 "J2" H 2530 5192 50  0000 L CNN
F 1 "Conn_01x02" H 2530 5101 50  0000 L CNN
F 2 "" H 2450 5200 50  0001 C CNN
F 3 "~" H 2450 5200 50  0001 C CNN
	1    2450 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	2250 5200 1700 5200
Connection ~ 1700 5200
Wire Wire Line
	1700 5200 1700 5150
Wire Wire Line
	2250 5300 2250 5750
Wire Wire Line
	2250 5750 1700 5750
Connection ~ 1700 5750
Wire Wire Line
	1700 5750 1700 6000
Wire Wire Line
	1900 2800 1800 2800
Text Label 1800 2800 2    50   ~ 0
PIEZO
NoConn ~ 1900 2600
Text Notes 1050 6400 0    50   ~ 0
light signal inversion and relay connection
Text Notes 3250 6400 0    50   ~ 0
lid detection and override connections
Text Notes 5200 6400 0    50   ~ 0
timer button connections
Text Notes 7450 5200 0    50   ~ 0
piezo connection\n
Text Notes 8000 1200 0    50   ~ 0
segment collectors\n
Text Notes 4550 1200 0    50   ~ 0
4x 7-segment display connection
NoConn ~ 1900 2100
$Comp
L Device:LED_CRGB D1
U 1 1 5DA12C65
P 7900 5850
F 0 "D1" H 7900 5383 50  0000 C CNN
F 1 "LED_CRGB" H 7900 5474 50  0000 C CNN
F 2 "" H 7900 5800 50  0001 C CNN
F 3 "~" H 7900 5800 50  0001 C CNN
	1    7900 5850
	-1   0    0    1   
$EndComp
Text Notes 7600 6400 0    50   ~ 0
RGB status LED\n
Text Label 7700 6050 2    50   ~ 0
R_LED
Text Label 7700 5850 2    50   ~ 0
G_LED
Text Label 7700 5650 2    50   ~ 0
B_LED
Text Label 8100 5850 0    50   ~ 0
GND
NoConn ~ 2500 1500
NoConn ~ 2600 1500
Text Label 1800 2900 2    50   ~ 0
DIGIT_0
Wire Wire Line
	1800 2900 1900 2900
Text Label 1800 3200 2    50   ~ 0
DIGIT_1
Text Label 1800 3100 2    50   ~ 0
DIGIT_2
Text Label 1800 3000 2    50   ~ 0
DIGIT_3
Wire Wire Line
	1800 3000 1900 3000
Wire Wire Line
	1800 3100 1900 3100
Wire Wire Line
	1800 3200 1900 3200
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5DA27F84
P 1550 1250
F 0 "#FLG0101" H 1550 1325 50  0001 C CNN
F 1 "PWR_FLAG" H 1550 1423 50  0000 C CNN
F 2 "" H 1550 1250 50  0001 C CNN
F 3 "~" H 1550 1250 50  0001 C CNN
	1    1550 1250
	-1   0    0    1   
$EndComp
Wire Wire Line
	1250 1100 1250 1250
Wire Wire Line
	1550 1250 1550 1100
Wire Wire Line
	1250 1100 1550 1100
Text Label 1550 1100 0    50   ~ 0
GND
$EndSCHEMATC
