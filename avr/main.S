
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
  50:	0c 94 84 00 	jmp	0x108	; 0x108 <__vector_20>
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
  a6:	a7 30       	cpi	r26, 0x07	; 7
  a8:	b2 07       	cpc	r27, r18
  aa:	e1 f7       	brne	.-8      	; 0xa4 <.do_clear_bss_loop>
  ac:	0e 94 d8 00 	call	0x1b0	; 0x1b0 <main>
  b0:	0c 94 3b 01 	jmp	0x276	; 0x276 <_exit>

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
  cc:	80 93 53 01 	sts	0x0153, r24	; 0x800153 <__RODATA_PM_OFFSET__+0x7f8153>
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

00000108 <__vector_20>:
 108:	1f 92       	push	r1
 10a:	0f 92       	push	r0
 10c:	0f b6       	in	r0, 0x3f	; 63
 10e:	0f 92       	push	r0
 110:	11 24       	eor	r1, r1
 112:	8f 93       	push	r24
 114:	9f 93       	push	r25
 116:	80 e8       	ldi	r24, 0x80	; 128
 118:	80 93 43 09 	sts	0x0943, r24	; 0x800943 <__RODATA_PM_OFFSET__+0x7f8943>
 11c:	80 91 06 78 	lds	r24, 0x7806	; 0x807806 <_ZZ11__vector_20E4step>
 120:	81 30       	cpi	r24, 0x01	; 1
 122:	49 f1       	breq	.+82     	; 0x176 <__vector_20+0x6e>
 124:	78 f0       	brcs	.+30     	; 0x144 <__vector_20+0x3c>
 126:	82 30       	cpi	r24, 0x02	; 2
 128:	31 f4       	brne	.+12     	; 0x136 <__vector_20+0x2e>
 12a:	80 91 05 78 	lds	r24, 0x7805	; 0x807805 <_ZZ11__vector_20E3res+0x1>
 12e:	80 93 44 09 	sts	0x0944, r24	; 0x800944 <__RODATA_PM_OFFSET__+0x7f8944>
 132:	10 92 06 78 	sts	0x7806, r1	; 0x807806 <_ZZ11__vector_20E4step>
 136:	9f 91       	pop	r25
 138:	8f 91       	pop	r24
 13a:	0f 90       	pop	r0
 13c:	0f be       	out	0x3f, r0	; 63
 13e:	0f 90       	pop	r0
 140:	1f 90       	pop	r1
 142:	18 95       	reti
 144:	80 91 44 09 	lds	r24, 0x0944	; 0x800944 <__RODATA_PM_OFFSET__+0x7f8944>
 148:	80 93 08 06 	sts	0x0608, r24	; 0x800608 <__RODATA_PM_OFFSET__+0x7f8608>
 14c:	80 91 08 06 	lds	r24, 0x0608	; 0x800608 <__RODATA_PM_OFFSET__+0x7f8608>
 150:	88 23       	and	r24, r24
 152:	41 f0       	breq	.+16     	; 0x164 <__vector_20+0x5c>
 154:	80 e4       	ldi	r24, 0x40	; 64
 156:	80 93 05 04 	sts	0x0405, r24	; 0x800405 <__RODATA_PM_OFFSET__+0x7f8405>
 15a:	81 e0       	ldi	r24, 0x01	; 1
 15c:	80 93 0a 06 	sts	0x060A, r24	; 0x80060a <__RODATA_PM_OFFSET__+0x7f860a>
 160:	80 93 06 78 	sts	0x7806, r24	; 0x807806 <_ZZ11__vector_20E4step>
 164:	10 92 44 09 	sts	0x0944, r1	; 0x800944 <__RODATA_PM_OFFSET__+0x7f8944>
 168:	9f 91       	pop	r25
 16a:	8f 91       	pop	r24
 16c:	0f 90       	pop	r0
 16e:	0f be       	out	0x3f, r0	; 63
 170:	0f 90       	pop	r0
 172:	1f 90       	pop	r1
 174:	18 95       	reti
 176:	90 91 0d 06 	lds	r25, 0x060D	; 0x80060d <__RODATA_PM_OFFSET__+0x7f860d>
 17a:	90 ff       	sbrs	r25, 0
 17c:	f3 cf       	rjmp	.-26     	; 0x164 <__vector_20+0x5c>
 17e:	90 e4       	ldi	r25, 0x40	; 64
 180:	90 93 06 04 	sts	0x0406, r25	; 0x800406 <__RODATA_PM_OFFSET__+0x7f8406>
 184:	80 93 0d 06 	sts	0x060D, r24	; 0x80060d <__RODATA_PM_OFFSET__+0x7f860d>
 188:	80 91 10 06 	lds	r24, 0x0610	; 0x800610 <__RODATA_PM_OFFSET__+0x7f8610>
 18c:	90 91 11 06 	lds	r25, 0x0611	; 0x800611 <__RODATA_PM_OFFSET__+0x7f8611>
 190:	80 93 04 78 	sts	0x7804, r24	; 0x807804 <_ZZ11__vector_20E3res>
 194:	90 93 05 78 	sts	0x7805, r25	; 0x807805 <_ZZ11__vector_20E3res+0x1>
 198:	80 93 44 09 	sts	0x0944, r24	; 0x800944 <__RODATA_PM_OFFSET__+0x7f8944>
 19c:	82 e0       	ldi	r24, 0x02	; 2
 19e:	80 93 06 78 	sts	0x7806, r24	; 0x807806 <_ZZ11__vector_20E4step>
 1a2:	9f 91       	pop	r25
 1a4:	8f 91       	pop	r24
 1a6:	0f 90       	pop	r0
 1a8:	0f be       	out	0x3f, r0	; 63
 1aa:	0f 90       	pop	r0
 1ac:	1f 90       	pop	r1
 1ae:	18 95       	reti

