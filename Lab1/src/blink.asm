;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"blink.c"
	list	p=12f683
	radix dec
	include "p12f683.inc"
;--------------------------------------------------------
; config word(s)
;--------------------------------------------------------
	__config 0x3ff7
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	__modsint
	extern	__divsint
	extern	_TRISIO
	extern	_GPIO
	extern	_GPIObits
	extern	__gptrput2
	extern	__gptrget2
	extern	__gptrput1
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_main
	global	_short_time
	global	_time
	global	_delay
	global	_delay_final
	global	_bcd_convert
	global	_processBCD

	global PSAVE
	global SSAVE
	global WSAVE
	global STK12
	global STK11
	global STK10
	global STK09
	global STK08
	global STK07
	global STK06
	global STK05
	global STK04
	global STK03
	global STK02
	global STK01
	global STK00

sharebank udata_ovr 0x0070
PSAVE	res 1
SSAVE	res 1
WSAVE	res 1
STK12	res 1
STK11	res 1
STK10	res 1
STK09	res 1
STK08	res 1
STK07	res 1
STK06	res 1
STK05	res 1
STK04	res 1
STK03	res 1
STK02	res 1
STK01	res 1
STK00	res 1

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_blink_0	udata
r0x103A	res	1
r0x103B	res	1
r0x103C	res	1
r0x103D	res	1
r0x103E	res	1
r0x103F	res	1
r0x1040	res	1
r0x1041	res	1
r0x1042	res	1
r0x1043	res	1
r0x1045	res	1
r0x1044	res	1
r0x1046	res	1
r0x1033	res	1
r0x1032	res	1
r0x1034	res	1
r0x1035	res	1
r0x1036	res	1
r0x1037	res	1
r0x1038	res	1
r0x1039	res	1
r0x1029	res	1
r0x1028	res	1
r0x102C	res	1
r0x102B	res	1
r0x102A	res	1
r0x102E	res	1
r0x102D	res	1
r0x102F	res	1
r0x1031	res	1
r0x1030	res	1
r0x1018	res	1
r0x1017	res	1
r0x1016	res	1
r0x101B	res	1
r0x101A	res	1
r0x1019	res	1
r0x101C	res	1
r0x101D	res	1
r0x101E	res	1
r0x101F	res	1
r0x1020	res	1
r0x1021	res	1
r0x1022	res	1
r0x1023	res	1
r0x1024	res	1
r0x1025	res	1
r0x1026	res	1
_main_variable1_BCD_65537_49	res	8
_main_variable2_BCD_65537_49	res	8
_main_hex_values_65537_49	res	4
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

IDD_blink_0	idata
_time
	db	0x64, 0x00	; 100


IDD_blink_1	idata
_short_time
	db	0x1e, 0x00	; 30

;--------------------------------------------------------
; initialized absolute data
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; reset vector 
;--------------------------------------------------------
STARTUP	code 0x0000
	nop
	pagesel __sdcc_gsinit_startup
	goto	__sdcc_gsinit_startup
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_blink	code
;***
;  pBlock Stats: dbName = M
;***
;has an exit
;functions called:
;   _bcd_convert
;   _bcd_convert
;   _processBCD
;   _delay
;   _processBCD
;   _delay
;   _delay_final
;   _delay_final
;   _delay_final
;   _bcd_convert
;   _bcd_convert
;   _processBCD
;   _delay
;   _processBCD
;   _delay
;   _delay_final
;   _delay_final
;   _delay_final
;18 compiler assigned registers:
;   r0x103A
;   r0x103B
;   r0x103C
;   r0x103D
;   r0x103E
;   r0x103F
;   r0x1040
;   r0x1041
;   r0x1042
;   r0x1043
;   STK03
;   STK02
;   STK01
;   STK00
;   r0x1044
;   r0x1045
;   r0x1046
;   STK04
;; Starting pCode block
S_blink__main	code
_main:
; 2 exit points
;	.line	18; "blink.c"	TRISIO = 0b00001000; //Poner todos los pines como salidas menos el pin3.
	MOVLW	0x08
	BANKSEL	_TRISIO
	MOVWF	_TRISIO
;	.line	19; "blink.c"	GPIO = 0b00001000; //Poner pines en bajo menos el pin3.
	MOVLW	0x08
	BANKSEL	_GPIO
	MOVWF	_GPIO
