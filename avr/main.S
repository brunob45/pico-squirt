
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
  68:	0c 94 b1 00 	jmp	0x162	; 0x162 <__vector_26>
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
  ac:	0e 94 4e 01 	call	0x29c	; 0x29c <main>
  b0:	0c 94 c0 01 	jmp	0x380	; 0x380 <_exit>

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
 120:	80 91 0e 78 	lds	r24, 0x780E	; 0x80780e <_ZL3buf+0x9>
 124:	90 91 0d 78 	lds	r25, 0x780D	; 0x80780d <_ZL3buf+0x8>
 128:	98 17       	cp	r25, r24
 12a:	a9 f0       	breq	.+42     	; 0x156 <__vector_20+0x4e>
 12c:	e8 2f       	mov	r30, r24
 12e:	f0 e0       	ldi	r31, 0x00	; 0
 130:	eb 5f       	subi	r30, 0xFB	; 251
 132:	f7 48       	sbci	r31, 0x87	; 135
 134:	90 81       	ld	r25, Z
 136:	8f 5f       	subi	r24, 0xFF	; 255
 138:	80 93 0e 78 	sts	0x780E, r24	; 0x80780e <_ZL3buf+0x9>
 13c:	10 92 0f 78 	sts	0x780F, r1	; 0x80780f <_ZL3buf+0xa>
 140:	90 93 44 09 	sts	0x0944, r25	; 0x800944 <__RODATA_PM_OFFSET__+0x7f8944>
 144:	ff 91       	pop	r31
 146:	ef 91       	pop	r30
 148:	9f 91       	pop	r25
 14a:	8f 91       	pop	r24
 14c:	0f 90       	pop	r0
 14e:	0f be       	out	0x3f, r0	; 63
 150:	0f 90       	pop	r0
 152:	1f 90       	pop	r1
 154:	18 95       	reti
 156:	90 91 0f 78 	lds	r25, 0x780F	; 0x80780f <_ZL3buf+0xa>
 15a:	91 11       	cpse	r25, r1
 15c:	e7 cf       	rjmp	.-50     	; 0x12c <__vector_20+0x24>
 15e:	90 e0       	ldi	r25, 0x00	; 0
 160:	ef cf       	rjmp	.-34     	; 0x140 <__vector_20+0x38>

