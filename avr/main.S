
main.elf:     file format elf32-avr


Disassembly of section .text:

00000000 <__vectors>:
   0:	0c 94 48 00 	jmp	0x90	; 0x90 <__ctors_end>
   4:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
   8:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
   c:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  10:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  14:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  18:	0c 94 67 00 	jmp	0xce	; 0xce <__vector_6>
  1c:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  20:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  24:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  28:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  2c:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  30:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  34:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  38:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  3c:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  40:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  44:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  48:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  4c:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  50:	0c 94 8f 00 	jmp	0x11e	; 0x11e <__vector_20>
  54:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  58:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  5c:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  60:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  64:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  68:	0c 94 c8 00 	jmp	0x190	; 0x190 <__vector_26>
  6c:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  70:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  74:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  78:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  7c:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  80:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  84:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  88:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>
  8c:	0c 94 65 00 	jmp	0xca	; 0xca <__bad_interrupt>

00000090 <__ctors_end>:
  90:	11 24       	eor	r1, r1
  92:	1f be       	out	0x3f, r1	; 63
  94:	cf ef       	ldi	r28, 0xFF	; 255
  96:	cd bf       	out	0x3d, r28	; 61
  98:	df e7       	ldi	r29, 0x7F	; 127
  9a:	de bf       	out	0x3e, r29	; 62

0000009c <__do_copy_data>:
  9c:	18 e7       	ldi	r17, 0x78	; 120
  9e:	a0 e0       	ldi	r26, 0x00	; 0
  a0:	b8 e7       	ldi	r27, 0x78	; 120
  a2:	e0 ea       	ldi	r30, 0xA0	; 160
  a4:	f2 e0       	ldi	r31, 0x02	; 2
  a6:	02 c0       	rjmp	.+4      	; 0xac <__do_copy_data+0x10>
  a8:	05 90       	lpm	r0, Z+
  aa:	0d 92       	st	X+, r0
  ac:	a2 30       	cpi	r26, 0x02	; 2
  ae:	b1 07       	cpc	r27, r17
  b0:	d9 f7       	brne	.-10     	; 0xa8 <__do_copy_data+0xc>

000000b2 <__do_clear_bss>:
  b2:	28 e7       	ldi	r18, 0x78	; 120
  b4:	a2 e0       	ldi	r26, 0x02	; 2
  b6:	b8 e7       	ldi	r27, 0x78	; 120
  b8:	01 c0       	rjmp	.+2      	; 0xbc <.do_clear_bss_start>

000000ba <.do_clear_bss_loop>:
  ba:	1d 92       	st	X+, r1

000000bc <.do_clear_bss_start>:
  bc:	a9 30       	cpi	r26, 0x09	; 9
  be:	b2 07       	cpc	r27, r18
  c0:	e1 f7       	brne	.-8      	; 0xba <.do_clear_bss_loop>
  c2:	0e 94 ea 00 	call	0x1d4	; 0x1d4 <main>
  c6:	0c 94 4e 01 	jmp	0x29c	; 0x29c <_exit>

000000ca <__bad_interrupt>:
  ca:	0c 94 00 00 	jmp	0	; 0x0 <__vectors>