;	.line	21; "blink.c"	unsigned char i=0; // Contador
	BANKSEL	r0x103A
	CLRF	r0x103A
;	.line	22; "blink.c"	int num_aleatorio=0, variable1=0, variable2=0, resultado=0;
	CLRF	r0x103B
	CLRF	r0x103C
	CLRF	r0x103D
	CLRF	r0x103E
	CLRF	r0x103F
	CLRF	r0x1040
_00122_DS_:
;	.line	31; "blink.c"	for (int j = 0; j < 100; j++)
	BANKSEL	r0x1041
	CLRF	r0x1041
	CLRF	r0x1042
;;signed compare: left < lit(0x64=100), size=2, mask=ffff
_00117_DS_:
	BANKSEL	r0x1042
	MOVF	r0x1042,W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00146_DS_
	MOVLW	0x64
	SUBWF	r0x1041,W
_00146_DS_:
	BTFSC	STATUS,0
	GOTO	_00105_DS_
;;genSkipc:3307: created from rifx:0x7ffdd1ada6d0
;	.line	33; "blink.c"	num_aleatorio=j;
	BANKSEL	r0x1041
	MOVF	r0x1041,W
	MOVWF	r0x103B
	MOVF	r0x1042,W
	MOVWF	r0x103C
;	.line	31; "blink.c"	for (int j = 0; j < 100; j++)
	INCF	r0x1041,F
	BTFSC	STATUS,2
	INCF	r0x1042,F
	GOTO	_00117_DS_
_00105_DS_:
;	.line	36; "blink.c"	if( GP3 == 0)
	BANKSEL	_GPIObits
	BTFSC	_GPIObits,3
	GOTO	_00122_DS_
;	.line	39; "blink.c"	i++; // Aumento contador en 1.
	BANKSEL	r0x103A
	INCF	r0x103A,F
;;signed compare: left < lit(0xA=10), size=2, mask=ffff
;	.line	41; "blink.c"	if (num_aleatorio < 10)
	MOVF	r0x103C,W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00147_DS_
	MOVLW	0x0a
	SUBWF	r0x103B,W
_00147_DS_:
	BTFSC	STATUS,0
	GOTO	_00108_DS_
;;genSkipc:3307: created from rifx:0x7ffdd1ada6d0
;	.line	43; "blink.c"	variable1 = 0;
	BANKSEL	r0x103D
	CLRF	r0x103D
	CLRF	r0x103E
;	.line	44; "blink.c"	variable2 = num_aleatorio;
	MOVF	r0x103B,W
	MOVWF	r0x103F
	MOVF	r0x103C,W
	MOVWF	r0x1040
_00108_DS_:
;	.line	59; "blink.c"	bcd_convert(variable1, variable1_BCD);
	MOVLW	high (_main_variable1_BCD_65537_49 + 0)
	BANKSEL	r0x1042
	MOVWF	r0x1042
	MOVLW	(_main_variable1_BCD_65537_49 + 0)
	MOVWF	r0x1041
	CLRF	r0x1043
	MOVF	r0x1041,W
	MOVWF	STK03
	MOVF	r0x1042,W
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x103D,W
	MOVWF	STK00
	MOVF	r0x103E,W
	PAGESEL	_bcd_convert
	CALL	_bcd_convert
	PAGESEL	$
;	.line	60; "blink.c"	bcd_convert(variable2, variable2_BCD);
	MOVLW	high (_main_variable2_BCD_65537_49 + 0)
	BANKSEL	r0x1042
	MOVWF	r0x1042
	MOVLW	(_main_variable2_BCD_65537_49 + 0)
	MOVWF	r0x1041
	CLRF	r0x1043
	MOVF	r0x1041,W
	MOVWF	STK03
	MOVF	r0x1042,W
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x103F,W
	MOVWF	STK00
	MOVF	r0x1040,W
	PAGESEL	_bcd_convert
	CALL	_bcd_convert
	PAGESEL	$
;	.line	63; "blink.c"	processBCD(variable1_BCD, hex_values);
	MOVLW	high (_main_variable1_BCD_65537_49 + 0)
	BANKSEL	r0x1042
	MOVWF	r0x1042
	MOVLW	(_main_variable1_BCD_65537_49 + 0)
	MOVWF	r0x1041
	CLRF	r0x1043
	MOVLW	high (_main_hex_values_65537_49 + 0)
	MOVWF	r0x1044
	MOVLW	(_main_hex_values_65537_49 + 0)
	MOVWF	r0x1045
	CLRF	r0x1046
	MOVF	r0x1045,W
	MOVWF	STK04
	MOVF	r0x1044,W
	MOVWF	STK03
	MOVLW	0x00
	MOVWF	STK02
	MOVF	r0x1041,W
	MOVWF	STK01
	MOVF	r0x1042,W
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_processBCD
	CALL	_processBCD
	PAGESEL	$
