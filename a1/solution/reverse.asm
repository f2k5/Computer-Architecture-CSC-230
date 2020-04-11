
;<=============================>
;<=============================>
;<====FARDIN KHAN,V00876483====>
;<=============================>
;<=============================>

; reverse.asm
; CSC 230: Spring 2018
;
; Code provided for Assignment #1
;
; Mike Zastre (2018-Jan-21)

; This skeleton of an assembly-language program is provided to help you
; begin with the programming task for A#1, part (b). In this and other
; files provided through the semester, you will see lines of code
; indicating "DO NOT TOUCH" sections. You are *not* to modify the
; lines within these sections. The only exceptions are for specific
; changes announced on conneX or in written permission from the course
; instructor. *** Unapproved changes could result in incorrect code
; execution during assignment evaluation, along with an assignment grade
; of zero. ****
;
; In a more positive vein, you are expected to place your code with the
; area marked "STUDENT CODE" sections.

; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
; Your task: To reverse the bits in the word IN1:IN2 and to store the
; result in OUT1:OUT2. For example, if the word stored in IN1:IN2 is
; 0xA174, then reversing the bits will yield the value 0x2E85 to be
; stored in OUT1:OUT2.

    .cseg
    .org 0

; ==== END OF "DO NOT TOUCH" SECTION ==========

