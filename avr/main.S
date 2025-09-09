
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
  a6:	a0 31       	cpi	r26, 0x10	; 16
  a8:	b2 07       	cpc	r27, r18
  aa:	e1 f7       	brne	.-8      	; 0xa4 <.do_clear_bss_loop>
  ac:	0e 94 56 01 	call	0x2ac	; 0x2ac <main>
  b0:	0c 94 c8 01 	jmp	0x390	; 0x390 <_exit>

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
 112:	2f 93       	push	r18
 114:	8f 93       	push	r24
 116:	9f 93       	push	r25
 118:	ef 93       	push	r30
 11a:	ff 93       	push	r31
 11c:	80 e8       	ldi	r24, 0x80	; 128
 11e:	80 93 43 09 	sts	0x0943, r24	; 0x800943 <__RODATA_PM_OFFSET__+0x7f8943>
 122:	2f b7       	in	r18, 0x3f	; 63
 124:	f8 94       	cli
 126:	80 91 0e 78 	lds	r24, 0x780E	; 0x80780e <_ZL3buf+0x9>
 12a:	90 91 0d 78 	lds	r25, 0x780D	; 0x80780d <_ZL3buf+0x8>
 12e:	98 17       	cp	r25, r24
 130:	b9 f0       	breq	.+46     	; 0x160 <__vector_20+0x58>
 132:	e8 2f       	mov	r30, r24
 134:	f0 e0       	ldi	r31, 0x00	; 0
 136:	eb 5f       	subi	r30, 0xFB	; 251
 138:	f7 48       	sbci	r31, 0x87	; 135
 13a:	90 81       	ld	r25, Z
 13c:	8f 5f       	subi	r24, 0xFF	; 255
 13e:	80 93 0e 78 	sts	0x780E, r24	; 0x80780e <_ZL3buf+0x9>
 142:	10 92 0f 78 	sts	0x780F, r1	; 0x80780f <_ZL3buf+0xa>
 146:	2f bf       	out	0x3f, r18	; 63
 148:	90 93 44 09 	sts	0x0944, r25	; 0x800944 <__RODATA_PM_OFFSET__+0x7f8944>
 14c:	ff 91       	pop	r31
 14e:	ef 91       	pop	r30
 150:	9f 91       	pop	r25
 152:	8f 91       	pop	r24
 154:	2f 91       	pop	r18
 156:	0f 90       	pop	r0
 158:	0f be       	out	0x3f, r0	; 63
 15a:	0f 90       	pop	r0
 15c:	1f 90       	pop	r1
 15e:	18 95       	reti
 160:	90 91 0f 78 	lds	r25, 0x780F	; 0x80780f <_ZL3buf+0xa>
 164:	91 11       	cpse	r25, r1
 166:	e5 cf       	rjmp	.-54     	; 0x132 <__vector_20+0x2a>
 168:	90 e0       	ldi	r25, 0x00	; 0
 16a:	ed cf       	rjmp	.-38     	; 0x146 <__vector_20+0x3e>

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
 182:	ef 93       	push	r30
 184:	ff 93       	push	r31
 186:	cf 93       	push	r28
 188:	df 93       	push	r29
 18a:	cd b7       	in	r28, 0x3d	; 61
 18c:	de b7       	in	r29, 0x3e	; 62
 18e:	27 97       	sbiw	r28, 0x07	; 7
 190:	cd bf       	out	0x3d, r28	; 61
 192:	de bf       	out	0x3e, r29	; 62
 194:	87 e0       	ldi	r24, 0x07	; 7
 196:	e4 e9       	ldi	r30, 0x94	; 148
 198:	f3 e8       	ldi	r31, 0x83	; 131
 19a:	de 01       	movw	r26, r28
 19c:	11 96       	adiw	r26, 0x01	; 1
 19e:	01 90       	ld	r0, Z+
 1a0:	0d 92       	st	X+, r0
 1a2:	8a 95       	dec	r24
 1a4:	e1 f7       	brne	.-8      	; 0x19e <__vector_26+0x32>
 1a6:	81 e0       	ldi	r24, 0x01	; 1
 1a8:	80 93 0d 06 	sts	0x060D, r24	; 0x80060d <__RODATA_PM_OFFSET__+0x7f860d>
 1ac:	80 91 04 78 	lds	r24, 0x7804	; 0x807804 <_ZZ11__vector_26E5index>
 1b0:	e1 e0       	ldi	r30, 0x01	; 1
 1b2:	f0 e0       	ldi	r31, 0x00	; 0
 1b4:	ec 0f       	add	r30, r28
 1b6:	fd 1f       	adc	r31, r29
 1b8:	e8 0f       	add	r30, r24
 1ba:	f1 1d       	adc	r31, r1
 1bc:	90 81       	ld	r25, Z
 1be:	3f b7       	in	r19, 0x3f	; 63
 1c0:	f8 94       	cli
 1c2:	80 91 0f 78 	lds	r24, 0x780F	; 0x80780f <_ZL3buf+0xa>
 1c6:	81 11       	cpse	r24, r1
 1c8:	11 c0       	rjmp	.+34     	; 0x1ec <__vector_26+0x80>
 1ca:	80 91 0d 78 	lds	r24, 0x780D	; 0x80780d <_ZL3buf+0x8>
 1ce:	e8 2f       	mov	r30, r24
 1d0:	f0 e0       	ldi	r31, 0x00	; 0
 1d2:	eb 5f       	subi	r30, 0xFB	; 251
 1d4:	f7 48       	sbci	r31, 0x87	; 135
 1d6:	90 83       	st	Z, r25
 1d8:	8f 5f       	subi	r24, 0xFF	; 255
 1da:	80 93 0d 78 	sts	0x780D, r24	; 0x80780d <_ZL3buf+0x8>
 1de:	91 e0       	ldi	r25, 0x01	; 1
 1e0:	20 91 0e 78 	lds	r18, 0x780E	; 0x80780e <_ZL3buf+0x9>
 1e4:	28 13       	cpse	r18, r24
 1e6:	90 e0       	ldi	r25, 0x00	; 0
 1e8:	90 93 0f 78 	sts	0x780F, r25	; 0x80780f <_ZL3buf+0xa>
 1ec:	3f bf       	out	0x3f, r19	; 63
 1ee:	90 91 10 06 	lds	r25, 0x0610	; 0x800610 <__RODATA_PM_OFFSET__+0x7f8610>
 1f2:	2f b7       	in	r18, 0x3f	; 63
 1f4:	f8 94       	cli
 1f6:	80 91 0f 78 	lds	r24, 0x780F	; 0x80780f <_ZL3buf+0xa>
 1fa:	81 11       	cpse	r24, r1
 1fc:	11 c0       	rjmp	.+34     	; 0x220 <__vector_26+0xb4>
 1fe:	80 91 0d 78 	lds	r24, 0x780D	; 0x80780d <_ZL3buf+0x8>
 202:	e8 2f       	mov	r30, r24
 204:	f0 e0       	ldi	r31, 0x00	; 0
 206:	eb 5f       	subi	r30, 0xFB	; 251
 208:	f7 48       	sbci	r31, 0x87	; 135
 20a:	90 83       	st	Z, r25
 20c:	8f 5f       	subi	r24, 0xFF	; 255
 20e:	80 93 0d 78 	sts	0x780D, r24	; 0x80780d <_ZL3buf+0x8>
 212:	91 e0       	ldi	r25, 0x01	; 1
 214:	30 91 0e 78 	lds	r19, 0x780E	; 0x80780e <_ZL3buf+0x9>
 218:	38 13       	cpse	r19, r24
 21a:	90 e0       	ldi	r25, 0x00	; 0
 21c:	90 93 0f 78 	sts	0x780F, r25	; 0x80780f <_ZL3buf+0xa>
 220:	2f bf       	out	0x3f, r18	; 63
 222:	90 91 11 06 	lds	r25, 0x0611	; 0x800611 <__RODATA_PM_OFFSET__+0x7f8611>
 226:	3f b7       	in	r19, 0x3f	; 63
 228:	f8 94       	cli
 22a:	80 91 0f 78 	lds	r24, 0x780F	; 0x80780f <_ZL3buf+0xa>
 22e:	81 11       	cpse	r24, r1
 230:	11 c0       	rjmp	.+34     	; 0x254 <__vector_26+0xe8>
 232:	80 91 0d 78 	lds	r24, 0x780D	; 0x80780d <_ZL3buf+0x8>
 236:	e8 2f       	mov	r30, r24
 238:	f0 e0       	ldi	r31, 0x00	; 0
 23a:	eb 5f       	subi	r30, 0xFB	; 251
 23c:	f7 48       	sbci	r31, 0x87	; 135
 23e:	90 83       	st	Z, r25
 240:	8f 5f       	subi	r24, 0xFF	; 255
 242:	80 93 0d 78 	sts	0x780D, r24	; 0x80780d <_ZL3buf+0x8>
 246:	91 e0       	ldi	r25, 0x01	; 1
 248:	20 91 0e 78 	lds	r18, 0x780E	; 0x80780e <_ZL3buf+0x9>
 24c:	28 13       	cpse	r18, r24
 24e:	90 e0       	ldi	r25, 0x00	; 0
 250:	90 93 0f 78 	sts	0x780F, r25	; 0x80780f <_ZL3buf+0xa>
 254:	3f bf       	out	0x3f, r19	; 63
 256:	e0 91 04 78 	lds	r30, 0x7804	; 0x807804 <_ZZ11__vector_26E5index>
 25a:	ef 5f       	subi	r30, 0xFF	; 255
 25c:	e7 30       	cpi	r30, 0x07	; 7
 25e:	10 f1       	brcs	.+68     	; 0x2a4 <__vector_26+0x138>
 260:	10 92 04 78 	sts	0x7804, r1	; 0x807804 <_ZZ11__vector_26E5index>
 264:	e0 e0       	ldi	r30, 0x00	; 0
 266:	f0 e0       	ldi	r31, 0x00	; 0
 268:	81 e0       	ldi	r24, 0x01	; 1
 26a:	90 e0       	ldi	r25, 0x00	; 0
 26c:	8c 0f       	add	r24, r28
 26e:	9d 1f       	adc	r25, r29
 270:	e8 0f       	add	r30, r24
 272:	f9 1f       	adc	r31, r25
 274:	80 81       	ld	r24, Z
 276:	80 93 08 06 	sts	0x0608, r24	; 0x800608 <__RODATA_PM_OFFSET__+0x7f8608>
 27a:	81 e0       	ldi	r24, 0x01	; 1
 27c:	80 93 0a 06 	sts	0x060A, r24	; 0x80060a <__RODATA_PM_OFFSET__+0x7f860a>
 280:	27 96       	adiw	r28, 0x07	; 7
 282:	cd bf       	out	0x3d, r28	; 61
 284:	de bf       	out	0x3e, r29	; 62
 286:	df 91       	pop	r29
 288:	cf 91       	pop	r28
 28a:	ff 91       	pop	r31
 28c:	ef 91       	pop	r30
 28e:	bf 91       	pop	r27
 290:	af 91       	pop	r26
 292:	9f 91       	pop	r25
 294:	8f 91       	pop	r24
 296:	3f 91       	pop	r19
 298:	2f 91       	pop	r18
 29a:	0f 90       	pop	r0
 29c:	0f be       	out	0x3f, r0	; 63
 29e:	0f 90       	pop	r0
 2a0:	1f 90       	pop	r1
 2a2:	18 95       	reti
 2a4:	e0 93 04 78 	sts	0x7804, r30	; 0x807804 <_ZZ11__vector_26E5index>
 2a8:	f0 e0       	ldi	r31, 0x00	; 0
 2aa:	de cf       	rjmp	.-68     	; 0x268 <__vector_26+0xfc>