;	.line	66; "blink.c"	GP5 = 0x00;
	BANKSEL	_GPIObits
	BCF	_GPIObits,5
;	.line	69; "blink.c"	GP0 = hex_values[0];
	BANKSEL	_main_hex_values_65537_49
	MOVF	(_main_hex_values_65537_49 + 0),W
	BANKSEL	r0x1041
	MOVWF	r0x1041
	RRF	r0x1041,W
	BTFSC	STATUS,0
	GOTO	_00001_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
_00001_DS_:
	BTFSS	STATUS,0
	GOTO	_00002_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
_00002_DS_:
;	.line	70; "blink.c"	GP1 = hex_values[1];
	BANKSEL	_main_hex_values_65537_49
	MOVF	(_main_hex_values_65537_49 + 1),W
	BANKSEL	r0x1041
	MOVWF	r0x1041
	RRF	r0x1041,W
	BTFSC	STATUS,0
	GOTO	_00003_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
_00003_DS_:
	BTFSS	STATUS,0
	GOTO	_00004_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
_00004_DS_:
;	.line	71; "blink.c"	GP2 = hex_values[2];
	BANKSEL	_main_hex_values_65537_49
	MOVF	(_main_hex_values_65537_49 + 2),W
	BANKSEL	r0x1041
	MOVWF	r0x1041
	RRF	r0x1041,W
	BTFSC	STATUS,0
	GOTO	_00005_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
_00005_DS_:
	BTFSS	STATUS,0
	GOTO	_00006_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,2
_00006_DS_:
;	.line	72; "blink.c"	GP4 = hex_values[3];
	BANKSEL	_main_hex_values_65537_49
	MOVF	(_main_hex_values_65537_49 + 3),W
	BANKSEL	r0x1041
	MOVWF	r0x1041
	RRF	r0x1041,W
	BTFSC	STATUS,0
	GOTO	_00007_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,4
_00007_DS_:
	BTFSS	STATUS,0
	GOTO	_00008_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,4
_00008_DS_:
;	.line	75; "blink.c"	delay(time);
	BANKSEL	_time
	MOVF	_time,W
	MOVWF	STK00
	MOVF	(_time + 1),W
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	78; "blink.c"	processBCD(variable2_BCD, hex_values);
	MOVLW	high (_main_variable2_BCD_65537_49 + 0)
	BANKSEL	r0x1042
	MOVWF	r0x1042
	MOVLW	(_main_variable2_BCD_65537_49 + 0)
	MOVWF	r0x1041
	CLRF	r0x1043
	MOVLW	high (_main_hex_values_65537_49 + 0)
	MOVWF	r0x1044
	MOVLW	(_main_hex_values_65537_49 + 0)
	MOVWF	r0x1045
	CLRF	r0x1046
	MOVF	r0x1045,W
	MOVWF	STK04
	MOVF	r0x1044,W
	MOVWF	STK03
	MOVLW	0x00
	MOVWF	STK02
	MOVF	r0x1041,W
	MOVWF	STK01
	MOVF	r0x1042,W
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_processBCD
	CALL	_processBCD
	PAGESEL	$
;	.line	81; "blink.c"	GP5 = 0xFF;
	BANKSEL	_GPIObits
	BSF	_GPIObits,5
;	.line	84; "blink.c"	GP0 = hex_values[0];
	BANKSEL	_main_hex_values_65537_49
	MOVF	(_main_hex_values_65537_49 + 0),W
	BANKSEL	r0x1041
	MOVWF	r0x1041
	RRF	r0x1041,W
	BTFSC	STATUS,0
	GOTO	_00009_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
_00009_DS_:
	BTFSS	STATUS,0
	GOTO	_00010_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
_00010_DS_:
;	.line	85; "blink.c"	GP1 = hex_values[1];
	BANKSEL	_main_hex_values_65537_49
	MOVF	(_main_hex_values_65537_49 + 1),W
	BANKSEL	r0x1041
	MOVWF	r0x1041
	RRF	r0x1041,W
	BTFSC	STATUS,0
	GOTO	_00011_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
