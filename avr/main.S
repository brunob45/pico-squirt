
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
  ac:	0e 94 70 01 	call	0x2e0	; 0x2e0 <main>
  b0:	0c 94 e2 01 	jmp	0x3c4	; 0x3c4 <_exit>

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
 116:	ef 93       	push	r30
 118:	ff 93       	push	r31
 11a:	80 e8       	ldi	r24, 0x80	; 128
 11c:	80 93 43 09 	sts	0x0943, r24	; 0x800943 <__RODATA_PM_OFFSET__+0x7f8943>
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
 144:	90 93 44 09 	sts	0x0944, r25	; 0x800944 <__RODATA_PM_OFFSET__+0x7f8944>
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
 17a:	4f 93       	push	r20
 17c:	5f 93       	push	r21
 17e:	8f 93       	push	r24
 180:	9f 93       	push	r25
 182:	af 93       	push	r26
 184:	bf 93       	push	r27
 186:	ef 93       	push	r30
 188:	ff 93       	push	r31
 18a:	cf 93       	push	r28
 18c:	df 93       	push	r29
 18e:	cd b7       	in	r28, 0x3d	; 61
 190:	de b7       	in	r29, 0x3e	; 62
 192:	27 97       	sbiw	r28, 0x07	; 7
 194:	cd bf       	out	0x3d, r28	; 61
 196:	de bf       	out	0x3e, r29	; 62
 198:	87 e0       	ldi	r24, 0x07	; 7
 19a:	e8 ec       	ldi	r30, 0xC8	; 200
 19c:	f3 e8       	ldi	r31, 0x83	; 131
 19e:	de 01       	movw	r26, r28
 1a0:	11 96       	adiw	r26, 0x01	; 1
 1a2:	01 90       	ld	r0, Z+
 1a4:	0d 92       	st	X+, r0
 1a6:	8a 95       	dec	r24
 1a8:	e1 f7       	brne	.-8      	; 0x1a2 <__vector_26+0x36>
 1aa:	81 e0       	ldi	r24, 0x01	; 1
 1ac:	80 93 0d 06 	sts	0x060D, r24	; 0x80060d <__RODATA_PM_OFFSET__+0x7f860d>
 1b0:	e0 91 04 78 	lds	r30, 0x7804	; 0x807804 <_ZZ11__vector_26E5index>
 1b4:	80 91 17 78 	lds	r24, 0x7817	; 0x807817 <_ZL3buf+0x12>
 1b8:	88 23       	and	r24, r24
 1ba:	79 f1       	breq	.+94     	; 0x21a <__vector_26+0xae>
 1bc:	80 91 10 06 	lds	r24, 0x0610	; 0x800610 <__RODATA_PM_OFFSET__+0x7f8610>
 1c0:	80 91 11 06 	lds	r24, 0x0611	; 0x800611 <__RODATA_PM_OFFSET__+0x7f8611>
 1c4:	ef 5f       	subi	r30, 0xFF	; 255
 1c6:	e7 30       	cpi	r30, 0x07	; 7
 1c8:	20 f1       	brcs	.+72     	; 0x212 <__vector_26+0xa6>
 1ca:	10 92 04 78 	sts	0x7804, r1	; 0x807804 <_ZZ11__vector_26E5index>
 1ce:	e0 e0       	ldi	r30, 0x00	; 0
 1d0:	f0 e0       	ldi	r31, 0x00	; 0
 1d2:	81 e0       	ldi	r24, 0x01	; 1
 1d4:	90 e0       	ldi	r25, 0x00	; 0
 1d6:	8c 0f       	add	r24, r28
 1d8:	9d 1f       	adc	r25, r29
 1da:	e8 0f       	add	r30, r24
 1dc:	f9 1f       	adc	r31, r25
 1de:	80 81       	ld	r24, Z
 1e0:	80 93 08 06 	sts	0x0608, r24	; 0x800608 <__RODATA_PM_OFFSET__+0x7f8608>
 1e4:	81 e0       	ldi	r24, 0x01	; 1
 1e6:	80 93 0a 06 	sts	0x060A, r24	; 0x80060a <__RODATA_PM_OFFSET__+0x7f860a>
 1ea:	27 96       	adiw	r28, 0x07	; 7
 1ec:	cd bf       	out	0x3d, r28	; 61
 1ee:	de bf       	out	0x3e, r29	; 62
 1f0:	df 91       	pop	r29
 1f2:	cf 91       	pop	r28
 1f4:	ff 91       	pop	r31
 1f6:	ef 91       	pop	r30
 1f8:	bf 91       	pop	r27
 1fa:	af 91       	pop	r26
 1fc:	9f 91       	pop	r25
 1fe:	8f 91       	pop	r24
 200:	5f 91       	pop	r21
 202:	4f 91       	pop	r20
 204:	3f 91       	pop	r19
 206:	2f 91       	pop	r18
 208:	0f 90       	pop	r0
 20a:	0f be       	out	0x3f, r0	; 63
 20c:	0f 90       	pop	r0
 20e:	1f 90       	pop	r1
 210:	18 95       	reti
 212:	e0 93 04 78 	sts	0x7804, r30	; 0x807804 <_ZZ11__vector_26E5index>
 216:	f0 e0       	ldi	r31, 0x00	; 0
 218:	dc cf       	rjmp	.-72     	; 0x1d2 <__vector_26+0x66>
 21a:	90 91 15 78 	lds	r25, 0x7815	; 0x807815 <_ZL3buf+0x10>
 21e:	a9 2f       	mov	r26, r25
 220:	b0 e0       	ldi	r27, 0x00	; 0
 222:	ad 01       	movw	r20, r26
 224:	4b 5f       	subi	r20, 0xFB	; 251
 226:	57 48       	sbci	r21, 0x87	; 135
 228:	21 e0       	ldi	r18, 0x01	; 1
 22a:	30 e0       	ldi	r19, 0x00	; 0
 22c:	2c 0f       	add	r18, r28
 22e:	3d 1f       	adc	r19, r29
 230:	2e 0f       	add	r18, r30
 232:	31 1d       	adc	r19, r1
 234:	d9 01       	movw	r26, r18
 236:	2c 91       	ld	r18, X
 238:	da 01       	movw	r26, r20
 23a:	2c 93       	st	X, r18
 23c:	a1 e0       	ldi	r26, 0x01	; 1
 23e:	a9 0f       	add	r26, r25
 240:	a0 31       	cpi	r26, 0x10	; 16
 242:	a8 f5       	brcc	.+106    	; 0x2ae <__vector_26+0x142>
 244:	a0 93 15 78 	sts	0x7815, r26	; 0x807815 <_ZL3buf+0x10>
 248:	20 91 16 78 	lds	r18, 0x7816	; 0x807816 <_ZL3buf+0x11>
 24c:	31 e0       	ldi	r19, 0x01	; 1
 24e:	a2 13       	cpse	r26, r18
 250:	30 e0       	ldi	r19, 0x00	; 0
 252:	30 93 17 78 	sts	0x7817, r19	; 0x807817 <_ZL3buf+0x12>
 256:	30 91 10 06 	lds	r19, 0x0610	; 0x800610 <__RODATA_PM_OFFSET__+0x7f8610>
 25a:	a2 17       	cp	r26, r18
 25c:	09 f4       	brne	.+2      	; 0x260 <__vector_26+0xf4>
 25e:	3d c0       	rjmp	.+122    	; 0x2da <__vector_26+0x16e>
 260:	b0 e0       	ldi	r27, 0x00	; 0
 262:	ab 5f       	subi	r26, 0xFB	; 251
 264:	b7 48       	sbci	r27, 0x87	; 135
 266:	3c 93       	st	X, r19
 268:	9e 5f       	subi	r25, 0xFE	; 254
 26a:	90 31       	cpi	r25, 0x10	; 16
 26c:	81 f5       	brne	.+96     	; 0x2ce <__vector_26+0x162>
 26e:	10 92 15 78 	sts	0x7815, r1	; 0x807815 <_ZL3buf+0x10>
 272:	90 e0       	ldi	r25, 0x00	; 0
 274:	31 e0       	ldi	r19, 0x01	; 1
 276:	29 13       	cpse	r18, r25
 278:	30 e0       	ldi	r19, 0x00	; 0
 27a:	30 93 17 78 	sts	0x7817, r19	; 0x807817 <_ZL3buf+0x12>
 27e:	30 91 11 06 	lds	r19, 0x0611	; 0x800611 <__RODATA_PM_OFFSET__+0x7f8611>
 282:	29 17       	cp	r18, r25
 284:	09 f4       	brne	.+2      	; 0x288 <__vector_26+0x11c>
 286:	9e cf       	rjmp	.-196    	; 0x1c4 <__vector_26+0x58>
 288:	90 91 15 78 	lds	r25, 0x7815	; 0x807815 <_ZL3buf+0x10>
 28c:	a9 2f       	mov	r26, r25
 28e:	b0 e0       	ldi	r27, 0x00	; 0
 290:	ab 5f       	subi	r26, 0xFB	; 251
 292:	b7 48       	sbci	r27, 0x87	; 135
 294:	3c 93       	st	X, r19
 296:	9f 5f       	subi	r25, 0xFF	; 255
 298:	90 31       	cpi	r25, 0x10	; 16
 29a:	e0 f4       	brcc	.+56     	; 0x2d4 <__vector_26+0x168>
 29c:	90 93 15 78 	sts	0x7815, r25	; 0x807815 <_ZL3buf+0x10>
 2a0:	89 2f       	mov	r24, r25
 2a2:	91 e0       	ldi	r25, 0x01	; 1
 2a4:	28 13       	cpse	r18, r24
 2a6:	90 e0       	ldi	r25, 0x00	; 0
 2a8:	90 93 17 78 	sts	0x7817, r25	; 0x807817 <_ZL3buf+0x12>
 2ac:	8b cf       	rjmp	.-234    	; 0x1c4 <__vector_26+0x58>
 2ae:	10 92 15 78 	sts	0x7815, r1	; 0x807815 <_ZL3buf+0x10>
 2b2:	20 91 16 78 	lds	r18, 0x7816	; 0x807816 <_ZL3buf+0x11>
 2b6:	91 e0       	ldi	r25, 0x01	; 1
 2b8:	21 11       	cpse	r18, r1
 2ba:	90 e0       	ldi	r25, 0x00	; 0
 2bc:	90 93 17 78 	sts	0x7817, r25	; 0x807817 <_ZL3buf+0x12>
 2c0:	90 91 10 06 	lds	r25, 0x0610	; 0x800610 <__RODATA_PM_OFFSET__+0x7f8610>
 2c4:	22 23       	and	r18, r18
 2c6:	49 f0       	breq	.+18     	; 0x2da <__vector_26+0x16e>
 2c8:	90 93 05 78 	sts	0x7805, r25	; 0x807805 <_ZL3buf>
 2cc:	91 e0       	ldi	r25, 0x01	; 1
 2ce:	90 93 15 78 	sts	0x7815, r25	; 0x807815 <_ZL3buf+0x10>
 2d2:	d0 cf       	rjmp	.-96     	; 0x274 <__vector_26+0x108>
 2d4:	10 92 15 78 	sts	0x7815, r1	; 0x807815 <_ZL3buf+0x10>
 2d8:	e4 cf       	rjmp	.-56     	; 0x2a2 <__vector_26+0x136>
 2da:	80 91 11 06 	lds	r24, 0x0611	; 0x800611 <__RODATA_PM_OFFSET__+0x7f8611>
 2de:	72 cf       	rjmp	.-284    	; 0x1c4 <__vector_26+0x58>