000000ce <__vector_6>:
  ce:	1f 92       	push	r1
  d0:	0f 92       	push	r0
  d2:	0f b6       	in	r0, 0x3f	; 63
  d4:	0f 92       	push	r0
  d6:	11 24       	eor	r1, r1
  d8:	8f 93       	push	r24
  da:	9f 93       	push	r25
  dc:	af 93       	push	r26
  de:	bf 93       	push	r27
  e0:	81 e0       	ldi	r24, 0x01	; 1
  e2:	80 93 53 01 	sts	0x0153, r24	; 0x800153 <__RODATA_PM_OFFSET__+0x7f8153>
  e6:	80 91 05 78 	lds	r24, 0x7805	; 0x807805 <_ZL7_millis>
  ea:	90 91 06 78 	lds	r25, 0x7806	; 0x807806 <_ZL7_millis+0x1>
  ee:	a0 91 07 78 	lds	r26, 0x7807	; 0x807807 <_ZL7_millis+0x2>
  f2:	b0 91 08 78 	lds	r27, 0x7808	; 0x807808 <_ZL7_millis+0x3>
  f6:	01 96       	adiw	r24, 0x01	; 1
  f8:	a1 1d       	adc	r26, r1
  fa:	b1 1d       	adc	r27, r1
  fc:	80 93 05 78 	sts	0x7805, r24	; 0x807805 <_ZL7_millis>
 100:	90 93 06 78 	sts	0x7806, r25	; 0x807806 <_ZL7_millis+0x1>
 104:	a0 93 07 78 	sts	0x7807, r26	; 0x807807 <_ZL7_millis+0x2>
 108:	b0 93 08 78 	sts	0x7808, r27	; 0x807808 <_ZL7_millis+0x3>
 10c:	bf 91       	pop	r27
 10e:	af 91       	pop	r26
 110:	9f 91       	pop	r25
 112:	8f 91       	pop	r24
 114:	0f 90       	pop	r0
 116:	0f be       	out	0x3f, r0	; 63
 118:	0f 90       	pop	r0
 11a:	1f 90       	pop	r1
 11c:	18 95       	reti

0000011e <__vector_20>:
 11e:	1f 92       	push	r1
 120:	0f 92       	push	r0
 122:	0f b6       	in	r0, 0x3f	; 63
 124:	0f 92       	push	r0
 126:	11 24       	eor	r1, r1
 128:	8f 93       	push	r24
 12a:	9f 93       	push	r25
 12c:	ef 93       	push	r30
 12e:	ff 93       	push	r31
 130:	80 e8       	ldi	r24, 0x80	; 128
 132:	80 93 43 09 	sts	0x0943, r24	; 0x800943 <__RODATA_PM_OFFSET__+0x7f8943>
 136:	80 91 44 09 	lds	r24, 0x0944	; 0x800944 <__RODATA_PM_OFFSET__+0x7f8944>
 13a:	88 23       	and	r24, r24
 13c:	21 f0       	breq	.+8      	; 0x146 <__vector_20+0x28>
 13e:	90 91 0a 06 	lds	r25, 0x060A	; 0x80060a <__RODATA_PM_OFFSET__+0x7f860a>
 142:	90 ff       	sbrs	r25, 0
 144:	1a c0       	rjmp	.+52     	; 0x17a <__vector_20+0x5c>
 146:	80 91 00 78 	lds	r24, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 14a:	83 30       	cpi	r24, 0x03	; 3
 14c:	f8 f4       	brcc	.+62     	; 0x18c <__vector_20+0x6e>
 14e:	e0 91 00 78 	lds	r30, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 152:	f0 e0       	ldi	r31, 0x00	; 0
 154:	ee 5f       	subi	r30, 0xFE	; 254
 156:	f7 48       	sbci	r31, 0x87	; 135
 158:	90 81       	ld	r25, Z
 15a:	80 91 00 78 	lds	r24, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 15e:	8f 5f       	subi	r24, 0xFF	; 255
 160:	80 93 00 78 	sts	0x7800, r24	; 0x807800 <__DATA_REGION_ORIGIN__>
 164:	90 93 44 09 	sts	0x0944, r25	; 0x800944 <__RODATA_PM_OFFSET__+0x7f8944>
 168:	ff 91       	pop	r31
 16a:	ef 91       	pop	r30
 16c:	9f 91       	pop	r25
 16e:	8f 91       	pop	r24
 170:	0f 90       	pop	r0
 172:	0f be       	out	0x3f, r0	; 63
 174:	0f 90       	pop	r0
 176:	1f 90       	pop	r1
 178:	18 95       	reti
 17a:	80 93 08 06 	sts	0x0608, r24	; 0x800608 <__RODATA_PM_OFFSET__+0x7f8608>
 17e:	81 e0       	ldi	r24, 0x01	; 1
 180:	80 93 0a 06 	sts	0x060A, r24	; 0x80060a <__RODATA_PM_OFFSET__+0x7f860a>
 184:	80 91 00 78 	lds	r24, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 188:	83 30       	cpi	r24, 0x03	; 3
 18a:	08 f3       	brcs	.-62     	; 0x14e <__vector_20+0x30>
 18c:	90 e0       	ldi	r25, 0x00	; 0
 18e:	ea cf       	rjmp	.-44     	; 0x164 <__vector_20+0x46>