00000162 <__vector_26>:
 162:	1f 92       	push	r1
 164:	0f 92       	push	r0
 166:	0f b6       	in	r0, 0x3f	; 63
 168:	0f 92       	push	r0
 16a:	11 24       	eor	r1, r1
 16c:	2f 93       	push	r18
 16e:	3f 93       	push	r19
 170:	4f 93       	push	r20
 172:	5f 93       	push	r21
 174:	8f 93       	push	r24
 176:	9f 93       	push	r25
 178:	af 93       	push	r26
 17a:	bf 93       	push	r27
 17c:	ef 93       	push	r30
 17e:	ff 93       	push	r31
 180:	cf 93       	push	r28
 182:	df 93       	push	r29
 184:	cd b7       	in	r28, 0x3d	; 61
 186:	de b7       	in	r29, 0x3e	; 62
 188:	27 97       	sbiw	r28, 0x07	; 7
 18a:	cd bf       	out	0x3d, r28	; 61
 18c:	de bf       	out	0x3e, r29	; 62
 18e:	87 e0       	ldi	r24, 0x07	; 7
 190:	e4 e8       	ldi	r30, 0x84	; 132
 192:	f3 e8       	ldi	r31, 0x83	; 131
 194:	de 01       	movw	r26, r28
 196:	11 96       	adiw	r26, 0x01	; 1
 198:	01 90       	ld	r0, Z+
 19a:	0d 92       	st	X+, r0
 19c:	8a 95       	dec	r24
 19e:	e1 f7       	brne	.-8      	; 0x198 <__vector_26+0x36>
 1a0:	81 e0       	ldi	r24, 0x01	; 1
 1a2:	80 93 0d 06 	sts	0x060D, r24	; 0x80060d <__RODATA_PM_OFFSET__+0x7f860d>
 1a6:	e0 91 04 78 	lds	r30, 0x7804	; 0x807804 <_ZZ11__vector_26E5index>
 1aa:	80 91 0f 78 	lds	r24, 0x780F	; 0x80780f <_ZL3buf+0xa>
 1ae:	81 11       	cpse	r24, r1
 1b0:	67 c0       	rjmp	.+206    	; 0x280 <__vector_26+0x11e>
 1b2:	80 91 0d 78 	lds	r24, 0x780D	; 0x80780d <_ZL3buf+0x8>
 1b6:	a8 2f       	mov	r26, r24
 1b8:	b0 e0       	ldi	r27, 0x00	; 0
 1ba:	ad 01       	movw	r20, r26
 1bc:	4b 5f       	subi	r20, 0xFB	; 251
 1be:	57 48       	sbci	r21, 0x87	; 135
 1c0:	21 e0       	ldi	r18, 0x01	; 1
 1c2:	30 e0       	ldi	r19, 0x00	; 0
 1c4:	2c 0f       	add	r18, r28
 1c6:	3d 1f       	adc	r19, r29
 1c8:	2e 0f       	add	r18, r30
 1ca:	31 1d       	adc	r19, r1
 1cc:	d9 01       	movw	r26, r18
 1ce:	9c 91       	ld	r25, X
 1d0:	da 01       	movw	r26, r20
 1d2:	9c 93       	st	X, r25
 1d4:	a1 e0       	ldi	r26, 0x01	; 1
 1d6:	a8 0f       	add	r26, r24
 1d8:	a0 93 0d 78 	sts	0x780D, r26	; 0x80780d <_ZL3buf+0x8>
 1dc:	90 91 0e 78 	lds	r25, 0x780E	; 0x80780e <_ZL3buf+0x9>
 1e0:	21 e0       	ldi	r18, 0x01	; 1
 1e2:	a9 13       	cpse	r26, r25
 1e4:	20 e0       	ldi	r18, 0x00	; 0
 1e6:	20 93 0f 78 	sts	0x780F, r18	; 0x80780f <_ZL3buf+0xa>
 1ea:	20 91 10 06 	lds	r18, 0x0610	; 0x800610 <__RODATA_PM_OFFSET__+0x7f8610>
 1ee:	a9 17       	cp	r26, r25
 1f0:	09 f4       	brne	.+2      	; 0x1f4 <__vector_26+0x92>
 1f2:	51 c0       	rjmp	.+162    	; 0x296 <__vector_26+0x134>
 1f4:	b0 e0       	ldi	r27, 0x00	; 0
 1f6:	ab 5f       	subi	r26, 0xFB	; 251
 1f8:	b7 48       	sbci	r27, 0x87	; 135
 1fa:	2c 93       	st	X, r18
 1fc:	8e 5f       	subi	r24, 0xFE	; 254
 1fe:	80 93 0d 78 	sts	0x780D, r24	; 0x80780d <_ZL3buf+0x8>
 202:	21 e0       	ldi	r18, 0x01	; 1
 204:	89 13       	cpse	r24, r25
 206:	20 e0       	ldi	r18, 0x00	; 0
 208:	20 93 0f 78 	sts	0x780F, r18	; 0x80780f <_ZL3buf+0xa>
 20c:	20 91 11 06 	lds	r18, 0x0611	; 0x800611 <__RODATA_PM_OFFSET__+0x7f8611>
 210:	89 17       	cp	r24, r25
 212:	79 f0       	breq	.+30     	; 0x232 <__vector_26+0xd0>
 214:	80 91 0d 78 	lds	r24, 0x780D	; 0x80780d <_ZL3buf+0x8>
 218:	a8 2f       	mov	r26, r24
 21a:	b0 e0       	ldi	r27, 0x00	; 0
 21c:	ab 5f       	subi	r26, 0xFB	; 251
 21e:	b7 48       	sbci	r27, 0x87	; 135
 220:	2c 93       	st	X, r18
 222:	8f 5f       	subi	r24, 0xFF	; 255
 224:	80 93 0d 78 	sts	0x780D, r24	; 0x80780d <_ZL3buf+0x8>
 228:	21 e0       	ldi	r18, 0x01	; 1
 22a:	98 13       	cpse	r25, r24
 22c:	20 e0       	ldi	r18, 0x00	; 0
 22e:	20 93 0f 78 	sts	0x780F, r18	; 0x80780f <_ZL3buf+0xa>
 232:	ef 5f       	subi	r30, 0xFF	; 255
 234:	e7 30       	cpi	r30, 0x07	; 7
 236:	58 f1       	brcs	.+86     	; 0x28e <__vector_26+0x12c>
 238:	10 92 04 78 	sts	0x7804, r1	; 0x807804 <_ZZ11__vector_26E5index>
 23c:	e0 e0       	ldi	r30, 0x00	; 0
 23e:	f0 e0       	ldi	r31, 0x00	; 0
 240:	81 e0       	ldi	r24, 0x01	; 1
 242:	90 e0       	ldi	r25, 0x00	; 0
 244:	8c 0f       	add	r24, r28
 246:	9d 1f       	adc	r25, r29
 248:	e8 0f       	add	r30, r24
 24a:	f9 1f       	adc	r31, r25
 24c:	80 81       	ld	r24, Z
 24e:	80 93 08 06 	sts	0x0608, r24	; 0x800608 <__RODATA_PM_OFFSET__+0x7f8608>
 252:	81 e0       	ldi	r24, 0x01	; 1
 254:	80 93 0a 06 	sts	0x060A, r24	; 0x80060a <__RODATA_PM_OFFSET__+0x7f860a>
 258:	27 96       	adiw	r28, 0x07	; 7
 25a:	cd bf       	out	0x3d, r28	; 61
 25c:	de bf       	out	0x3e, r29	; 62
 25e:	df 91       	pop	r29
 260:	cf 91       	pop	r28
 262:	ff 91       	pop	r31
 264:	ef 91       	pop	r30
 266:	bf 91       	pop	r27
 268:	af 91       	pop	r26
 26a:	9f 91       	pop	r25
 26c:	8f 91       	pop	r24
 26e:	5f 91       	pop	r21
 270:	4f 91       	pop	r20
 272:	3f 91       	pop	r19
 274:	2f 91       	pop	r18
 276:	0f 90       	pop	r0
 278:	0f be       	out	0x3f, r0	; 63
 27a:	0f 90       	pop	r0
 27c:	1f 90       	pop	r1
 27e:	18 95       	reti
 280:	80 91 10 06 	lds	r24, 0x0610	; 0x800610 <__RODATA_PM_OFFSET__+0x7f8610>
 284:	80 91 11 06 	lds	r24, 0x0611	; 0x800611 <__RODATA_PM_OFFSET__+0x7f8611>
 288:	ef 5f       	subi	r30, 0xFF	; 255
 28a:	e7 30       	cpi	r30, 0x07	; 7
 28c:	a8 f6       	brcc	.-86     	; 0x238 <__vector_26+0xd6>
 28e:	e0 93 04 78 	sts	0x7804, r30	; 0x807804 <_ZZ11__vector_26E5index>
 292:	f0 e0       	ldi	r31, 0x00	; 0
 294:	d5 cf       	rjmp	.-86     	; 0x240 <__vector_26+0xde>
 296:	80 91 11 06 	lds	r24, 0x0611	; 0x800611 <__RODATA_PM_OFFSET__+0x7f8611>
 29a:	cb cf       	rjmp	.-106    	; 0x232 <__vector_26+0xd0>