000002ac <main>:
 2ac:	40 e4       	ldi	r20, 0x40	; 64
 2ae:	40 93 01 04 	sts	0x0401, r20	; 0x800401 <__RODATA_PM_OFFSET__+0x7f8401>
 2b2:	88 ed       	ldi	r24, 0xD8	; 216
 2b4:	84 bf       	out	0x34, r24	; 52
 2b6:	84 e2       	ldi	r24, 0x24	; 36
 2b8:	80 93 68 00 	sts	0x0068, r24	; 0x800068 <__RODATA_PM_OFFSET__+0x7f8068>
 2bc:	10 92 47 01 	sts	0x0147, r1	; 0x800147 <__RODATA_PM_OFFSET__+0x7f8147>
 2c0:	81 e0       	ldi	r24, 0x01	; 1
 2c2:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 2c6:	91 e2       	ldi	r25, 0x21	; 33
 2c8:	90 93 50 01 	sts	0x0150, r25	; 0x800150 <__RODATA_PM_OFFSET__+0x7f8150>
 2cc:	35 e0       	ldi	r19, 0x05	; 5
 2ce:	30 93 b0 00 	sts	0x00B0, r19	; 0x8000b0 <__RODATA_PM_OFFSET__+0x7f80b0>
 2d2:	10 92 00 06 	sts	0x0600, r1	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 2d6:	90 91 00 06 	lds	r25, 0x0600	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 2da:	9d 7f       	andi	r25, 0xFD	; 253
 2dc:	90 93 00 06 	sts	0x0600, r25	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 2e0:	22 e0       	ldi	r18, 0x02	; 2
 2e2:	20 93 01 06 	sts	0x0601, r18	; 0x800601 <__RODATA_PM_OFFSET__+0x7f8601>
 2e6:	96 e0       	ldi	r25, 0x06	; 6
 2e8:	90 93 02 06 	sts	0x0602, r25	; 0x800602 <__RODATA_PM_OFFSET__+0x7f8602>
 2ec:	80 93 08 06 	sts	0x0608, r24	; 0x800608 <__RODATA_PM_OFFSET__+0x7f8608>
 2f0:	90 91 00 06 	lds	r25, 0x0600	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 2f4:	91 60       	ori	r25, 0x01	; 1
 2f6:	90 93 00 06 	sts	0x0600, r25	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 2fa:	e7 e5       	ldi	r30, 0x57	; 87
 2fc:	f2 e0       	ldi	r31, 0x02	; 2
 2fe:	31 97       	sbiw	r30, 0x01	; 1
 300:	f1 f7       	brne	.-4      	; 0x2fe <main+0x52>
 302:	00 c0       	rjmp	.+0      	; 0x304 <main+0x58>
 304:	00 00       	nop
 306:	40 93 03 06 	sts	0x0603, r20	; 0x800603 <__RODATA_PM_OFFSET__+0x7f8603>
 30a:	90 e2       	ldi	r25, 0x20	; 32
 30c:	90 93 05 06 	sts	0x0605, r25	; 0x800605 <__RODATA_PM_OFFSET__+0x7f8605>
 310:	80 93 0a 06 	sts	0x060A, r24	; 0x80060a <__RODATA_PM_OFFSET__+0x7f860a>
 314:	30 93 e5 05 	sts	0x05E5, r19	; 0x8005e5 <__RODATA_PM_OFFSET__+0x7f85e5>
 318:	20 93 41 04 	sts	0x0441, r18	; 0x800441 <__RODATA_PM_OFFSET__+0x7f8441>
 31c:	80 93 40 09 	sts	0x0940, r24	; 0x800940 <__RODATA_PM_OFFSET__+0x7f8940>
 320:	80 93 42 09 	sts	0x0942, r24	; 0x800942 <__RODATA_PM_OFFSET__+0x7f8942>
 324:	78 94       	sei
 326:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 32a:	8e 7f       	andi	r24, 0xFE	; 254
 32c:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 330:	00 91 00 78 	lds	r16, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 334:	10 91 01 78 	lds	r17, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 338:	20 91 02 78 	lds	r18, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 33c:	30 91 03 78 	lds	r19, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 340:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 344:	81 60       	ori	r24, 0x01	; 1
 346:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 34a:	e0 e4       	ldi	r30, 0x40	; 64
 34c:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 350:	8e 7f       	andi	r24, 0xFE	; 254
 352:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 356:	40 91 00 78 	lds	r20, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 35a:	50 91 01 78 	lds	r21, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 35e:	60 91 02 78 	lds	r22, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 362:	70 91 03 78 	lds	r23, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 366:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 36a:	81 60       	ori	r24, 0x01	; 1
 36c:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 370:	db 01       	movw	r26, r22
 372:	ca 01       	movw	r24, r20
 374:	80 1b       	sub	r24, r16
 376:	91 0b       	sbc	r25, r17
 378:	a2 0b       	sbc	r26, r18
 37a:	b3 0b       	sbc	r27, r19
 37c:	85 3f       	cpi	r24, 0xF5	; 245
 37e:	91 40       	sbci	r25, 0x01	; 1
 380:	a1 05       	cpc	r26, r1
 382:	b1 05       	cpc	r27, r1
 384:	18 f3       	brcs	.-58     	; 0x34c <main+0xa0>
 386:	e0 93 07 04 	sts	0x0407, r30	; 0x800407 <__RODATA_PM_OFFSET__+0x7f8407>
 38a:	8a 01       	movw	r16, r20
 38c:	9b 01       	movw	r18, r22
 38e:	de cf       	rjmp	.-68     	; 0x34c <main+0xa0>

00000390 <_exit>:
 390:	f8 94       	cli

00000392 <__stop_program>:
 392:	ff cf       	rjmp	.-2      	; 0x392 <__stop_program>