_00011_DS_:
	BTFSS	STATUS,0
	GOTO	_00012_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
_00012_DS_:
;	.line	86; "blink.c"	GP2 = hex_values[2];
	BANKSEL	_main_hex_values_65537_49
	MOVF	(_main_hex_values_65537_49 + 2),W
	BANKSEL	r0x1041
	MOVWF	r0x1041
	RRF	r0x1041,W
	BTFSC	STATUS,0
	GOTO	_00013_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
_00013_DS_:
	BTFSS	STATUS,0
	GOTO	_00014_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,2
_00014_DS_:
;	.line	87; "blink.c"	GP4 = hex_values[3];
	BANKSEL	_main_hex_values_65537_49
	MOVF	(_main_hex_values_65537_49 + 3),W
	BANKSEL	r0x1041
	MOVWF	r0x1041
	RRF	r0x1041,W
	BTFSC	STATUS,0
	GOTO	_00015_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,4
_00015_DS_:
	BTFSS	STATUS,0
	GOTO	_00016_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,4
_00016_DS_:
;	.line	90; "blink.c"	delay(time);
	BANKSEL	_time
	MOVF	_time,W
	MOVWF	STK00
	MOVF	(_time + 1),W
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	93; "blink.c"	if (i==10)
	BANKSEL	r0x103A
	MOVF	r0x103A,W
	XORLW	0x0a
	BTFSS	STATUS,2
	GOTO	_00122_DS_
;	.line	96; "blink.c"	delay_final(); // 1
	PAGESEL	_delay_final
	CALL	_delay_final
	PAGESEL	$
;	.line	97; "blink.c"	delay_final(); // 2
	PAGESEL	_delay_final
	CALL	_delay_final
	PAGESEL	$
;	.line	98; "blink.c"	delay_final(); // 3
	PAGESEL	_delay_final
	CALL	_delay_final
	PAGESEL	$
;	.line	103; "blink.c"	i=0;
	BANKSEL	r0x103A
	CLRF	r0x103A
	GOTO	_00122_DS_