0000029c <main>:
 29c:	40 e4       	ldi	r20, 0x40	; 64
 29e:	40 93 01 04 	sts	0x0401, r20	; 0x800401 <__RODATA_PM_OFFSET__+0x7f8401>
 2a2:	88 ed       	ldi	r24, 0xD8	; 216
 2a4:	84 bf       	out	0x34, r24	; 52
 2a6:	84 e2       	ldi	r24, 0x24	; 36
 2a8:	80 93 68 00 	sts	0x0068, r24	; 0x800068 <__RODATA_PM_OFFSET__+0x7f8068>
 2ac:	10 92 47 01 	sts	0x0147, r1	; 0x800147 <__RODATA_PM_OFFSET__+0x7f8147>
 2b0:	81 e0       	ldi	r24, 0x01	; 1
 2b2:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 2b6:	91 e2       	ldi	r25, 0x21	; 33
 2b8:	90 93 50 01 	sts	0x0150, r25	; 0x800150 <__RODATA_PM_OFFSET__+0x7f8150>
 2bc:	35 e0       	ldi	r19, 0x05	; 5
 2be:	30 93 b0 00 	sts	0x00B0, r19	; 0x8000b0 <__RODATA_PM_OFFSET__+0x7f80b0>
 2c2:	10 92 00 06 	sts	0x0600, r1	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 2c6:	90 91 00 06 	lds	r25, 0x0600	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 2ca:	9d 7f       	andi	r25, 0xFD	; 253
 2cc:	90 93 00 06 	sts	0x0600, r25	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 2d0:	22 e0       	ldi	r18, 0x02	; 2
 2d2:	20 93 01 06 	sts	0x0601, r18	; 0x800601 <__RODATA_PM_OFFSET__+0x7f8601>
 2d6:	96 e0       	ldi	r25, 0x06	; 6
 2d8:	90 93 02 06 	sts	0x0602, r25	; 0x800602 <__RODATA_PM_OFFSET__+0x7f8602>
 2dc:	80 93 08 06 	sts	0x0608, r24	; 0x800608 <__RODATA_PM_OFFSET__+0x7f8608>
 2e0:	90 91 00 06 	lds	r25, 0x0600	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 2e4:	91 60       	ori	r25, 0x01	; 1
 2e6:	90 93 00 06 	sts	0x0600, r25	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 2ea:	e7 e5       	ldi	r30, 0x57	; 87
 2ec:	f2 e0       	ldi	r31, 0x02	; 2
 2ee:	31 97       	sbiw	r30, 0x01	; 1
 2f0:	f1 f7       	brne	.-4      	; 0x2ee <main+0x52>
 2f2:	00 c0       	rjmp	.+0      	; 0x2f4 <main+0x58>
 2f4:	00 00       	nop
 2f6:	40 93 03 06 	sts	0x0603, r20	; 0x800603 <__RODATA_PM_OFFSET__+0x7f8603>
 2fa:	90 e2       	ldi	r25, 0x20	; 32
 2fc:	90 93 05 06 	sts	0x0605, r25	; 0x800605 <__RODATA_PM_OFFSET__+0x7f8605>
 300:	80 93 0a 06 	sts	0x060A, r24	; 0x80060a <__RODATA_PM_OFFSET__+0x7f860a>
 304:	30 93 e5 05 	sts	0x05E5, r19	; 0x8005e5 <__RODATA_PM_OFFSET__+0x7f85e5>
 308:	20 93 41 04 	sts	0x0441, r18	; 0x800441 <__RODATA_PM_OFFSET__+0x7f8441>
 30c:	80 93 40 09 	sts	0x0940, r24	; 0x800940 <__RODATA_PM_OFFSET__+0x7f8940>
 310:	80 93 42 09 	sts	0x0942, r24	; 0x800942 <__RODATA_PM_OFFSET__+0x7f8942>
 314:	78 94       	sei
 316:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 31a:	8e 7f       	andi	r24, 0xFE	; 254
 31c:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 320:	00 91 00 78 	lds	r16, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 324:	10 91 01 78 	lds	r17, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 328:	20 91 02 78 	lds	r18, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 32c:	30 91 03 78 	lds	r19, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 330:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 334:	81 60       	ori	r24, 0x01	; 1
 336:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 33a:	e0 e4       	ldi	r30, 0x40	; 64
 33c:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 340:	8e 7f       	andi	r24, 0xFE	; 254
 342:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 346:	40 91 00 78 	lds	r20, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 34a:	50 91 01 78 	lds	r21, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 34e:	60 91 02 78 	lds	r22, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 352:	70 91 03 78 	lds	r23, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 356:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 35a:	81 60       	ori	r24, 0x01	; 1
 35c:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 360:	db 01       	movw	r26, r22
 362:	ca 01       	movw	r24, r20
 364:	80 1b       	sub	r24, r16
 366:	91 0b       	sbc	r25, r17
 368:	a2 0b       	sbc	r26, r18
 36a:	b3 0b       	sbc	r27, r19
 36c:	85 3f       	cpi	r24, 0xF5	; 245
 36e:	91 40       	sbci	r25, 0x01	; 1
 370:	a1 05       	cpc	r26, r1
 372:	b1 05       	cpc	r27, r1
 374:	18 f3       	brcs	.-58     	; 0x33c <main+0xa0>
 376:	e0 93 07 04 	sts	0x0407, r30	; 0x800407 <__RODATA_PM_OFFSET__+0x7f8407>
 37a:	8a 01       	movw	r16, r20
 37c:	9b 01       	movw	r18, r22
 37e:	de cf       	rjmp	.-68     	; 0x33c <main+0xa0>

00000380 <_exit>:
 380:	f8 94       	cli

00000382 <__stop_program>:
 382:	ff cf       	rjmp	.-2      	; 0x382 <__stop_program>
