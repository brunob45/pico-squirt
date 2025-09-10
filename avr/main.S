
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
  68:	0c 94 b6 00 	jmp	0x16c	; 0x16c <__vector_26>
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
  ac:	0e 94 51 01 	call	0x2a2	; 0x2a2 <main>
  b0:	0c 94 cd 01 	jmp	0x39a	; 0x39a <_exit>

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
  cc:	80 93 53 01 	sts	0x0153, r24	; 0x800153 <_ZL10ADC_INPUTS+0x7f7db5>
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
 116:	ef 93       	push	r30
 118:	ff 93       	push	r31
 11a:	80 e8       	ldi	r24, 0x80	; 128
 11c:	80 93 43 09 	sts	0x0943, r24	; 0x800943 <_ZL10ADC_INPUTS+0x7f85a5>
 120:	80 91 16 78 	lds	r24, 0x7816	; 0x807816 <_ZL3buf+0x11>
 124:	90 91 15 78 	lds	r25, 0x7815	; 0x807815 <_ZL3buf+0x10>
 128:	98 17       	cp	r25, r24
 12a:	d1 f0       	breq	.+52     	; 0x160 <__vector_20+0x58>
 12c:	e8 2f       	mov	r30, r24
 12e:	f0 e0       	ldi	r31, 0x00	; 0
 130:	eb 5f       	subi	r30, 0xFB	; 251
 132:	f7 48       	sbci	r31, 0x87	; 135
 134:	90 81       	ld	r25, Z
 136:	8f 5f       	subi	r24, 0xFF	; 255
 138:	80 31       	cpi	r24, 0x10	; 16
 13a:	78 f4       	brcc	.+30     	; 0x15a <__vector_20+0x52>
 13c:	80 93 16 78 	sts	0x7816, r24	; 0x807816 <_ZL3buf+0x11>
 140:	10 92 17 78 	sts	0x7817, r1	; 0x807817 <_ZL3buf+0x12>
 144:	90 93 44 09 	sts	0x0944, r25	; 0x800944 <_ZL10ADC_INPUTS+0x7f85a6>
 148:	ff 91       	pop	r31
 14a:	ef 91       	pop	r30
 14c:	9f 91       	pop	r25
 14e:	8f 91       	pop	r24
 150:	0f 90       	pop	r0
 152:	0f be       	out	0x3f, r0	; 63
 154:	0f 90       	pop	r0
 156:	1f 90       	pop	r1
 158:	18 95       	reti
 15a:	10 92 16 78 	sts	0x7816, r1	; 0x807816 <_ZL3buf+0x11>
 15e:	f0 cf       	rjmp	.-32     	; 0x140 <__vector_20+0x38>
 160:	90 91 17 78 	lds	r25, 0x7817	; 0x807817 <_ZL3buf+0x12>
 164:	91 11       	cpse	r25, r1
 166:	e2 cf       	rjmp	.-60     	; 0x12c <__vector_20+0x24>
 168:	90 e0       	ldi	r25, 0x00	; 0
 16a:	ec cf       	rjmp	.-40     	; 0x144 <__vector_20+0x3c>