; **** BEGINNING OF "STUDENT CODE" SECTION **** 
    ; These first lines store a word into IN1:IN2. You may
    ; change the value of the word as part of your coding and
    ; testing.
    ;
	
    .def value1 = r16
	.def value2 = r18
	.def value3 = r19
	.def value4 = r22
	.def value5 = r23
	.def value6 = r24
	.def value7 = r25
	.def value8 = r26

   
    ldi value1, 0xA1 
    sts IN1, value1
   
    ldi value1, 0x74
    sts IN2, value1

	
    ;===========================================
	;==========Reversing the byte 0xA1==========
    ;===========================================

	 lds value1, IN1
    ;--> Giving the mask a name
	.def mask = r17
	ldi mask, 0x01

	;--> for loop count in loop_1
	.def seven_times = r27
	ldi seven_times, 0x07

	;--> for loop count in loop_2
	.def six_times = r20
	ldi six_times, 0x06

	;--> for loop count in loop_3
	.def five_times = r21
	ldi five_times, 0x05

	;--> for loop count in loop_4
	.def four_times = r28
	ldi four_times, 0x04

	;--> for loop count in loop_5
	.def three_times = r29
	ldi three_times, 0x03

	;--> for loop count in loop_6
	.def two_times = r30
	ldi two_times, 0x02

	
	; ==========================================
	ldi value1, 0xA1 ;we don't need to lsr 
    and value1, mask ;the first time
	loop_1: 
	      lsl value1 
		  dec seven_times
		  cpi seven_times, 0x00
		  brne loop_1

    ; ==========================================
	ldi value2, 0xA1
	lsr value2 ;lsr 1 time
	and value2, mask
	loop_2:
	      lsl value2
		  dec six_times
	      cpi six_times, 0x00
		  brne loop_2

    ; ==========================================
	ldi value3, 0xA1
	lsr value3 ;lsr 2 times
	lsr value3
	and value3, mask
	loop_3:
	      lsl value3
		  dec five_times
		  cpi five_times, 0x00
		  brne loop_3

    ; ==========================================
	ldi value4, 0xA1
	lsr value4 ;lsr 3 times
	lsr value4
	lsr value4 
	and value4, mask
	loop_4:
	      lsl value4
		  dec four_times
		  cpi four_times, 0x00
		  brne loop_4

    ;==========================================
	ldi value5, 0xA1
	lsr value5 ;lsr 4 times
	lsr value5
	lsr value5
	lsr value5
	and value5, mask
	loop_5:
	      lsl value5
		  dec three_times
		  cpi three_times, 0x00
		  brne loop_5

    ;==========================================
	ldi value6, 0xA1
	lsr value6 ;lsr 5 times
	lsr value6
	lsr value6
	lsr value6
	lsr value6
	and value6, mask
	loop_6:
	      lsl value6
		  dec two_times
		  cpi two_times, 0x00
		  brne loop_6

    ;==========================================
	ldi value7, 0xA1
	lsr value7 ;lsr 6 times
	lsr value7
	lsr value7
	lsr value7
	lsr value7
	lsr value7
	and value7, mask
	lsl value7 ;just one lsl needed so loop
	;-----------is not needed

	;==========================================
	ldi value8, 0xA1
	lsr value8 ;lsr 7 times
	lsr value8
	lsr value8
	lsr value8
	lsr value8
	lsr value8
	lsr value8 ;no lsl needed 

	;==========================================
	;Adding all the values (registers) to 
	;get the complete reverse of the byte

	add value7, value8 ;v7+v8
	add value6, value7 ;v7+v8+v6
	add value5, value6 ;v7+v8+v6+v5
	add value4, value5 ;v7+v8+v6+v5+v4
	add value3, value4 ;v7+v8+v6+v5+v4+v3
	add value2, value3 ;v7+v8+v6+v5+v4+v3+v2
	add value1, value2 ;v7+v8+v6+v5+v4+v3+v2+v1
	;==========================================

   

	sts OUT2, value1

	;>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<
	;>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<


	;===========================================
	;==========Reversing the byte 0x74==========
    ;===========================================

	 lds value1, IN2

    ;--> Giving the mask a name
	;.def mask = r17
	ldi mask, 0x01

	;--> for loop count in loop_1
	;.def seven_times = r19
	ldi seven_times, 0x07

	;--> for loop count in loop_2
	;.def six_times = r20
	ldi six_times, 0x06

	;;--> for loop count in loop_3
	;.def five_times = r21
	ldi five_times, 0x05

	;--> for loop count in loop_4
	;.def four_times = r21
	ldi four_times, 0x04

	;--> for loop count in loop_5
	;.def three_times = r21
	ldi three_times, 0x03

	;--> for loop count in loop_6
	;.def two_times = r21
	ldi two_times, 0x02

	
	; ==========================================
	ldi value1, 0x74 ;we don't need to lsr 
    and value1, mask ;the first time
	loop_a: 
	      lsl value1 
		  dec seven_times
		  cpi seven_times, 0x00
		  brne loop_a

    ; ==========================================
	ldi value2, 0x74
	lsr value2 ;lsr 1 time
	and value2, mask
	loop_b:
	      lsl value2
		  dec six_times
	      cpi six_times, 0x00
		  brne loop_b

    ; ==========================================
	ldi value3, 0x74
	lsr value3 ;lsr 2 times
	lsr value3
	and value3, mask
	loop_c:
	      lsl value3
		  dec five_times
		  cpi five_times, 0x00
		  brne loop_c

    ; ==========================================
	ldi value4, 0x74
	lsr value4 ;lsr 3 times
	lsr value4
	lsr value4 
	and value4, mask
	loop_d:
	      lsl value4
		  dec four_times
		  cpi four_times, 0x00
		  brne loop_d

    ;==========================================
	ldi value5, 0x74
	lsr value5 ;lsr 4 times
	lsr value5
	lsr value5
	lsr value5
	and value5, mask
	loop_e:
	      lsl value5
		  dec three_times
		  cpi three_times, 0x00
		  brne loop_e

    ;==========================================
	ldi value6, 0x74
	lsr value6 ;lsr 5 times
	lsr value6
	lsr value6
	lsr value6
	lsr value6
	and value6, mask
	loop_f:
	      lsl value6
		  dec two_times
		  cpi two_times, 0x00
		  brne loop_f

    ;==========================================
	ldi value7, 0x74
	lsr value7 ;lsr 6 times
	lsr value7
	lsr value7
	lsr value7
	lsr value7
	lsr value7
	and value7, mask
	lsl value7 ;just one lsl needed so loop
	;-----------is not needed

	;==========================================
	ldi value8, 0x74
	lsr value8 ;lsr 7 times
	lsr value8
	lsr value8
	lsr value8
	lsr value8
	lsr value8
	lsr value8 ;no lsl needed 
	and value8, mask

	;==========================================
	;Adding all the values (registers) to 
	;get the complete reverse of the byte

	ADD value7, value8 ;v7+v8
	ADD value6, value7 ;v7+v8+v6
	ADD value5, value6 ;v7+v8+v6+v5
	ADD value4, value5 ;v7+v8+v6+v5+v4
	ADD value3, value4 ;v7+v8+v6+v5+v4+v3
	ADD value2, value3 ;v7+v8+v6+v5+v4+v3+v2
	ADD value1, value2 ;v7+v8+v6+v5+v4+v3+v2+v1
	;==========================================

   

	sts OUT1, value1





	; This code only swaps the order of the bytes from the
    ; input word to the output word. This clearly isn't enough
    ; so you may modify or delete these lines as you wish.
    ;
    ;lds R16, IN1

	;sts OUT2, R16

    ;lds R16, IN2

	;sts OUT1, R16

    loop_stop_now:
	      ldi r31, 0x00
		  cpi r31,0x00
		  breq stop








	



	    



; **** END OF "STUDENT CODE" SECTION ********** 



; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
stop:
    rjmp stop

    .dseg
    .org 0x200
IN1:	.byte 1
IN2:	.byte 1
OUT1:	.byte 1
OUT2:	.byte 1
; ==== END OF "DO NOT TOUCH" SECTION ==========