000001b0 <main>:
 1b0:	80 e4       	ldi	r24, 0x40	; 64
 1b2:	80 93 01 04 	sts	0x0401, r24	; 0x800401 <__RODATA_PM_OFFSET__+0x7f8401>
 1b6:	88 ed       	ldi	r24, 0xD8	; 216
 1b8:	84 bf       	out	0x34, r24	; 52
 1ba:	84 e2       	ldi	r24, 0x24	; 36
 1bc:	80 93 68 00 	sts	0x0068, r24	; 0x800068 <__RODATA_PM_OFFSET__+0x7f8068>
 1c0:	80 91 68 00 	lds	r24, 0x0068	; 0x800068 <__RODATA_PM_OFFSET__+0x7f8068>
 1c4:	81 ff       	sbrs	r24, 1
 1c6:	fc cf       	rjmp	.-8      	; 0x1c0 <main+0x10>
 1c8:	10 92 47 01 	sts	0x0147, r1	; 0x800147 <__RODATA_PM_OFFSET__+0x7f8147>
 1cc:	81 e0       	ldi	r24, 0x01	; 1
 1ce:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 1d2:	91 e2       	ldi	r25, 0x21	; 33
 1d4:	90 93 50 01 	sts	0x0150, r25	; 0x800150 <__RODATA_PM_OFFSET__+0x7f8150>
 1d8:	25 e0       	ldi	r18, 0x05	; 5
 1da:	20 93 b0 00 	sts	0x00B0, r18	; 0x8000b0 <__RODATA_PM_OFFSET__+0x7f80b0>
 1de:	92 e0       	ldi	r25, 0x02	; 2
 1e0:	90 93 01 06 	sts	0x0601, r25	; 0x800601 <__RODATA_PM_OFFSET__+0x7f8601>
 1e4:	36 e0       	ldi	r19, 0x06	; 6
 1e6:	30 93 02 06 	sts	0x0602, r19	; 0x800602 <__RODATA_PM_OFFSET__+0x7f8602>
 1ea:	80 93 00 06 	sts	0x0600, r24	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 1ee:	e7 e5       	ldi	r30, 0x57	; 87
 1f0:	f2 e0       	ldi	r31, 0x02	; 2
 1f2:	31 97       	sbiw	r30, 0x01	; 1
 1f4:	f1 f7       	brne	.-4      	; 0x1f2 <main+0x42>
 1f6:	00 c0       	rjmp	.+0      	; 0x1f8 <main+0x48>
 1f8:	00 00       	nop
 1fa:	20 93 e5 05 	sts	0x05E5, r18	; 0x8005e5 <__RODATA_PM_OFFSET__+0x7f85e5>
 1fe:	90 93 41 04 	sts	0x0441, r25	; 0x800441 <__RODATA_PM_OFFSET__+0x7f8441>
 202:	9d e0       	ldi	r25, 0x0D	; 13
 204:	90 93 42 04 	sts	0x0442, r25	; 0x800442 <__RODATA_PM_OFFSET__+0x7f8442>
 208:	80 93 40 09 	sts	0x0940, r24	; 0x800940 <__RODATA_PM_OFFSET__+0x7f8940>
 20c:	80 93 42 09 	sts	0x0942, r24	; 0x800942 <__RODATA_PM_OFFSET__+0x7f8942>
 210:	78 94       	sei
 212:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 216:	8e 7f       	andi	r24, 0xFE	; 254
 218:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 21c:	00 91 00 78 	lds	r16, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 220:	10 91 01 78 	lds	r17, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 224:	20 91 02 78 	lds	r18, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 228:	30 91 03 78 	lds	r19, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 22c:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 230:	81 60       	ori	r24, 0x01	; 1
 232:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 236:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 23a:	8e 7f       	andi	r24, 0xFE	; 254
 23c:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 240:	40 91 00 78 	lds	r20, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 244:	50 91 01 78 	lds	r21, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 248:	60 91 02 78 	lds	r22, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 24c:	70 91 03 78 	lds	r23, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 250:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 254:	81 60       	ori	r24, 0x01	; 1
 256:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 25a:	db 01       	movw	r26, r22
 25c:	ca 01       	movw	r24, r20
 25e:	80 1b       	sub	r24, r16
 260:	91 0b       	sbc	r25, r17
 262:	a2 0b       	sbc	r26, r18
 264:	b3 0b       	sbc	r27, r19
 266:	85 3f       	cpi	r24, 0xF5	; 245
 268:	91 40       	sbci	r25, 0x01	; 1
 26a:	a1 05       	cpc	r26, r1
 26c:	b1 05       	cpc	r27, r1
 26e:	18 f3       	brcs	.-58     	; 0x236 <main+0x86>
 270:	8a 01       	movw	r16, r20
 272:	9b 01       	movw	r18, r22
 274:	e0 cf       	rjmp	.-64     	; 0x236 <main+0x86>

00000276 <_exit>:
 276:	f8 94       	cli

00000278 <__stop_program>:
 278:	ff cf       	rjmp	.-2      	; 0x278 <__stop_program>