0000016c <__vector_26>:
 16c:	1f 92       	push	r1
 16e:	0f 92       	push	r0
 170:	0f b6       	in	r0, 0x3f	; 63
 172:	0f 92       	push	r0
 174:	11 24       	eor	r1, r1
 176:	2f 93       	push	r18
 178:	3f 93       	push	r19
 17a:	8f 93       	push	r24
 17c:	9f 93       	push	r25
 17e:	af 93       	push	r26
 180:	bf 93       	push	r27
 182:	cf 93       	push	r28
 184:	df 93       	push	r29
 186:	ef 93       	push	r30
 188:	ff 93       	push	r31
 18a:	81 e0       	ldi	r24, 0x01	; 1
 18c:	80 93 0d 06 	sts	0x060D, r24	; 0x80060d <_ZL10ADC_INPUTS+0x7f826f>
 190:	e0 91 04 78 	lds	r30, 0x7804	; 0x807804 <_ZZ11__vector_26E5index>
 194:	80 91 17 78 	lds	r24, 0x7817	; 0x807817 <_ZL3buf+0x12>
 198:	88 23       	and	r24, r24
 19a:	29 f1       	breq	.+74     	; 0x1e6 <__vector_26+0x7a>
 19c:	80 91 10 06 	lds	r24, 0x0610	; 0x800610 <_ZL10ADC_INPUTS+0x7f8272>
 1a0:	80 91 11 06 	lds	r24, 0x0611	; 0x800611 <_ZL10ADC_INPUTS+0x7f8273>
 1a4:	ef 5f       	subi	r30, 0xFF	; 255
 1a6:	e0 93 04 78 	sts	0x7804, r30	; 0x807804 <_ZZ11__vector_26E5index>
 1aa:	e7 30       	cpi	r30, 0x07	; 7
 1ac:	b8 f0       	brcs	.+46     	; 0x1dc <__vector_26+0x70>
 1ae:	10 92 04 78 	sts	0x7804, r1	; 0x807804 <_ZZ11__vector_26E5index>
 1b2:	81 e0       	ldi	r24, 0x01	; 1
 1b4:	80 93 08 06 	sts	0x0608, r24	; 0x800608 <_ZL10ADC_INPUTS+0x7f826a>
 1b8:	81 e0       	ldi	r24, 0x01	; 1
 1ba:	80 93 0a 06 	sts	0x060A, r24	; 0x80060a <_ZL10ADC_INPUTS+0x7f826c>
 1be:	ff 91       	pop	r31
 1c0:	ef 91       	pop	r30
 1c2:	df 91       	pop	r29
 1c4:	cf 91       	pop	r28
 1c6:	bf 91       	pop	r27
 1c8:	af 91       	pop	r26
 1ca:	9f 91       	pop	r25
 1cc:	8f 91       	pop	r24
 1ce:	3f 91       	pop	r19
 1d0:	2f 91       	pop	r18
 1d2:	0f 90       	pop	r0
 1d4:	0f be       	out	0x3f, r0	; 63
 1d6:	0f 90       	pop	r0
 1d8:	1f 90       	pop	r1
 1da:	18 95       	reti
 1dc:	f0 e0       	ldi	r31, 0x00	; 0
 1de:	e2 56       	subi	r30, 0x62	; 98
 1e0:	fc 47       	sbci	r31, 0x7C	; 124
 1e2:	80 81       	ld	r24, Z
 1e4:	e7 cf       	rjmp	.-50     	; 0x1b4 <__vector_26+0x48>
 1e6:	90 91 15 78 	lds	r25, 0x7815	; 0x807815 <_ZL3buf+0x10>
 1ea:	a9 2f       	mov	r26, r25
 1ec:	b0 e0       	ldi	r27, 0x00	; 0
 1ee:	ab 5f       	subi	r26, 0xFB	; 251
 1f0:	b7 48       	sbci	r27, 0x87	; 135
 1f2:	ce 2f       	mov	r28, r30
 1f4:	d0 e0       	ldi	r29, 0x00	; 0
 1f6:	c2 56       	subi	r28, 0x62	; 98
 1f8:	dc 47       	sbci	r29, 0x7C	; 124
 1fa:	28 81       	ld	r18, Y
 1fc:	2c 93       	st	X, r18
 1fe:	a1 e0       	ldi	r26, 0x01	; 1
 200:	a9 0f       	add	r26, r25
 202:	a0 31       	cpi	r26, 0x10	; 16
 204:	a8 f5       	brcc	.+106    	; 0x270 <__vector_26+0x104>
 206:	a0 93 15 78 	sts	0x7815, r26	; 0x807815 <_ZL3buf+0x10>
 20a:	20 91 16 78 	lds	r18, 0x7816	; 0x807816 <_ZL3buf+0x11>
 20e:	31 e0       	ldi	r19, 0x01	; 1
 210:	a2 13       	cpse	r26, r18
 212:	30 e0       	ldi	r19, 0x00	; 0
 214:	30 93 17 78 	sts	0x7817, r19	; 0x807817 <_ZL3buf+0x12>
 218:	30 91 10 06 	lds	r19, 0x0610	; 0x800610 <_ZL10ADC_INPUTS+0x7f8272>
 21c:	a2 17       	cp	r26, r18
 21e:	09 f4       	brne	.+2      	; 0x222 <__vector_26+0xb6>
 220:	3d c0       	rjmp	.+122    	; 0x29c <__vector_26+0x130>
 222:	b0 e0       	ldi	r27, 0x00	; 0
 224:	ab 5f       	subi	r26, 0xFB	; 251
 226:	b7 48       	sbci	r27, 0x87	; 135
 228:	3c 93       	st	X, r19
 22a:	9e 5f       	subi	r25, 0xFE	; 254
 22c:	90 31       	cpi	r25, 0x10	; 16
 22e:	81 f5       	brne	.+96     	; 0x290 <__vector_26+0x124>
 230:	10 92 15 78 	sts	0x7815, r1	; 0x807815 <_ZL3buf+0x10>
 234:	90 e0       	ldi	r25, 0x00	; 0
 236:	31 e0       	ldi	r19, 0x01	; 1
 238:	29 13       	cpse	r18, r25
 23a:	30 e0       	ldi	r19, 0x00	; 0
 23c:	30 93 17 78 	sts	0x7817, r19	; 0x807817 <_ZL3buf+0x12>
 240:	30 91 11 06 	lds	r19, 0x0611	; 0x800611 <_ZL10ADC_INPUTS+0x7f8273>
 244:	29 17       	cp	r18, r25
 246:	09 f4       	brne	.+2      	; 0x24a <__vector_26+0xde>
 248:	ad cf       	rjmp	.-166    	; 0x1a4 <__vector_26+0x38>
 24a:	90 91 15 78 	lds	r25, 0x7815	; 0x807815 <_ZL3buf+0x10>
 24e:	a9 2f       	mov	r26, r25
 250:	b0 e0       	ldi	r27, 0x00	; 0
 252:	ab 5f       	subi	r26, 0xFB	; 251
 254:	b7 48       	sbci	r27, 0x87	; 135
 256:	3c 93       	st	X, r19
 258:	9f 5f       	subi	r25, 0xFF	; 255
 25a:	90 31       	cpi	r25, 0x10	; 16
 25c:	e0 f4       	brcc	.+56     	; 0x296 <__vector_26+0x12a>
 25e:	90 93 15 78 	sts	0x7815, r25	; 0x807815 <_ZL3buf+0x10>
 262:	89 2f       	mov	r24, r25
 264:	91 e0       	ldi	r25, 0x01	; 1
 266:	28 13       	cpse	r18, r24
 268:	90 e0       	ldi	r25, 0x00	; 0
 26a:	90 93 17 78 	sts	0x7817, r25	; 0x807817 <_ZL3buf+0x12>
 26e:	9a cf       	rjmp	.-204    	; 0x1a4 <__vector_26+0x38>
 270:	10 92 15 78 	sts	0x7815, r1	; 0x807815 <_ZL3buf+0x10>
 274:	20 91 16 78 	lds	r18, 0x7816	; 0x807816 <_ZL3buf+0x11>
 278:	91 e0       	ldi	r25, 0x01	; 1
 27a:	21 11       	cpse	r18, r1
 27c:	90 e0       	ldi	r25, 0x00	; 0
 27e:	90 93 17 78 	sts	0x7817, r25	; 0x807817 <_ZL3buf+0x12>
 282:	90 91 10 06 	lds	r25, 0x0610	; 0x800610 <_ZL10ADC_INPUTS+0x7f8272>
 286:	22 23       	and	r18, r18
 288:	49 f0       	breq	.+18     	; 0x29c <__vector_26+0x130>
 28a:	90 93 05 78 	sts	0x7805, r25	; 0x807805 <_ZL3buf>
 28e:	91 e0       	ldi	r25, 0x01	; 1
 290:	90 93 15 78 	sts	0x7815, r25	; 0x807815 <_ZL3buf+0x10>
 294:	d0 cf       	rjmp	.-96     	; 0x236 <__vector_26+0xca>
 296:	10 92 15 78 	sts	0x7815, r1	; 0x807815 <_ZL3buf+0x10>
 29a:	e4 cf       	rjmp	.-56     	; 0x264 <__vector_26+0xf8>
 29c:	80 91 11 06 	lds	r24, 0x0611	; 0x800611 <_ZL10ADC_INPUTS+0x7f8273>
 2a0:	81 cf       	rjmp	.-254    	; 0x1a4 <__vector_26+0x38>

