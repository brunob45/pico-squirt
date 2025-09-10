
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
  a6:	a8 31       	cpi	r26, 0x18	; 24
  a8:	b2 07       	cpc	r27, r18
  aa:	e1 f7       	brne	.-8      	; 0xa4 <.do_clear_bss_loop>
  ac:	0e 94 84 00 	call	0x108	; 0x108 <main>
  b0:	0c 94 a1 01 	jmp	0x342	; 0x342 <_exit>

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
  cc:	80 93 53 01 	sts	0x0153, r24	; 0x800153 <_ZL10ADC_INPUTS+0x7f7e0d>
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
 10a:	80 93 01 04 	sts	0x0401, r24	; 0x800401 <_ZL10ADC_INPUTS+0x7f80bb>
 10e:	88 ed       	ldi	r24, 0xD8	; 216
 110:	84 bf       	out	0x34, r24	; 52
 112:	84 e2       	ldi	r24, 0x24	; 36
 114:	80 93 68 00 	sts	0x0068, r24	; 0x800068 <_ZL10ADC_INPUTS+0x7f7d22>
 118:	80 91 68 00 	lds	r24, 0x0068	; 0x800068 <_ZL10ADC_INPUTS+0x7f7d22>
 11c:	81 ff       	sbrs	r24, 1
 11e:	fc cf       	rjmp	.-8      	; 0x118 <main+0x10>
 120:	10 92 47 01 	sts	0x0147, r1	; 0x800147 <_ZL10ADC_INPUTS+0x7f7e01>
 124:	81 e0       	ldi	r24, 0x01	; 1
 126:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7e0c>
 12a:	91 e2       	ldi	r25, 0x21	; 33
 12c:	90 93 50 01 	sts	0x0150, r25	; 0x800150 <_ZL10ADC_INPUTS+0x7f7e0a>
 130:	35 e0       	ldi	r19, 0x05	; 5
 132:	30 93 b0 00 	sts	0x00B0, r19	; 0x8000b0 <_ZL10ADC_INPUTS+0x7f7d6a>
 136:	22 e0       	ldi	r18, 0x02	; 2
 138:	20 93 01 06 	sts	0x0601, r18	; 0x800601 <_ZL10ADC_INPUTS+0x7f82bb>
 13c:	96 e0       	ldi	r25, 0x06	; 6
 13e:	90 93 02 06 	sts	0x0602, r25	; 0x800602 <_ZL10ADC_INPUTS+0x7f82bc>
 142:	80 93 08 06 	sts	0x0608, r24	; 0x800608 <_ZL10ADC_INPUTS+0x7f82c2>
 146:	90 91 00 06 	lds	r25, 0x0600	; 0x800600 <_ZL10ADC_INPUTS+0x7f82ba>
 14a:	91 60       	ori	r25, 0x01	; 1
 14c:	90 93 00 06 	sts	0x0600, r25	; 0x800600 <_ZL10ADC_INPUTS+0x7f82ba>
 150:	e7 e5       	ldi	r30, 0x57	; 87
 152:	f2 e0       	ldi	r31, 0x02	; 2
 154:	31 97       	sbiw	r30, 0x01	; 1
 156:	f1 f7       	brne	.-4      	; 0x154 <main+0x4c>
 158:	00 c0       	rjmp	.+0      	; 0x15a <main+0x52>
 15a:	00 00       	nop
 15c:	80 93 0a 06 	sts	0x060A, r24	; 0x80060a <_ZL10ADC_INPUTS+0x7f82c4>
 160:	30 93 e5 05 	sts	0x05E5, r19	; 0x8005e5 <_ZL10ADC_INPUTS+0x7f829f>
 164:	20 93 41 04 	sts	0x0441, r18	; 0x800441 <_ZL10ADC_INPUTS+0x7f80fb>
 168:	9d e0       	ldi	r25, 0x0D	; 13
 16a:	90 93 42 04 	sts	0x0442, r25	; 0x800442 <_ZL10ADC_INPUTS+0x7f80fc>
 16e:	80 93 40 09 	sts	0x0940, r24	; 0x800940 <_ZL10ADC_INPUTS+0x7f85fa>
 172:	88 ed       	ldi	r24, 0xD8	; 216
 174:	a8 95       	wdr
 176:	84 bf       	out	0x34, r24	; 52
 178:	80 91 00 01 	lds	r24, 0x0100	; 0x800100 <_ZL10ADC_INPUTS+0x7f7dba>
 17c:	84 60       	ori	r24, 0x04	; 4
 17e:	80 93 00 01 	sts	0x0100, r24	; 0x800100 <_ZL10ADC_INPUTS+0x7f7dba>
 182:	80 91 01 01 	lds	r24, 0x0101	; 0x800101 <_ZL10ADC_INPUTS+0x7f7dbb>
 186:	81 fd       	sbrc	r24, 1
 188:	fc cf       	rjmp	.-8      	; 0x182 <main+0x7a>
 18a:	78 94       	sei
 18c:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <_ZL10ADC_INPUTS+0x7f7e0c>
 190:	8e 7f       	andi	r24, 0xFE	; 254
 192:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7e0c>
 196:	c0 90 00 78 	lds	r12, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 19a:	d0 90 01 78 	lds	r13, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 19e:	e0 90 02 78 	lds	r14, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 1a2:	f0 90 03 78 	lds	r15, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 1a6:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <_ZL10ADC_INPUTS+0x7f7e0c>
 1aa:	81 60       	ori	r24, 0x01	; 1
 1ac:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7e0c>
 1b0:	c0 91 04 78 	lds	r28, 0x7804	; 0x807804 <_ZZL11ADC0_RESRDYvE5index>
 1b4:	ec 2f       	mov	r30, r28
 1b6:	f0 e0       	ldi	r31, 0x00	; 0
 1b8:	ea 5b       	subi	r30, 0xBA	; 186
 1ba:	fc 47       	sbci	r31, 0x7C	; 124
 1bc:	b0 81       	ld	r27, Z
 1be:	a0 91 15 78 	lds	r26, 0x7815	; 0x807815 <_ZL3buf+0x10>
 1c2:	90 91 16 78 	lds	r25, 0x7816	; 0x807816 <_ZL3buf+0x11>
 1c6:	80 e4       	ldi	r24, 0x40	; 64
 1c8:	b8 2e       	mov	r11, r24
 1ca:	d1 e0       	ldi	r29, 0x01	; 1
 1cc:	20 e8       	ldi	r18, 0x80	; 128
 1ce:	a2 2e       	mov	r10, r18
 1d0:	a8 95       	wdr
 1d2:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <_ZL10ADC_INPUTS+0x7f7e0c>
 1d6:	8e 7f       	andi	r24, 0xFE	; 254
 1d8:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7e0c>
 1dc:	40 91 00 78 	lds	r20, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 1e0:	50 91 01 78 	lds	r21, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 1e4:	60 91 02 78 	lds	r22, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 1e8:	70 91 03 78 	lds	r23, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 1ec:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <_ZL10ADC_INPUTS+0x7f7e0c>
 1f0:	81 60       	ori	r24, 0x01	; 1
 1f2:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7e0c>
 1f6:	8a 01       	movw	r16, r20
 1f8:	9b 01       	movw	r18, r22
 1fa:	0c 19       	sub	r16, r12
 1fc:	1d 09       	sbc	r17, r13
 1fe:	2e 09       	sbc	r18, r14
 200:	3f 09       	sbc	r19, r15
 202:	05 3f       	cpi	r16, 0xF5	; 245
 204:	11 40       	sbci	r17, 0x01	; 1
 206:	21 05       	cpc	r18, r1
 208:	31 05       	cpc	r19, r1
 20a:	20 f0       	brcs	.+8      	; 0x214 <main+0x10c>
 20c:	b0 92 07 04 	sts	0x0407, r11	; 0x800407 <_ZL10ADC_INPUTS+0x7f80c1>
 210:	6a 01       	movw	r12, r20
 212:	7b 01       	movw	r14, r22
 214:	80 91 0d 06 	lds	r24, 0x060D	; 0x80060d <_ZL10ADC_INPUTS+0x7f82c7>
 218:	80 fd       	sbrc	r24, 0
 21a:	1a c0       	rjmp	.+52     	; 0x250 <main+0x148>
 21c:	80 91 43 09 	lds	r24, 0x0943	; 0x800943 <_ZL10ADC_INPUTS+0x7f85fd>
 220:	87 ff       	sbrs	r24, 7
 222:	d6 cf       	rjmp	.-84     	; 0x1d0 <main+0xc8>
 224:	a0 92 43 09 	sts	0x0943, r10	; 0x800943 <_ZL10ADC_INPUTS+0x7f85fd>
 228:	a9 17       	cp	r26, r25
 22a:	09 f4       	brne	.+2      	; 0x22e <main+0x126>
 22c:	6a c0       	rjmp	.+212    	; 0x302 <main+0x1fa>
 22e:	e9 2f       	mov	r30, r25
 230:	f0 e0       	ldi	r31, 0x00	; 0
 232:	eb 5f       	subi	r30, 0xFB	; 251
 234:	f7 48       	sbci	r31, 0x87	; 135
 236:	80 81       	ld	r24, Z
 238:	9f 5f       	subi	r25, 0xFF	; 255
 23a:	90 31       	cpi	r25, 0x10	; 16
 23c:	e8 f4       	brcc	.+58     	; 0x278 <main+0x170>
 23e:	90 93 16 78 	sts	0x7816, r25	; 0x807816 <_ZL3buf+0x11>
 242:	10 92 17 78 	sts	0x7817, r1	; 0x807817 <_ZL3buf+0x12>
 246:	90 91 16 78 	lds	r25, 0x7816	; 0x807816 <_ZL3buf+0x11>
 24a:	80 93 44 09 	sts	0x0944, r24	; 0x800944 <_ZL10ADC_INPUTS+0x7f85fe>
 24e:	c0 cf       	rjmp	.-128    	; 0x1d0 <main+0xc8>
 250:	d0 93 0d 06 	sts	0x060D, r29	; 0x80060d <_ZL10ADC_INPUTS+0x7f82c7>
 254:	80 91 17 78 	lds	r24, 0x7817	; 0x807817 <_ZL3buf+0x12>
 258:	88 23       	and	r24, r24
 25a:	b9 f0       	breq	.+46     	; 0x28a <main+0x182>
 25c:	80 91 10 06 	lds	r24, 0x0610	; 0x800610 <_ZL10ADC_INPUTS+0x7f82ca>
 260:	80 91 11 06 	lds	r24, 0x0611	; 0x800611 <_ZL10ADC_INPUTS+0x7f82cb>
 264:	cf 5f       	subi	r28, 0xFF	; 255
 266:	c7 30       	cpi	r28, 0x07	; 7
 268:	50 f0       	brcs	.+20     	; 0x27e <main+0x176>
 26a:	b1 e0       	ldi	r27, 0x01	; 1
 26c:	c0 e0       	ldi	r28, 0x00	; 0
 26e:	b0 93 08 06 	sts	0x0608, r27	; 0x800608 <_ZL10ADC_INPUTS+0x7f82c2>
 272:	d0 93 0a 06 	sts	0x060A, r29	; 0x80060a <_ZL10ADC_INPUTS+0x7f82c4>
 276:	d2 cf       	rjmp	.-92     	; 0x21c <main+0x114>
 278:	10 92 16 78 	sts	0x7816, r1	; 0x807816 <_ZL3buf+0x11>
 27c:	e2 cf       	rjmp	.-60     	; 0x242 <main+0x13a>
 27e:	ec 2f       	mov	r30, r28
 280:	f0 e0       	ldi	r31, 0x00	; 0
 282:	ea 5b       	subi	r30, 0xBA	; 186
 284:	fc 47       	sbci	r31, 0x7C	; 124
 286:	b0 81       	ld	r27, Z
 288:	f2 cf       	rjmp	.-28     	; 0x26e <main+0x166>
 28a:	ea 2f       	mov	r30, r26
 28c:	f0 e0       	ldi	r31, 0x00	; 0
 28e:	eb 5f       	subi	r30, 0xFB	; 251
 290:	f7 48       	sbci	r31, 0x87	; 135
 292:	b0 83       	st	Z, r27
 294:	e1 e0       	ldi	r30, 0x01	; 1
 296:	ea 0f       	add	r30, r26
 298:	e0 31       	cpi	r30, 0x10	; 16
 29a:	c8 f5       	brcc	.+114    	; 0x30e <main+0x206>
 29c:	e0 93 15 78 	sts	0x7815, r30	; 0x807815 <_ZL3buf+0x10>
 2a0:	81 e0       	ldi	r24, 0x01	; 1
 2a2:	e9 13       	cpse	r30, r25
 2a4:	80 e0       	ldi	r24, 0x00	; 0
 2a6:	80 93 17 78 	sts	0x7817, r24	; 0x807817 <_ZL3buf+0x12>
 2aa:	80 91 10 06 	lds	r24, 0x0610	; 0x800610 <_ZL10ADC_INPUTS+0x7f82ca>
 2ae:	e9 17       	cp	r30, r25
 2b0:	09 f4       	brne	.+2      	; 0x2b4 <main+0x1ac>
 2b2:	42 c0       	rjmp	.+132    	; 0x338 <main+0x230>
 2b4:	f0 e0       	ldi	r31, 0x00	; 0
 2b6:	eb 5f       	subi	r30, 0xFB	; 251
 2b8:	f7 48       	sbci	r31, 0x87	; 135
 2ba:	80 83       	st	Z, r24
 2bc:	ae 5f       	subi	r26, 0xFE	; 254
 2be:	a0 31       	cpi	r26, 0x10	; 16
 2c0:	a1 f5       	brne	.+104    	; 0x32a <main+0x222>
 2c2:	10 92 15 78 	sts	0x7815, r1	; 0x807815 <_ZL3buf+0x10>
 2c6:	a0 e0       	ldi	r26, 0x00	; 0
 2c8:	81 e0       	ldi	r24, 0x01	; 1
 2ca:	9a 13       	cpse	r25, r26
 2cc:	80 e0       	ldi	r24, 0x00	; 0
 2ce:	80 93 17 78 	sts	0x7817, r24	; 0x807817 <_ZL3buf+0x12>
 2d2:	20 91 11 06 	lds	r18, 0x0611	; 0x800611 <_ZL10ADC_INPUTS+0x7f82cb>
 2d6:	9a 17       	cp	r25, r26
 2d8:	89 f0       	breq	.+34     	; 0x2fc <main+0x1f4>
 2da:	80 91 15 78 	lds	r24, 0x7815	; 0x807815 <_ZL3buf+0x10>
 2de:	e8 2f       	mov	r30, r24
 2e0:	f0 e0       	ldi	r31, 0x00	; 0
 2e2:	eb 5f       	subi	r30, 0xFB	; 251
 2e4:	f7 48       	sbci	r31, 0x87	; 135
 2e6:	20 83       	st	Z, r18
 2e8:	8f 5f       	subi	r24, 0xFF	; 255
 2ea:	80 31       	cpi	r24, 0x10	; 16
 2ec:	08 f5       	brcc	.+66     	; 0x330 <main+0x228>
 2ee:	80 93 15 78 	sts	0x7815, r24	; 0x807815 <_ZL3buf+0x10>
 2f2:	21 e0       	ldi	r18, 0x01	; 1
 2f4:	98 13       	cpse	r25, r24
 2f6:	20 e0       	ldi	r18, 0x00	; 0
 2f8:	20 93 17 78 	sts	0x7817, r18	; 0x807817 <_ZL3buf+0x12>
 2fc:	a0 91 15 78 	lds	r26, 0x7815	; 0x807815 <_ZL3buf+0x10>
 300:	b1 cf       	rjmp	.-158    	; 0x264 <main+0x15c>
 302:	80 91 17 78 	lds	r24, 0x7817	; 0x807817 <_ZL3buf+0x12>
 306:	81 11       	cpse	r24, r1
 308:	92 cf       	rjmp	.-220    	; 0x22e <main+0x126>
 30a:	80 e0       	ldi	r24, 0x00	; 0
 30c:	9e cf       	rjmp	.-196    	; 0x24a <main+0x142>
 30e:	10 92 15 78 	sts	0x7815, r1	; 0x807815 <_ZL3buf+0x10>
 312:	81 e0       	ldi	r24, 0x01	; 1
 314:	91 11       	cpse	r25, r1
 316:	80 e0       	ldi	r24, 0x00	; 0
 318:	80 93 17 78 	sts	0x7817, r24	; 0x807817 <_ZL3buf+0x12>
 31c:	80 91 10 06 	lds	r24, 0x0610	; 0x800610 <_ZL10ADC_INPUTS+0x7f82ca>
 320:	99 23       	and	r25, r25
 322:	51 f0       	breq	.+20     	; 0x338 <main+0x230>
 324:	80 93 05 78 	sts	0x7805, r24	; 0x807805 <_ZL3buf>
 328:	a1 e0       	ldi	r26, 0x01	; 1
 32a:	a0 93 15 78 	sts	0x7815, r26	; 0x807815 <_ZL3buf+0x10>
 32e:	cc cf       	rjmp	.-104    	; 0x2c8 <main+0x1c0>
 330:	10 92 15 78 	sts	0x7815, r1	; 0x807815 <_ZL3buf+0x10>
 334:	80 e0       	ldi	r24, 0x00	; 0
 336:	dd cf       	rjmp	.-70     	; 0x2f2 <main+0x1ea>
 338:	80 91 11 06 	lds	r24, 0x0611	; 0x800611 <_ZL10ADC_INPUTS+0x7f82cb>
 33c:	a0 91 15 78 	lds	r26, 0x7815	; 0x807815 <_ZL3buf+0x10>
 340:	91 cf       	rjmp	.-222    	; 0x264 <main+0x15c>

00000342 <_exit>:
 342:	f8 94       	cli

00000344 <__stop_program>:
 344:	ff cf       	rjmp	.-2      	; 0x344 <__stop_program>