;	.line	109; "blink.c"	}
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __gptrget2
;   __gptrput1
;   __gptrget2
;   __gptrput1
;23 compiler assigned registers:
;   r0x1016
;   STK00
;   r0x1017
;   STK01
;   r0x1018
;   STK02
;   r0x1019
;   STK03
;   r0x101A
;   STK04
;   r0x101B
;   r0x101C
;   r0x101D
;   r0x101E
;   r0x101F
;   r0x1020
;   r0x1021
;   r0x1022
;   r0x1023
;   r0x1024
;   r0x1025
;   r0x1026
;   r0x1027
;; Starting pCode block
S_blink__processBCD	code
_processBCD:
; 2 exit points
;	.line	173; "blink.c"	void processBCD(const int variable1_BCD[4], unsigned char hex_values[4]) {
	BANKSEL	r0x1016
	MOVWF	r0x1016
	MOVF	STK00,W
	MOVWF	r0x1017
	MOVF	STK01,W
	MOVWF	r0x1018
	MOVF	STK02,W
	MOVWF	r0x1019
	MOVF	STK03,W
	MOVWF	r0x101A
	MOVF	STK04,W
	MOVWF	r0x101B
;	.line	174; "blink.c"	for (int i = 0; i < 4; ++i) {
	CLRF	r0x101C
	CLRF	r0x101D
	CLRF	r0x101E
	CLRF	r0x101F
;;signed compare: left < lit(0x4=4), size=2, mask=ffff
_00194_DS_:
	BANKSEL	r0x101D
	MOVF	r0x101D,W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00213_DS_
	MOVLW	0x04
	SUBWF	r0x101C,W
_00213_DS_:
	BTFSC	STATUS,0
	GOTO	_00196_DS_
;;genSkipc:3307: created from rifx:0x7ffdd1ada6d0
;	.line	175; "blink.c"	hex_values[i] = (variable1_BCD[i] == 0) ? 0x00 : 0xFF;
	BANKSEL	r0x101C
	MOVF	r0x101C,W
	ADDWF	r0x101B,W
	MOVWF	r0x1020
	MOVF	r0x101A,W
	MOVWF	r0x1021
	MOVF	r0x101D,W
	BTFSC	STATUS,0
	INCFSZ	r0x101D,W
	ADDWF	r0x1021,F
	MOVF	r0x1019,W
	MOVWF	r0x1022
	MOVF	r0x101E,W
	ADDWF	r0x1018,W
	MOVWF	r0x1023
	MOVF	r0x1017,W
	MOVWF	r0x1024
	MOVF	r0x101F,W
	BTFSC	STATUS,0
	INCFSZ	r0x101F,W
	ADDWF	r0x1024,F
;;100	MOVF	r0x1016,W
	MOVF	r0x1023,W
	MOVWF	STK01
	MOVF	r0x1024,W
	MOVWF	STK00
;;99	MOVF	r0x1025,W
	MOVF	r0x1016,W
	MOVWF	r0x1025
	PAGESEL	__gptrget2
	CALL	__gptrget2
	PAGESEL	$
	BANKSEL	r0x1026
	MOVWF	r0x1026
	MOVF	STK00,W
;;1	MOVWF	r0x1027
	IORWF	r0x1026,W
	BTFSS	STATUS,2
	GOTO	_00198_DS_
	CLRF	r0x1023
	CLRF	r0x1024
	GOTO	_00199_DS_
_00198_DS_:
	MOVLW	0xff
	BANKSEL	r0x1023
	MOVWF	r0x1023
	CLRF	r0x1024
_00199_DS_:
	BANKSEL	r0x1023
	MOVF	r0x1023,W
	MOVWF	r0x1025
	MOVWF	STK02
	MOVF	r0x1020,W
	MOVWF	STK01
	MOVF	r0x1021,W
	MOVWF	STK00
	MOVF	r0x1022,W
	PAGESEL	__gptrput1
	CALL	__gptrput1
	PAGESEL	$
;	.line	174; "blink.c"	for (int i = 0; i < 4; ++i) {
	MOVLW	0x02
	BANKSEL	r0x101E
	ADDWF	r0x101E,F
	BTFSC	STATUS,0
	INCF	r0x101F,F
	INCF	r0x101C,F
	BTFSC	STATUS,2
	INCF	r0x101D,F
	GOTO	_00194_DS_
_00196_DS_:
;	.line	177; "blink.c"	}
	RETURN	
; exit point of _processBCD

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __divsint
;   __gptrput2
;   __modsint
;   __divsint
;   __gptrput2
;   __modsint
;   __divsint
;   __gptrput2
;   __modsint
;   __gptrput2
;   __divsint
;   __gptrput2
;   __modsint
;   __divsint
;   __gptrput2
;   __modsint
;   __divsint
;   __gptrput2
;   __modsint
;   __gptrput2
;14 compiler assigned registers:
;   r0x1028
;   STK00
;   r0x1029
;   STK01
;   r0x102A
;   STK02
;   r0x102B
;   STK03
;   r0x102C
;   r0x102D
;   r0x102E
;   r0x102F
;   r0x1030
;   r0x1031
;; Starting pCode block
S_blink__bcd_convert	code
_bcd_convert:
; 2 exit points
;	.line	166; "blink.c"	void bcd_convert(int num, int *bcd) {
	BANKSEL	r0x1028
	MOVWF	r0x1028
	MOVF	STK00,W
	MOVWF	r0x1029
	MOVF	STK01,W
	MOVWF	r0x102A
	MOVF	STK02,W
	MOVWF	r0x102B
	MOVF	STK03,W
	MOVWF	r0x102C
;	.line	167; "blink.c"	bcd[0] = num / 8;
	MOVLW	0x08
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x1029,W
	MOVWF	STK00
	MOVF	r0x1028,W
	PAGESEL	__divsint
	CALL	__divsint
	PAGESEL	$
	BANKSEL	r0x102D
	MOVWF	r0x102D
	MOVF	STK00,W
	MOVWF	r0x102E
	MOVF	r0x102D,W
	MOVWF	STK02
	MOVF	r0x102E,W
	MOVWF	STK03
	MOVF	r0x102C,W
	MOVWF	STK01
	MOVF	r0x102B,W
	MOVWF	STK00
	MOVF	r0x102A,W
	PAGESEL	__gptrput2
	CALL	__gptrput2
	PAGESEL	$
;	.line	168; "blink.c"	bcd[1] = (num % 8) / 4;
	MOVLW	0x02
	BANKSEL	r0x102C
	ADDWF	r0x102C,W
	MOVWF	r0x102E
	CLRF	r0x102D
	RLF	r0x102D,F
	MOVF	r0x102B,W
	ADDWF	r0x102D,F
	CLRF	r0x102F
	RLF	r0x102F,F
	MOVF	r0x102A,W
	ADDWF	r0x102F,F
	MOVLW	0x08
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x1029,W
	MOVWF	STK00
	MOVF	r0x1028,W
	PAGESEL	__modsint
	CALL	__modsint
	PAGESEL	$
	BANKSEL	r0x1030
	MOVWF	r0x1030
	MOVF	STK00,W
	MOVWF	r0x1031
	MOVLW	0x04
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x1031,W
	MOVWF	STK00
	MOVF	r0x1030,W
	PAGESEL	__divsint
	CALL	__divsint
	PAGESEL	$
	BANKSEL	r0x1030
	MOVWF	r0x1030
	MOVF	STK00,W
	MOVWF	r0x1031
	MOVF	r0x1030,W
	MOVWF	STK02
	MOVF	r0x1031,W
	MOVWF	STK03
	MOVF	r0x102E,W
	MOVWF	STK01
	MOVF	r0x102D,W
	MOVWF	STK00
	MOVF	r0x102F,W
	PAGESEL	__gptrput2
	CALL	__gptrput2
	PAGESEL	$
;	.line	169; "blink.c"	bcd[2] = (num % 4) / 2;
	MOVLW	0x04
	BANKSEL	r0x102C
	ADDWF	r0x102C,W
	MOVWF	r0x102E
	CLRF	r0x102D
	RLF	r0x102D,F
	MOVF	r0x102B,W
	ADDWF	r0x102D,F
	CLRF	r0x102F
	RLF	r0x102F,F
	MOVF	r0x102A,W
	ADDWF	r0x102F,F
	MOVLW	0x04
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x1029,W
	MOVWF	STK00
	MOVF	r0x1028,W
	PAGESEL	__modsint
	CALL	__modsint
	PAGESEL	$
	BANKSEL	r0x1030
	MOVWF	r0x1030
	MOVF	STK00,W
	MOVWF	r0x1031
	MOVLW	0x02
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x1031,W
	MOVWF	STK00
	MOVF	r0x1030,W
	PAGESEL	__divsint
	CALL	__divsint
	PAGESEL	$
	BANKSEL	r0x1030
	MOVWF	r0x1030
	MOVF	STK00,W
	MOVWF	r0x1031
	MOVF	r0x1030,W
	MOVWF	STK02
	MOVF	r0x1031,W
	MOVWF	STK03
	MOVF	r0x102E,W
	MOVWF	STK01
	MOVF	r0x102D,W
	MOVWF	STK00
	MOVF	r0x102F,W
	PAGESEL	__gptrput2
	CALL	__gptrput2
	PAGESEL	$
;	.line	170; "blink.c"	bcd[3] = num % 2;
	MOVLW	0x06
	BANKSEL	r0x102C
	ADDWF	r0x102C,F
	BTFSC	STATUS,0
	INCF	r0x102B,F
	BTFSC	STATUS,2
	INCF	r0x102A,F
	MOVLW	0x02
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x1029,W
	MOVWF	STK00
	MOVF	r0x1028,W
	PAGESEL	__modsint
	CALL	__modsint
	PAGESEL	$
	BANKSEL	r0x1028
	MOVWF	r0x1028
	MOVF	STK00,W
	MOVWF	r0x1029
	MOVF	r0x1028,W
	MOVWF	STK02
	MOVF	r0x1029,W
	MOVWF	STK03
	MOVF	r0x102C,W
	MOVWF	STK01
	MOVF	r0x102B,W
	MOVWF	STK00
	MOVF	r0x102A,W
	PAGESEL	__gptrput2
	CALL	__gptrput2
	PAGESEL	$
;	.line	171; "blink.c"	}
	RETURN	
; exit point of _bcd_convert

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;1 compiler assigned register :
;   STK00
;; Starting pCode block
S_blink__delay_final	code
_delay_final:
; 2 exit points
;	.line	123; "blink.c"	delay(time);
	BANKSEL	_time
	MOVF	_time,W
	MOVWF	STK00
	MOVF	(_time + 1),W
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	126; "blink.c"	GP5 = 0x00;
	BANKSEL	_GPIObits
	BCF	_GPIObits,5
;	.line	129; "blink.c"	GP0 = 0x01;
	BSF	_GPIObits,0
;	.line	130; "blink.c"	GP1 = 0x00;
	BCF	_GPIObits,1
;	.line	131; "blink.c"	GP2 = 0x00;
	BCF	_GPIObits,2
;	.line	132; "blink.c"	GP4 = 0x00;
	BCF	_GPIObits,4
;	.line	138; "blink.c"	GP5 = 0xFF;
	BSF	_GPIObits,5
;	.line	141; "blink.c"	GP0 = 0x01;
	BSF	_GPIObits,0
;	.line	142; "blink.c"	GP1 = 0x00;
	BCF	_GPIObits,1
;	.line	143; "blink.c"	GP2 = 0x00;
	BCF	_GPIObits,2
;	.line	144; "blink.c"	GP4 = 0x00;
	BCF	_GPIObits,4
;	.line	147; "blink.c"	delay(time);
	BANKSEL	_time
	MOVF	_time,W
	MOVWF	STK00
	MOVF	(_time + 1),W
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	150; "blink.c"	GP0 = 0x00;
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
;	.line	151; "blink.c"	GP1 = 0x00;
	BCF	_GPIObits,1
;	.line	152; "blink.c"	GP2 = 0x00;
	BCF	_GPIObits,2
;	.line	153; "blink.c"	GP4 = 0x00;
	BCF	_GPIObits,4
;	.line	156; "blink.c"	GP5 = 0x00;
	BCF	_GPIObits,5
;	.line	157; "blink.c"	GP0 = 0x00;
	BCF	_GPIObits,0
;	.line	158; "blink.c"	GP1 = 0x00;
	BCF	_GPIObits,1
;	.line	159; "blink.c"	GP2 = 0x00;
	BCF	_GPIObits,2
;	.line	160; "blink.c"	GP4 = 0x00;
	BCF	_GPIObits,4
;	.line	163; "blink.c"	delay(time);
	BANKSEL	_time
	MOVF	_time,W
	MOVWF	STK00
	MOVF	(_time + 1),W
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	164; "blink.c"	}
	RETURN	
; exit point of _delay_final

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;9 compiler assigned registers:
;   r0x1032
;   STK00
;   r0x1033
;   r0x1034
;   r0x1035
;   r0x1036
;   r0x1037
;   r0x1038
;   r0x1039
;; Starting pCode block
S_blink__delay	code
_delay:
; 2 exit points
;	.line	111; "blink.c"	void delay(unsigned int tiempo)
	BANKSEL	r0x1032
	MOVWF	r0x1032
	MOVF	STK00,W
	MOVWF	r0x1033
;	.line	116; "blink.c"	for(i=0;i<tiempo;i++)
	CLRF	r0x1034
	CLRF	r0x1035
_00158_DS_:
	BANKSEL	r0x1032
	MOVF	r0x1032,W
	SUBWF	r0x1035,W
	BTFSS	STATUS,2
	GOTO	_00179_DS_
	MOVF	r0x1033,W
	SUBWF	r0x1034,W
_00179_DS_:
	BTFSC	STATUS,0
	GOTO	_00160_DS_
;;genSkipc:3307: created from rifx:0x7ffdd1ada6d0
;	.line	117; "blink.c"	for(j=0;j<1275;j++);
	MOVLW	0xfb
	BANKSEL	r0x1036
	MOVWF	r0x1036
	MOVLW	0x04
	MOVWF	r0x1037
_00156_DS_:
	MOVLW	0xff
	BANKSEL	r0x1036
	ADDWF	r0x1036,W
	MOVWF	r0x1038
	MOVLW	0xff
	MOVWF	r0x1039
	MOVF	r0x1037,W
	BTFSC	STATUS,0
	INCFSZ	r0x1037,W
	ADDWF	r0x1039,F
	MOVF	r0x1038,W
	MOVWF	r0x1036
	MOVF	r0x1039,W
	MOVWF	r0x1037
	MOVF	r0x1039,W
	IORWF	r0x1038,W
	BTFSS	STATUS,2
	GOTO	_00156_DS_
;	.line	116; "blink.c"	for(i=0;i<tiempo;i++)
	INCF	r0x1034,F
	BTFSC	STATUS,2
	INCF	r0x1035,F
	GOTO	_00158_DS_
_00160_DS_:
;	.line	118; "blink.c"	}
	RETURN	
; exit point of _delay


;	code size estimation:
;	  509+  125 =   634 instructions ( 1518 byte)

	end
