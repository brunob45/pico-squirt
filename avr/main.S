
main.elf:     file format elf32-avr


Disassembly of section .text:

00000000 <__vectors>:
   0:	0c 94 48 00 	jmp	0x90	; 0x90 <__ctors_end>
   4:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
   8:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
   c:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  10:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  14:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  18:	0c 94 5c 00 	jmp	0xb8	; 0xb8 <__vector_6>
  1c:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  20:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  24:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  28:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  2c:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  30:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  34:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  38:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  3c:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  40:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  44:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  48:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  4c:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  50:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  54:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  58:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  5c:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  60:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  64:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  68:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  6c:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  70:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  74:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  78:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  7c:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  80:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  84:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  88:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>
  8c:	0c 94 5a 00 	jmp	0xb4	; 0xb4 <__bad_interrupt>

00000090 <__ctors_end>:
  90:	11 24       	eor	r1, r1
  92:	1f be       	out	0x3f, r1	; 63
  94:	cf ef       	ldi	r28, 0xFF	; 255
  96:	cd bf       	out	0x3d, r28	; 61
  98:	df e7       	ldi	r29, 0x7F	; 127
  9a:	de bf       	out	0x3e, r29	; 62

0000009c <__do_clear_bss>:
  9c:	28 e7       	ldi	r18, 0x78	; 120
  9e:	a0 e0       	ldi	r26, 0x00	; 0
  a0:	b8 e7       	ldi	r27, 0x78	; 120
  a2:	01 c0       	rjmp	.+2      	; 0xa6 <.do_clear_bss_start>

000000a4 <.do_clear_bss_loop>:
  a4:	1d 92       	st	X+, r1

000000a6 <.do_clear_bss_start>:
  a6:	a4 30       	cpi	r26, 0x04	; 4
  a8:	b2 07       	cpc	r27, r18
  aa:	e1 f7       	brne	.-8      	; 0xa4 <.do_clear_bss_loop>
  ac:	0e 94 84 00 	call	0x108	; 0x108 <main>
  b0:	0c 94 2b 01 	jmp	0x256	; 0x256 <_exit>

000000b4 <__bad_interrupt>:
  b4:	0c 94 00 00 	jmp	0	; 0x0 <__vectors>

000000b8 <__vector_6>:
  b8:	1f 92       	push	r1
  ba:	0f 92       	push	r0
  bc:	0f b6       	in	r0, 0x3f	; 63
  be:	0f 92       	push	r0
  c0:	11 24       	eor	r1, r1
  c2:	8f 93       	push	r24
  c4:	9f 93       	push	r25
  c6:	af 93       	push	r26
  c8:	bf 93       	push	r27
  ca:	81 e0       	ldi	r24, 0x01	; 1
  cc:	80 93 53 01 	sts	0x0153, r24	; 0x800153 <_ZL10ADC_INPUTS+0x7f7ef9>
  d0:	80 91 00 78 	lds	r24, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
  d4:	90 91 01 78 	lds	r25, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
  d8:	a0 91 02 78 	lds	r26, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
  dc:	b0 91 03 78 	lds	r27, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
  e0:	01 96       	adiw	r24, 0x01	; 1
  e2:	a1 1d       	adc	r26, r1
  e4:	b1 1d       	adc	r27, r1
  e6:	80 93 00 78 	sts	0x7800, r24	; 0x807800 <__DATA_REGION_ORIGIN__>
  ea:	90 93 01 78 	sts	0x7801, r25	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
  ee:	a0 93 02 78 	sts	0x7802, r26	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
  f2:	b0 93 03 78 	sts	0x7803, r27	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
  f6:	bf 91       	pop	r27
  f8:	af 91       	pop	r26
  fa:	9f 91       	pop	r25
  fc:	8f 91       	pop	r24
  fe:	0f 90       	pop	r0
 100:	0f be       	out	0x3f, r0	; 63
 102:	0f 90       	pop	r0
 104:	1f 90       	pop	r1
 106:	18 95       	reti