000002a2 <main>:
 2a2:	80 e4       	ldi	r24, 0x40	; 64
 2a4:	80 93 01 04 	sts	0x0401, r24	; 0x800401 <_ZL10ADC_INPUTS+0x7f8063>
 2a8:	88 ed       	ldi	r24, 0xD8	; 216
 2aa:	84 bf       	out	0x34, r24	; 52
 2ac:	84 e2       	ldi	r24, 0x24	; 36
 2ae:	80 93 68 00 	sts	0x0068, r24	; 0x800068 <_ZL10ADC_INPUTS+0x7f7cca>
 2b2:	80 91 68 00 	lds	r24, 0x0068	; 0x800068 <_ZL10ADC_INPUTS+0x7f7cca>
 2b6:	81 ff       	sbrs	r24, 1
 2b8:	fc cf       	rjmp	.-8      	; 0x2b2 <main+0x10>
 2ba:	10 92 47 01 	sts	0x0147, r1	; 0x800147 <_ZL10ADC_INPUTS+0x7f7da9>
 2be:	81 e0       	ldi	r24, 0x01	; 1
 2c0:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7db4>
 2c4:	91 e2       	ldi	r25, 0x21	; 33
 2c6:	90 93 50 01 	sts	0x0150, r25	; 0x800150 <_ZL10ADC_INPUTS+0x7f7db2>
 2ca:	35 e0       	ldi	r19, 0x05	; 5
 2cc:	30 93 b0 00 	sts	0x00B0, r19	; 0x8000b0 <_ZL10ADC_INPUTS+0x7f7d12>
 2d0:	22 e0       	ldi	r18, 0x02	; 2
 2d2:	20 93 01 06 	sts	0x0601, r18	; 0x800601 <_ZL10ADC_INPUTS+0x7f8263>
 2d6:	96 e0       	ldi	r25, 0x06	; 6
 2d8:	90 93 02 06 	sts	0x0602, r25	; 0x800602 <_ZL10ADC_INPUTS+0x7f8264>
 2dc:	80 93 08 06 	sts	0x0608, r24	; 0x800608 <_ZL10ADC_INPUTS+0x7f826a>
 2e0:	90 91 00 06 	lds	r25, 0x0600	; 0x800600 <_ZL10ADC_INPUTS+0x7f8262>
 2e4:	91 60       	ori	r25, 0x01	; 1
 2e6:	90 93 00 06 	sts	0x0600, r25	; 0x800600 <_ZL10ADC_INPUTS+0x7f8262>
 2ea:	e7 e5       	ldi	r30, 0x57	; 87
 2ec:	f2 e0       	ldi	r31, 0x02	; 2
 2ee:	31 97       	sbiw	r30, 0x01	; 1
 2f0:	f1 f7       	brne	.-4      	; 0x2ee <main+0x4c>
 2f2:	00 c0       	rjmp	.+0      	; 0x2f4 <main+0x52>
 2f4:	00 00       	nop
 2f6:	80 93 0a 06 	sts	0x060A, r24	; 0x80060a <_ZL10ADC_INPUTS+0x7f826c>
 2fa:	80 93 0c 06 	sts	0x060C, r24	; 0x80060c <_ZL10ADC_INPUTS+0x7f826e>
 2fe:	30 93 e5 05 	sts	0x05E5, r19	; 0x8005e5 <_ZL10ADC_INPUTS+0x7f8247>
 302:	20 93 41 04 	sts	0x0441, r18	; 0x800441 <_ZL10ADC_INPUTS+0x7f80a3>
 306:	9d e0       	ldi	r25, 0x0D	; 13
 308:	90 93 42 04 	sts	0x0442, r25	; 0x800442 <_ZL10ADC_INPUTS+0x7f80a4>
 30c:	80 93 40 09 	sts	0x0940, r24	; 0x800940 <_ZL10ADC_INPUTS+0x7f85a2>
 310:	80 93 42 09 	sts	0x0942, r24	; 0x800942 <_ZL10ADC_INPUTS+0x7f85a4>
 314:	88 ed       	ldi	r24, 0xD8	; 216
 316:	a8 95       	wdr
 318:	84 bf       	out	0x34, r24	; 52
 31a:	80 91 00 01 	lds	r24, 0x0100	; 0x800100 <_ZL10ADC_INPUTS+0x7f7d62>
 31e:	84 60       	ori	r24, 0x04	; 4
 320:	80 93 00 01 	sts	0x0100, r24	; 0x800100 <_ZL10ADC_INPUTS+0x7f7d62>
 324:	80 91 01 01 	lds	r24, 0x0101	; 0x800101 <_ZL10ADC_INPUTS+0x7f7d63>
 328:	81 fd       	sbrc	r24, 1
 32a:	fc cf       	rjmp	.-8      	; 0x324 <main+0x82>
 32c:	78 94       	sei
 32e:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <_ZL10ADC_INPUTS+0x7f7db4>
 332:	8e 7f       	andi	r24, 0xFE	; 254
 334:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7db4>
 338:	00 91 00 78 	lds	r16, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 33c:	10 91 01 78 	lds	r17, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 340:	20 91 02 78 	lds	r18, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 344:	30 91 03 78 	lds	r19, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 348:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <_ZL10ADC_INPUTS+0x7f7db4>
 34c:	81 60       	ori	r24, 0x01	; 1
 34e:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7db4>
 352:	e0 e4       	ldi	r30, 0x40	; 64
 354:	a8 95       	wdr
 356:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <_ZL10ADC_INPUTS+0x7f7db4>
 35a:	8e 7f       	andi	r24, 0xFE	; 254
 35c:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7db4>
 360:	40 91 00 78 	lds	r20, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 364:	50 91 01 78 	lds	r21, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 368:	60 91 02 78 	lds	r22, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 36c:	70 91 03 78 	lds	r23, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 370:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <_ZL10ADC_INPUTS+0x7f7db4>
 374:	81 60       	ori	r24, 0x01	; 1
 376:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <_ZL10ADC_INPUTS+0x7f7db4>
 37a:	db 01       	movw	r26, r22
 37c:	ca 01       	movw	r24, r20
 37e:	80 1b       	sub	r24, r16
 380:	91 0b       	sbc	r25, r17
 382:	a2 0b       	sbc	r26, r18
 384:	b3 0b       	sbc	r27, r19
 386:	85 3f       	cpi	r24, 0xF5	; 245
 388:	91 40       	sbci	r25, 0x01	; 1
 38a:	a1 05       	cpc	r26, r1
 38c:	b1 05       	cpc	r27, r1
 38e:	10 f3       	brcs	.-60     	; 0x354 <main+0xb2>
 390:	e0 93 07 04 	sts	0x0407, r30	; 0x800407 <_ZL10ADC_INPUTS+0x7f8069>
 394:	8a 01       	movw	r16, r20
 396:	9b 01       	movw	r18, r22
 398:	dd cf       	rjmp	.-70     	; 0x354 <main+0xb2>

0000039a <_exit>:
 39a:	f8 94       	cli

0000039c <__stop_program>:
 39c:	ff cf       	rjmp	.-2      	; 0x39c <__stop_program>