00000190 <__vector_26>:
 190:	1f 92       	push	r1
 192:	0f 92       	push	r0
 194:	0f b6       	in	r0, 0x3f	; 63
 196:	0f 92       	push	r0
 198:	11 24       	eor	r1, r1
 19a:	2f 93       	push	r18
 19c:	8f 93       	push	r24
 19e:	9f 93       	push	r25
 1a0:	ef 93       	push	r30
 1a2:	ff 93       	push	r31
 1a4:	e0 e0       	ldi	r30, 0x00	; 0
 1a6:	f6 e0       	ldi	r31, 0x06	; 6
 1a8:	81 e0       	ldi	r24, 0x01	; 1
 1aa:	85 87       	std	Z+13, r24	; 0x0d
 1ac:	80 89       	ldd	r24, Z+16	; 0x10
 1ae:	91 89       	ldd	r25, Z+17	; 0x11
 1b0:	20 85       	ldd	r18, Z+8	; 0x08
 1b2:	e2 e0       	ldi	r30, 0x02	; 2
 1b4:	f8 e7       	ldi	r31, 0x78	; 120
 1b6:	20 83       	st	Z, r18
 1b8:	81 83       	std	Z+1, r24	; 0x01
 1ba:	92 83       	std	Z+2, r25	; 0x02
 1bc:	10 92 00 78 	sts	0x7800, r1	; 0x807800 <__DATA_REGION_ORIGIN__>
 1c0:	ff 91       	pop	r31
 1c2:	ef 91       	pop	r30
 1c4:	9f 91       	pop	r25
 1c6:	8f 91       	pop	r24
 1c8:	2f 91       	pop	r18
 1ca:	0f 90       	pop	r0
 1cc:	0f be       	out	0x3f, r0	; 63
 1ce:	0f 90       	pop	r0
 1d0:	1f 90       	pop	r1
 1d2:	18 95       	reti