000002e0 <main>:
 2e0:	40 e4       	ldi	r20, 0x40	; 64
 2e2:	40 93 01 04 	sts	0x0401, r20	; 0x800401 <__RODATA_PM_OFFSET__+0x7f8401>
 2e6:	88 ed       	ldi	r24, 0xD8	; 216
 2e8:	84 bf       	out	0x34, r24	; 52
 2ea:	84 e2       	ldi	r24, 0x24	; 36
 2ec:	80 93 68 00 	sts	0x0068, r24	; 0x800068 <__RODATA_PM_OFFSET__+0x7f8068>
 2f0:	10 92 47 01 	sts	0x0147, r1	; 0x800147 <__RODATA_PM_OFFSET__+0x7f8147>
 2f4:	81 e0       	ldi	r24, 0x01	; 1
 2f6:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 2fa:	91 e2       	ldi	r25, 0x21	; 33
 2fc:	90 93 50 01 	sts	0x0150, r25	; 0x800150 <__RODATA_PM_OFFSET__+0x7f8150>
 300:	35 e0       	ldi	r19, 0x05	; 5
 302:	30 93 b0 00 	sts	0x00B0, r19	; 0x8000b0 <__RODATA_PM_OFFSET__+0x7f80b0>
 306:	10 92 00 06 	sts	0x0600, r1	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 30a:	90 91 00 06 	lds	r25, 0x0600	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 30e:	9d 7f       	andi	r25, 0xFD	; 253
 310:	90 93 00 06 	sts	0x0600, r25	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 314:	22 e0       	ldi	r18, 0x02	; 2
 316:	20 93 01 06 	sts	0x0601, r18	; 0x800601 <__RODATA_PM_OFFSET__+0x7f8601>
 31a:	96 e0       	ldi	r25, 0x06	; 6
 31c:	90 93 02 06 	sts	0x0602, r25	; 0x800602 <__RODATA_PM_OFFSET__+0x7f8602>
 320:	80 93 08 06 	sts	0x0608, r24	; 0x800608 <__RODATA_PM_OFFSET__+0x7f8608>
 324:	90 91 00 06 	lds	r25, 0x0600	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 328:	91 60       	ori	r25, 0x01	; 1
 32a:	90 93 00 06 	sts	0x0600, r25	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 32e:	e7 e5       	ldi	r30, 0x57	; 87
 330:	f2 e0       	ldi	r31, 0x02	; 2
 332:	31 97       	sbiw	r30, 0x01	; 1
 334:	f1 f7       	brne	.-4      	; 0x332 <main+0x52>
 336:	00 c0       	rjmp	.+0      	; 0x338 <main+0x58>
 338:	00 00       	nop
 33a:	40 93 03 06 	sts	0x0603, r20	; 0x800603 <__RODATA_PM_OFFSET__+0x7f8603>
 33e:	90 e2       	ldi	r25, 0x20	; 32
 340:	90 93 05 06 	sts	0x0605, r25	; 0x800605 <__RODATA_PM_OFFSET__+0x7f8605>
 344:	80 93 0a 06 	sts	0x060A, r24	; 0x80060a <__RODATA_PM_OFFSET__+0x7f860a>
 348:	30 93 e5 05 	sts	0x05E5, r19	; 0x8005e5 <__RODATA_PM_OFFSET__+0x7f85e5>
 34c:	20 93 41 04 	sts	0x0441, r18	; 0x800441 <__RODATA_PM_OFFSET__+0x7f8441>
 350:	80 93 40 09 	sts	0x0940, r24	; 0x800940 <__RODATA_PM_OFFSET__+0x7f8940>
 354:	80 93 42 09 	sts	0x0942, r24	; 0x800942 <__RODATA_PM_OFFSET__+0x7f8942>
 358:	78 94       	sei
 35a:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 35e:	8e 7f       	andi	r24, 0xFE	; 254
 360:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 364:	00 91 00 78 	lds	r16, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 368:	10 91 01 78 	lds	r17, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 36c:	20 91 02 78 	lds	r18, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 370:	30 91 03 78 	lds	r19, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 374:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 378:	81 60       	ori	r24, 0x01	; 1
 37a:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 37e:	e0 e4       	ldi	r30, 0x40	; 64
 380:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 384:	8e 7f       	andi	r24, 0xFE	; 254
 386:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 38a:	40 91 00 78 	lds	r20, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 38e:	50 91 01 78 	lds	r21, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 392:	60 91 02 78 	lds	r22, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 396:	70 91 03 78 	lds	r23, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 39a:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 39e:	81 60       	ori	r24, 0x01	; 1
 3a0:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 3a4:	db 01       	movw	r26, r22
 3a6:	ca 01       	movw	r24, r20
 3a8:	80 1b       	sub	r24, r16
 3aa:	91 0b       	sbc	r25, r17
 3ac:	a2 0b       	sbc	r26, r18
 3ae:	b3 0b       	sbc	r27, r19
 3b0:	85 3f       	cpi	r24, 0xF5	; 245
 3b2:	91 40       	sbci	r25, 0x01	; 1
 3b4:	a1 05       	cpc	r26, r1
 3b6:	b1 05       	cpc	r27, r1
 3b8:	18 f3       	brcs	.-58     	; 0x380 <main+0xa0>
 3ba:	e0 93 07 04 	sts	0x0407, r30	; 0x800407 <__RODATA_PM_OFFSET__+0x7f8407>
 3be:	8a 01       	movw	r16, r20
 3c0:	9b 01       	movw	r18, r22
 3c2:	de cf       	rjmp	.-68     	; 0x380 <main+0xa0>

000003c4 <_exit>:
 3c4:	f8 94       	cli

000003c6 <__stop_program>:
 3c6:	ff cf       	rjmp	.-2      	; 0x3c6 <__stop_program>