00000108 <main>:
 108:	80 e4       	ldi	r24, 0x40	; 64
 10a:	80 93 01 04 	sts	0x0401, r24	; 0x800401 <_ZL10ADC_INPUTS+0x7f81a7>
 10e:	88 ed       	ldi	r24, 0xD8	; 216
 110:	84 bf       	out	0x34, r24	; 52
 112:	84 e2       	ldi	r24, 0x24	; 36
 114:	80 93 68 00 	sts	0x0068, r24	; 0x800068 <_ZL10ADC_INPUTS+0x7f7e0e>
 118:	80 91 68 00 	lds	r24, 0x0068	; 0x800068 <_ZL10ADC_INPUTS+0x7f7e0e>
 11c:	81 ff       	sbrs	r24, 1
 11e:	fc cf       	rjmp	.-8      	; 0x118 <main+0x10>
 120:	10 92 47 01 	sts	0x0147, r1	; 0x800147 <_ZL10ADC_INPUTS+0x7f7eed>
 124:	81 e0       	ldi	r24, 0x01	; 1
 126:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7ef8>
 12a:	21 e2       	ldi	r18, 0x21	; 33
 12c:	20 93 50 01 	sts	0x0150, r18	; 0x800150 <_ZL10ADC_INPUTS+0x7f7ef6>
 130:	45 e0       	ldi	r20, 0x05	; 5
 132:	40 93 b0 00 	sts	0x00B0, r20	; 0x8000b0 <_ZL10ADC_INPUTS+0x7f7e56>
 136:	32 e0       	ldi	r19, 0x02	; 2
 138:	30 93 01 06 	sts	0x0601, r19	; 0x800601 <_ZL10ADC_INPUTS+0x7f83a7>
 13c:	26 e0       	ldi	r18, 0x06	; 6
 13e:	20 93 02 06 	sts	0x0602, r18	; 0x800602 <_ZL10ADC_INPUTS+0x7f83a8>
 142:	80 93 08 06 	sts	0x0608, r24	; 0x800608 <_ZL10ADC_INPUTS+0x7f83ae>
 146:	20 91 00 06 	lds	r18, 0x0600	; 0x800600 <_ZL10ADC_INPUTS+0x7f83a6>
 14a:	21 60       	ori	r18, 0x01	; 1
 14c:	20 93 00 06 	sts	0x0600, r18	; 0x800600 <_ZL10ADC_INPUTS+0x7f83a6>
 150:	e7 e5       	ldi	r30, 0x57	; 87
 152:	f2 e0       	ldi	r31, 0x02	; 2
 154:	31 97       	sbiw	r30, 0x01	; 1
 156:	f1 f7       	brne	.-4      	; 0x154 <main+0x4c>
 158:	00 c0       	rjmp	.+0      	; 0x15a <main+0x52>
 15a:	00 00       	nop
 15c:	80 93 0a 06 	sts	0x060A, r24	; 0x80060a <_ZL10ADC_INPUTS+0x7f83b0>
 160:	40 93 e5 05 	sts	0x05E5, r20	; 0x8005e5 <_ZL10ADC_INPUTS+0x7f838b>
 164:	30 93 41 04 	sts	0x0441, r19	; 0x800441 <_ZL10ADC_INPUTS+0x7f81e7>
 168:	2d e0       	ldi	r18, 0x0D	; 13
 16a:	20 93 42 04 	sts	0x0442, r18	; 0x800442 <_ZL10ADC_INPUTS+0x7f81e8>
 16e:	80 93 40 09 	sts	0x0940, r24	; 0x800940 <_ZL10ADC_INPUTS+0x7f86e6>
 172:	88 ed       	ldi	r24, 0xD8	; 216
 174:	a8 95       	wdr
 176:	84 bf       	out	0x34, r24	; 52
 178:	80 91 00 01 	lds	r24, 0x0100	; 0x800100 <_ZL10ADC_INPUTS+0x7f7ea6>
 17c:	84 60       	ori	r24, 0x04	; 4
 17e:	80 93 00 01 	sts	0x0100, r24	; 0x800100 <_ZL10ADC_INPUTS+0x7f7ea6>
 182:	80 91 01 01 	lds	r24, 0x0101	; 0x800101 <_ZL10ADC_INPUTS+0x7f7ea7>
 186:	81 fd       	sbrc	r24, 1
 188:	fc cf       	rjmp	.-8      	; 0x182 <main+0x7a>
 18a:	78 94       	sei
 18c:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <_ZL10ADC_INPUTS+0x7f7ef8>
 190:	8e 7f       	andi	r24, 0xFE	; 254
 192:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7ef8>
 196:	c0 90 00 78 	lds	r12, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 19a:	d0 90 01 78 	lds	r13, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 19e:	e0 90 02 78 	lds	r14, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 1a2:	f0 90 03 78 	lds	r15, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 1a6:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <_ZL10ADC_INPUTS+0x7f7ef8>
 1aa:	81 60       	ori	r24, 0x01	; 1
 1ac:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7ef8>
 1b0:	c0 e4       	ldi	r28, 0x40	; 64
 1b2:	b1 e0       	ldi	r27, 0x01	; 1
 1b4:	a0 e8       	ldi	r26, 0x80	; 128
 1b6:	a8 95       	wdr
 1b8:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <_ZL10ADC_INPUTS+0x7f7ef8>
 1bc:	8e 7f       	andi	r24, 0xFE	; 254
 1be:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7ef8>
 1c2:	40 91 00 78 	lds	r20, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 1c6:	50 91 01 78 	lds	r21, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 1ca:	60 91 02 78 	lds	r22, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 1ce:	70 91 03 78 	lds	r23, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 1d2:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <_ZL10ADC_INPUTS+0x7f7ef8>
 1d6:	81 60       	ori	r24, 0x01	; 1
 1d8:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7ef8>
 1dc:	8a 01       	movw	r16, r20
 1de:	9b 01       	movw	r18, r22
 1e0:	0c 19       	sub	r16, r12
 1e2:	1d 09       	sbc	r17, r13
 1e4:	2e 09       	sbc	r18, r14
 1e6:	3f 09       	sbc	r19, r15
 1e8:	05 3f       	cpi	r16, 0xF5	; 245
 1ea:	11 40       	sbci	r17, 0x01	; 1
 1ec:	21 05       	cpc	r18, r1
 1ee:	31 05       	cpc	r19, r1
 1f0:	20 f0       	brcs	.+8      	; 0x1fa <main+0xf2>
 1f2:	c0 93 07 04 	sts	0x0407, r28	; 0x800407 <_ZL10ADC_INPUTS+0x7f81ad>
 1f6:	6a 01       	movw	r12, r20
 1f8:	7b 01       	movw	r14, r22
 1fa:	80 91 0d 06 	lds	r24, 0x060D	; 0x80060d <_ZL10ADC_INPUTS+0x7f83b3>
 1fe:	80 ff       	sbrs	r24, 0
 200:	da cf       	rjmp	.-76     	; 0x1b6 <main+0xae>
 202:	b0 93 0d 06 	sts	0x060D, r27	; 0x80060d <_ZL10ADC_INPUTS+0x7f83b3>
 206:	e9 2f       	mov	r30, r25
 208:	f0 e0       	ldi	r31, 0x00	; 0
 20a:	e6 5a       	subi	r30, 0xA6	; 166
 20c:	fd 47       	sbci	r31, 0x7D	; 125
 20e:	80 81       	ld	r24, Z
 210:	20 91 10 06 	lds	r18, 0x0610	; 0x800610 <_ZL10ADC_INPUTS+0x7f83b6>
 214:	30 91 11 06 	lds	r19, 0x0611	; 0x800611 <_ZL10ADC_INPUTS+0x7f83b7>
 218:	9f 5f       	subi	r25, 0xFF	; 255
 21a:	97 30       	cpi	r25, 0x07	; 7
 21c:	09 f4       	brne	.+2      	; 0x220 <main+0x118>
 21e:	90 e0       	ldi	r25, 0x00	; 0
 220:	b0 93 0a 06 	sts	0x060A, r27	; 0x80060a <_ZL10ADC_INPUTS+0x7f83b0>
 224:	80 93 44 09 	sts	0x0944, r24	; 0x800944 <_ZL10ADC_INPUTS+0x7f86ea>
 228:	80 91 43 09 	lds	r24, 0x0943	; 0x800943 <_ZL10ADC_INPUTS+0x7f86e9>
 22c:	87 ff       	sbrs	r24, 7
 22e:	fc cf       	rjmp	.-8      	; 0x228 <main+0x120>
 230:	a0 93 43 09 	sts	0x0943, r26	; 0x800943 <_ZL10ADC_INPUTS+0x7f86e9>
 234:	20 93 44 09 	sts	0x0944, r18	; 0x800944 <_ZL10ADC_INPUTS+0x7f86ea>
 238:	80 91 43 09 	lds	r24, 0x0943	; 0x800943 <_ZL10ADC_INPUTS+0x7f86e9>
 23c:	87 ff       	sbrs	r24, 7
 23e:	fc cf       	rjmp	.-8      	; 0x238 <main+0x130>
 240:	a0 93 43 09 	sts	0x0943, r26	; 0x800943 <_ZL10ADC_INPUTS+0x7f86e9>
 244:	30 93 44 09 	sts	0x0944, r19	; 0x800944 <_ZL10ADC_INPUTS+0x7f86ea>
 248:	80 91 43 09 	lds	r24, 0x0943	; 0x800943 <_ZL10ADC_INPUTS+0x7f86e9>
 24c:	87 ff       	sbrs	r24, 7
 24e:	fc cf       	rjmp	.-8      	; 0x248 <main+0x140>
 250:	a0 93 43 09 	sts	0x0943, r26	; 0x800943 <_ZL10ADC_INPUTS+0x7f86e9>
 254:	b0 cf       	rjmp	.-160    	; 0x1b6 <main+0xae>

00000256 <_exit>:
 256:	f8 94       	cli

00000258 <__stop_program>:
 258:	ff cf       	rjmp	.-2      	; 0x258 <__stop_program>