000001d4 <main>:
 1d4:	80 e4       	ldi	r24, 0x40	; 64
 1d6:	80 93 01 04 	sts	0x0401, r24	; 0x800401 <__RODATA_PM_OFFSET__+0x7f8401>
 1da:	88 ed       	ldi	r24, 0xD8	; 216
 1dc:	84 bf       	out	0x34, r24	; 52
 1de:	84 e2       	ldi	r24, 0x24	; 36
 1e0:	80 93 68 00 	sts	0x0068, r24	; 0x800068 <__RODATA_PM_OFFSET__+0x7f8068>
 1e4:	10 92 47 01 	sts	0x0147, r1	; 0x800147 <__RODATA_PM_OFFSET__+0x7f8147>
 1e8:	81 e0       	ldi	r24, 0x01	; 1
 1ea:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 1ee:	91 e2       	ldi	r25, 0x21	; 33
 1f0:	90 93 50 01 	sts	0x0150, r25	; 0x800150 <__RODATA_PM_OFFSET__+0x7f8150>
 1f4:	25 e0       	ldi	r18, 0x05	; 5
 1f6:	20 93 b0 00 	sts	0x00B0, r18	; 0x8000b0 <__RODATA_PM_OFFSET__+0x7f80b0>
 1fa:	92 e0       	ldi	r25, 0x02	; 2
 1fc:	90 93 01 06 	sts	0x0601, r25	; 0x800601 <__RODATA_PM_OFFSET__+0x7f8601>
 200:	36 e0       	ldi	r19, 0x06	; 6
 202:	30 93 02 06 	sts	0x0602, r19	; 0x800602 <__RODATA_PM_OFFSET__+0x7f8602>
 206:	80 93 00 06 	sts	0x0600, r24	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 20a:	e7 e5       	ldi	r30, 0x57	; 87
 20c:	f2 e0       	ldi	r31, 0x02	; 2
 20e:	31 97       	sbiw	r30, 0x01	; 1
 210:	f1 f7       	brne	.-4      	; 0x20e <main+0x3a>
 212:	00 c0       	rjmp	.+0      	; 0x214 <main+0x40>
 214:	00 00       	nop
 216:	80 93 0c 06 	sts	0x060C, r24	; 0x80060c <__RODATA_PM_OFFSET__+0x7f860c>
 21a:	20 93 e5 05 	sts	0x05E5, r18	; 0x8005e5 <__RODATA_PM_OFFSET__+0x7f85e5>
 21e:	90 93 41 04 	sts	0x0441, r25	; 0x800441 <__RODATA_PM_OFFSET__+0x7f8441>
 222:	9d e0       	ldi	r25, 0x0D	; 13
 224:	90 93 42 04 	sts	0x0442, r25	; 0x800442 <__RODATA_PM_OFFSET__+0x7f8442>
 228:	80 93 40 09 	sts	0x0940, r24	; 0x800940 <__RODATA_PM_OFFSET__+0x7f8940>
 22c:	80 93 42 09 	sts	0x0942, r24	; 0x800942 <__RODATA_PM_OFFSET__+0x7f8942>
 230:	78 94       	sei
 232:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 236:	8e 7f       	andi	r24, 0xFE	; 254
 238:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 23c:	00 91 05 78 	lds	r16, 0x7805	; 0x807805 <_ZL7_millis>
 240:	10 91 06 78 	lds	r17, 0x7806	; 0x807806 <_ZL7_millis+0x1>
 244:	20 91 07 78 	lds	r18, 0x7807	; 0x807807 <_ZL7_millis+0x2>
 248:	30 91 08 78 	lds	r19, 0x7808	; 0x807808 <_ZL7_millis+0x3>
 24c:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 250:	81 60       	ori	r24, 0x01	; 1
 252:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 256:	e0 e4       	ldi	r30, 0x40	; 64
 258:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 25c:	8e 7f       	andi	r24, 0xFE	; 254
 25e:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 262:	40 91 05 78 	lds	r20, 0x7805	; 0x807805 <_ZL7_millis>
 266:	50 91 06 78 	lds	r21, 0x7806	; 0x807806 <_ZL7_millis+0x1>
 26a:	60 91 07 78 	lds	r22, 0x7807	; 0x807807 <_ZL7_millis+0x2>
 26e:	70 91 08 78 	lds	r23, 0x7808	; 0x807808 <_ZL7_millis+0x3>
 272:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 276:	81 60       	ori	r24, 0x01	; 1
 278:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 27c:	db 01       	movw	r26, r22
 27e:	ca 01       	movw	r24, r20
 280:	80 1b       	sub	r24, r16
 282:	91 0b       	sbc	r25, r17
 284:	a2 0b       	sbc	r26, r18
 286:	b3 0b       	sbc	r27, r19
 288:	85 3f       	cpi	r24, 0xF5	; 245
 28a:	91 40       	sbci	r25, 0x01	; 1
 28c:	a1 05       	cpc	r26, r1
 28e:	b1 05       	cpc	r27, r1
 290:	18 f3       	brcs	.-58     	; 0x258 <main+0x84>
 292:	e0 93 07 04 	sts	0x0407, r30	; 0x800407 <__RODATA_PM_OFFSET__+0x7f8407>
 296:	8a 01       	movw	r16, r20
 298:	9b 01       	movw	r18, r22
 29a:	de cf       	rjmp	.-68     	; 0x258 <main+0x84>

0000029c <_exit>:
 29c:	f8 94       	cli

0000029e <__stop_program>:
 29e:	ff cf       	rjmp	.-2      	; 0x29e <__stop_program>
