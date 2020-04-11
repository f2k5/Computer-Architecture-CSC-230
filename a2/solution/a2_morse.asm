; a2_morse.asm
; CSC 230: Spring 2018
;
; Student name: Fardin Khan
; Student ID: V00876483 
; Date of completed work: March 4th, 2018
;
; *******************************
; Code provided for Assignment #2
;
; Author: Mike Zastre (2018-Feb-10)
; 
; This skeleton of an assembly-language program is provided to help you
; begin with the programming tasks for A#2. As with A#1, there are 
; "DO NOT TOUCH" sections. You are *not* to modify the lines
; within these sections. The only exceptions are for specific
; changes announced on conneX or in written permission from the course
; instructor. *** Unapproved changes could result in incorrect code
; execution during assignment evaluation, along with an assignment grade
; of zero. ****
;
; I have added for this assignment an additional kind of section
; called "TOUCH CAREFULLY". The intention here is that one or two
; constants can be changed in such a section -- this will be needed
; as you try to test your code on different messages.
;


; =============================================
; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
; =============================================

.include "m2560def.inc"

.cseg
.equ S_DDRB=0x24
.equ S_PORTB=0x25
.equ S_DDRL=0x10A
.equ S_PORTL=0x10B

	
.org 0
	; Copy test encoding (of SOS) into SRAM
	;
	ldi ZH, high(TESTBUFFER)
	ldi ZL, low(TESTBUFFER)
	ldi r16, 0x30
	st Z+, r16
	ldi r16, 0x37
	st Z+, r16
	ldi r16, 0x30
	st Z+, r16
	clr r16
	st Z, r16

	; initialize run-time stack
	ldi r17, high(0x21ff)
	ldi r16, low(0x21ff)
	out SPH, r17
	out SPL, r16

	; initialize LED ports to output
	ldi r17, 0xff
	sts S_DDRB, r17
	sts S_DDRL, r17

; =======================================
; ==== END OF "DO NOT TOUCH" SECTION ====
; =======================================

; ***************************************************
; **** BEGINNING OF FIRST "STUDENT CODE" SECTION **** 
; ***************************************************

	; If you're not yet ready to execute the
	; encoding and flashing, then leave the
	; rjmp in below. Otherwise delete it or
	; comment it out.

	;rjmp stop

    ; The following seven lines are only for testing of your
    ; code in part B. When you are confident that your part B
    ; is working, you can then delete these seven lines. 

    ;====code related to part.a=============================>
	;pushing the first parameter onto stack 

	;ldi r16, 2
	;call leds_on

    ;=======================================================>
	ldi r17, high(TESTBUFFER)
	ldi r16, low(TESTBUFFER)
	push r17
	push r16
	rcall flash_message
  	pop r16
   	pop r17
   
   ; rjmp stop
; ***************************************************
; **** END OF FIRST "STUDENT CODE" SECTION ********** 
; ***************************************************


; ################################################
; #### BEGINNING OF "TOUCH CAREFULLY" SECTION ####
; ################################################

; The only things you can change in this section is
; the message (i.e., MESSAGE01 or MESSAGE02 or MESSAGE03,
; etc., up to MESSAGE09).
;

	; encode a message
	;
	ldi r17, high(MESSAGE02 << 1)
	ldi r16, low(MESSAGE02 << 1)
	push r17
	push r16
	ldi r17, high(BUFFER01)
	ldi r16, low(BUFFER01)
	push r17
	push r16
	rcall encode_message
	pop r16
	pop r16
	pop r16
	pop r16

; ##########################################
; #### END OF "TOUCH CAREFULLY" SECTION ####
; ##########################################


; =============================================
; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
; =============================================
	; display the message three times
	;
	ldi r18, 3
main_loop:
	ldi r17, high(BUFFER01)
	ldi r16, low(BUFFER01)
	push r17
	push r16
	rcall flash_message
	dec r18
	tst r18
	brne main_loop


stop:
	rjmp stop
; =======================================
; ==== END OF "DO NOT TOUCH" SECTION ====
; =======================================


; ****************************************************
; **** BEGINNING OF SECOND "STUDENT CODE" SECTION **** 
; ****************************************************


flash_message:
	push r16 
	push r31
	push r30
	push r29 
	push r28 

    ;putting stack pointer into Y 
	in YH, SPH 
	in YL, SPL

	;getting the 1st param pushed on stack 
	ldd ZH, Y+10
	ldd ZL, Y+9


	loop_until_null:
	    lpm r16, Z+
		call morse_flash 
		tst r16 
		brne loop_until_null

    ;loop_until_null:
	;    lpm r16, Z+
     ;   tst r16
	;	breq donzo
	;	call morse_flash
	;	rjmp loop_until_null
	
	donzo:
		pop r28
    	pop r29
     	pop r30
    	pop r31
		pop r16
	 	ret


morse_flash:
	push r17
	push r19 

	
   cpi r16, 0xff
   brne not_space 
   call space 
  ; jmp morse_flash_finish
   ret 

   not_space: 
   mov r17, r16 
   mov r19, r16

   swap r17
   andi r17, 0x0f 
   ;Now r17 has the no. of seq
   ;in lower nibble 

   andi r19, 0x0f 
   ;Now r19 has the seq
   ;in lower nibble as well

   push r16 
   cpi r17, 4
   breq check_four_bits
   check_four_bits:
       ldi r16, 2
       sbrc r19, 3
       call dash   ;if bit 3 is 1, call dash 
       call dot    ;if bit 3 is 0, call dot 
       lsl r19
       dec r17
       cpi r17, 0
       brne check_four_bits 
   pop r16 

   push r16
   cpi r17, 3
   breq check_three_bits 
   check_three_bits:
       ldi r16, 2
       sbrc r19, 2
       call dash   ;if bit 2 is 1, call dash 
       call dot    ;if bit 2 is 0, call dot 
       lsl r19
       dec r17
       cpi r17, 0
       brne check_three_bits 
   pop r16

   push r16 
   cpi r17, 2
   breq check_two_bits
   check_two_bits:
       ldi r16, 2
       sbrc r19, 1
       call dash   ;if bit 1 is 1, call dash 
       call dot    ;if bit 1 is 0, call dot 
       lsl r19
       dec r17
       cpi r17, 0
       brne check_two_bits 
   pop r16

   push r16
   cpi r17, 1
   breq check_last_bit
   check_last_bit:
       ldi r16, 2
       sbrc r19, 0
       call dash   ;if bit 0 is 1, call dash 
       call dot    ;if bit 0 is 0, call dot 
   pop r16

        pop r19
		pop r17
	    ret 

dot: 
   call leds_on
   call delay_short
   call leds_off 
   call delay_long
   ret  

dash:
   call leds_on
   call delay_long 
   call leds_off
   call delay_long 
   ret 

space:
   call leds_off
   call delay_long
   call delay_long
   call delay_long 
   ret 

leds_on:
   cpi r16, 1
   brne led2
   ldi r16, 0b10000000
   sts S_PORTL, r16
   ldi r16, 0b00000000
   sts S_PORTB, r16
   ret

   led2:
   cpi r16, 2
   brne led3
   ldi r16, 0b10100000
   sts S_PORTL, r16
   ldi r16, 0b00000000
   sts S_PORTB, r16
   ret 

   led3:
   cpi r16, 3
   brne led4
   ldi r16, 0b10101000
   sts S_PORTL, r16
   ldi r16, 0b00000000
   sts S_PORTB, r16
   ret 

   led4:
   cpi r16, 4
   brne led5
   ldi r16, 0b10101010
   sts S_PORTL, r16
   ldi r16, 0b00000000
   sts S_PORTB, r16
   ret 

   led5:
   cpi r16, 5
   brne led6
   ldi r16, 0b10101010
   sts S_PORTL, r16
   ldi r16, 0b00001000
   sts S_PORTB, r16
   ret 

   led6:
   cpi r16, 6
   brne leds_off
   ldi r16, 0b10101010
   sts S_PORTL, r16
   ldi r16, 0b00001010
   sts S_PORTB, r16
   ret 


leds_off:
    ldi r16, 0x00
	sts S_PORTL, r16
	ldi r16, 0x00
	sts S_PORTB, r16
	ret 



encode_message:

    push r17 
	push r18
	push r19
	push r16 
	push r29 
	push r28 
	push r31 
	push r30 

	in ZH, SPH
	in ZL, SPL 

	ldi r19, 8
	ldi r18, 0
	
	read_each_char:
	     lpm r16, Z 
		 call letter_to_code 
		 add ZL, r19
		 adc ZH, r18
		 sts BUFFER01, r16
		 cpi r16, 0
		 brne read_each_char 

    ;in 

ret	



letter_to_code:

    push r16 
	push r17 ;
	push r31
	push r30 

	in ZH, SPH 
	in ZL, SPL 

	Cool_loop:
	    lpm r16, Z 
	    tst r16 
	    brne loop2
		   loop2: 
	       inc r16 
		   tst r16
		   brne check_for_letters
		   
           check_for_letters: 
		   cpi r16, 65 ;for A 
		   brne its_B
		   ldi r22, 0b00100001


		   its_B:
		   cpi r16, 66
		   brne its_C 
		   ldi r22, 0b01001000


           its_C:
		   cpi r16, 67
		   brne its_D
		   ldi r22, 0b01001010


		   its_D:
		   cpi r16, 68
		   brne its_E
		   ldi r22, 0b00110100


		   its_E:
		   cpi r16, 69
		   brne its_F
		   ldi r22, 0b00010000


		   its_F:
		   cpi r16, 70
		   brne its_G
		   ldi r22, 0b01000010


		   its_G:
		   cpi r16, 71
		   brne its_H
		   ldi r22, 0b00110110

		   its_H:
		   cpi r16, 72 
		   brne its_I
		   ldi r22, 0b01000000

		   its_I:
		   cpi r16, 73
		   brne its_J
		   ldi r22, 0b00100000

		   its_J:
		   cpi r16, 74
		   brne its_K
		   ldi r22, 0b01000111

		   its_K:
		   cpi r16, 75
		   brne its_L
		   ldi r22, 0b01001010


		   its_L:
		   cpi r16, 76
		   brne its_M
		   ldi r22, 0b01000100


		   its_M:
		   cpi r16, 77
		   brne its_N
		   ldi r22, 0b00100011

		   its_N:
		   cpi r16, 78
		   brne its_O
		   ldi r22, 0b00100010
           
           its_O:
		   cpi r16, 79
		   brne its_P
		   ldi r22, 0b00110111
           
           its_P:
		   cpi r16, 80
		   brne its_Q
		   ldi r22, 0b01000110
           
           its_Q:
           cpi r16, 81
		   brne its_R
		   ldi r22, 0b01001101
           
           its_R:
           cpi r16, 82
		   brne its_S
		   ldi r22, 0b00110010
           
           its_S:
           cpi r16, 83
		   brne its_T
		   ldi r22, 0b00110000
           
           its_T:
           cpi r16, 84
		   brne its_U
		   ldi r22, 0b00010001
           
           its_U:
           cpi r16, 85
		   brne its_V
		   ldi r22, 0b00110001
           
           its_V:
           cpi r16, 86
		   brne its_W
		   ldi r22, 0b01000001
           
           its_W:
           cpi r16, 87
		   brne its_X
		   ldi r22, 0b00110011
           
           its_X:
           cpi r16, 88
		   brne its_Y
		   ldi r22, 0b01001001
           
           its_Y:
           cpi r16, 89
		   brne its_Z
		   ldi r22, 0b01001011
           
           its_Z:
           cpi r16, 90
		   brne nop
		   ldi r22, 0b01001100
           
           mov r0, r22
           
           ret

; **********************************************
; **** END OF SECOND "STUDENT CODE" SECTION **** 
; **********************************************


; =============================================
; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
; =============================================

delay_long:
	rcall delay
	rcall delay
	rcall delay
	ret

delay_short:
	rcall delay
	ret

; When wanting about a 1/5th of second delay, all other
; code must call this function
;
delay:
	rcall delay_busywait
	ret


; This function is ONLY called from "delay", and
; never directly from other code.
;
delay_busywait:
	push r16
	push r17
	push r18

	ldi r16, 0x08
delay_busywait_loop1:
	dec r16
	breq delay_busywait_exit
	
	ldi r17, 0xff
delay_busywait_loop2:
	dec	r17
	breq delay_busywait_loop1

	ldi r18, 0xff
delay_busywait_loop3:
	dec r18
	breq delay_busywait_loop2
	rjmp delay_busywait_loop3

delay_busywait_exit:
	pop r18
	pop r17
	pop r16
	ret



;.org 0x1000

ITU_MORSE: .db "A", ".-", 0, 0, 0, 0, 0
	.db "B", "-...", 0, 0, 0
	.db "C", "-.-.", 0, 0, 0
	.db "D", "-..", 0, 0, 0, 0
	.db "E", ".", 0, 0, 0, 0, 0, 0
	.db "F", "..-.", 0, 0, 0
	.db "G", "--.", 0, 0, 0, 0
	.db "H", "....", 0, 0, 0
	.db "I", "..", 0, 0, 0, 0, 0
	.db "J", ".---", 0, 0, 0
	.db "K", "-.-.", 0, 0, 0
	.db "L", ".-..", 0, 0, 0
	.db "M", "--", 0, 0, 0, 0, 0
	.db "N", "-.", 0, 0, 0, 0, 0
	.db "O", "---", 0, 0, 0, 0
	.db "P", ".--.", 0, 0, 0
	.db "Q", "--.-", 0, 0, 0
	.db "R", ".-.", 0, 0, 0, 0
	.db "S", "...", 0, 0, 0, 0
	.db "T", "-", 0, 0, 0, 0, 0, 0
	.db "U", "..-", 0, 0, 0, 0
	.db "V", "...-", 0, 0, 0
	.db "W", ".--", 0, 0, 0, 0
	.db "X", "-..-", 0, 0, 0
	.db "Y", "-.--", 0, 0, 0
	.db "Z", "--..", 0, 0, 0
	.db 0, 0, 0, 0, 0, 0, 0, 0

MESSAGE01: .db "A A A", 0
MESSAGE02: .db "SOS", 0
MESSAGE03: .db "A BOX", 0
MESSAGE04: .db "DAIRY QUEEN", 0
MESSAGE05: .db "THE SHAPE OF WATER", 0, 0
MESSAGE06: .db "DARKEST HOUR", 0, 0
MESSAGE07: .db "THREE BILLBOARDS OUTSIDE EBBING MISSOURI", 0, 0
MESSAGE08: .db "OH CANADA OUR OWN AND NATIVE LAND", 0
MESSAGE09: .db "I CAN HAZ CHEEZBURGER", 0

; First message ever sent by Morse code (in 1844)
MESSAGE10: .db "WHAT GOD HATH WROUGHT", 0


.dseg
.org 0x200
BUFFER01: .byte 128
BUFFER02: .byte 128
TESTBUFFER: .byte 4

; =======================================
; ==== END OF "DO NOT TOUCH" SECTION ====
; =======================================
