
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
  b0:	0c 94 03 01 	jmp	0x206	; 0x206 <_exit>

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

00000108 <main>:
 108:	80 e4       	ldi	r24, 0x40	; 64
 10a:	80 93 01 04 	sts	0x0401, r24	; 0x800401 <__RODATA_PM_OFFSET__+0x7f8401>
 10e:	88 ed       	ldi	r24, 0xD8	; 216
 110:	84 bf       	out	0x34, r24	; 52
 112:	84 e2       	ldi	r24, 0x24	; 36
 114:	80 93 68 00 	sts	0x0068, r24	; 0x800068 <__RODATA_PM_OFFSET__+0x7f8068>
 118:	10 92 47 01 	sts	0x0147, r1	; 0x800147 <__RODATA_PM_OFFSET__+0x7f8147>
 11c:	81 e0       	ldi	r24, 0x01	; 1
 11e:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 122:	91 e2       	ldi	r25, 0x21	; 33
 124:	90 93 50 01 	sts	0x0150, r25	; 0x800150 <__RODATA_PM_OFFSET__+0x7f8150>
 128:	25 e0       	ldi	r18, 0x05	; 5
 12a:	20 93 b0 00 	sts	0x00B0, r18	; 0x8000b0 <__RODATA_PM_OFFSET__+0x7f80b0>
 12e:	92 e0       	ldi	r25, 0x02	; 2
 130:	90 93 01 06 	sts	0x0601, r25	; 0x800601 <__RODATA_PM_OFFSET__+0x7f8601>
 134:	36 e0       	ldi	r19, 0x06	; 6
 136:	30 93 02 06 	sts	0x0602, r19	; 0x800602 <__RODATA_PM_OFFSET__+0x7f8602>
 13a:	80 93 00 06 	sts	0x0600, r24	; 0x800600 <__RODATA_PM_OFFSET__+0x7f8600>
 13e:	e7 e5       	ldi	r30, 0x57	; 87
 140:	f2 e0       	ldi	r31, 0x02	; 2
 142:	31 97       	sbiw	r30, 0x01	; 1
 144:	f1 f7       	brne	.-4      	; 0x142 <main+0x3a>
 146:	00 c0       	rjmp	.+0      	; 0x148 <main+0x40>
 148:	00 00       	nop
 14a:	20 93 e5 05 	sts	0x05E5, r18	; 0x8005e5 <__RODATA_PM_OFFSET__+0x7f85e5>
 14e:	90 93 41 04 	sts	0x0441, r25	; 0x800441 <__RODATA_PM_OFFSET__+0x7f8441>
 152:	9d e0       	ldi	r25, 0x0D	; 13
 154:	90 93 42 04 	sts	0x0442, r25	; 0x800442 <__RODATA_PM_OFFSET__+0x7f8442>
 158:	80 93 40 09 	sts	0x0940, r24	; 0x800940 <__RODATA_PM_OFFSET__+0x7f8940>
 15c:	78 94       	sei
 15e:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 162:	8e 7f       	andi	r24, 0xFE	; 254
 164:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 168:	00 91 00 78 	lds	r16, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 16c:	10 91 01 78 	lds	r17, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 170:	20 91 02 78 	lds	r18, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 174:	30 91 03 78 	lds	r19, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 178:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 17c:	81 60       	ori	r24, 0x01	; 1
 17e:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 182:	f0 e4       	ldi	r31, 0x40	; 64
 184:	c0 e8       	ldi	r28, 0x80	; 128
 186:	e1 e0       	ldi	r30, 0x01	; 1
 188:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 18c:	8e 7f       	andi	r24, 0xFE	; 254
 18e:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 192:	40 91 00 78 	lds	r20, 0x7800	; 0x807800 <__DATA_REGION_ORIGIN__>
 196:	50 91 01 78 	lds	r21, 0x7801	; 0x807801 <__DATA_REGION_ORIGIN__+0x1>
 19a:	60 91 02 78 	lds	r22, 0x7802	; 0x807802 <__DATA_REGION_ORIGIN__+0x2>
 19e:	70 91 03 78 	lds	r23, 0x7803	; 0x807803 <__DATA_REGION_ORIGIN__+0x3>
 1a2:	80 91 52 01 	lds	r24, 0x0152	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 1a6:	81 60       	ori	r24, 0x01	; 1
 1a8:	80 93 52 01 	sts	0x0152, r24	; 0x800152 <__RODATA_PM_OFFSET__+0x7f8152>
 1ac:	db 01       	movw	r26, r22
 1ae:	ca 01       	movw	r24, r20
 1b0:	80 1b       	sub	r24, r16
 1b2:	91 0b       	sbc	r25, r17
 1b4:	a2 0b       	sbc	r26, r18
 1b6:	b3 0b       	sbc	r27, r19
 1b8:	85 3f       	cpi	r24, 0xF5	; 245
 1ba:	91 40       	sbci	r25, 0x01	; 1
 1bc:	a1 05       	cpc	r26, r1
 1be:	b1 05       	cpc	r27, r1
 1c0:	20 f0       	brcs	.+8      	; 0x1ca <main+0xc2>
 1c2:	f0 93 07 04 	sts	0x0407, r31	; 0x800407 <__RODATA_PM_OFFSET__+0x7f8407>
 1c6:	8a 01       	movw	r16, r20
 1c8:	9b 01       	movw	r18, r22
 1ca:	80 91 43 09 	lds	r24, 0x0943	; 0x800943 <__RODATA_PM_OFFSET__+0x7f8943>
 1ce:	87 fd       	sbrc	r24, 7
 1d0:	0d c0       	rjmp	.+26     	; 0x1ec <main+0xe4>
 1d2:	80 91 0d 06 	lds	r24, 0x060D	; 0x80060d <__RODATA_PM_OFFSET__+0x7f860d>
 1d6:	80 ff       	sbrs	r24, 0
 1d8:	d7 cf       	rjmp	.-82     	; 0x188 <main+0x80>
 1da:	e0 93 0d 06 	sts	0x060D, r30	; 0x80060d <__RODATA_PM_OFFSET__+0x7f860d>
 1de:	80 91 08 06 	lds	r24, 0x0608	; 0x800608 <__RODATA_PM_OFFSET__+0x7f8608>
 1e2:	80 91 10 06 	lds	r24, 0x0610	; 0x800610 <__RODATA_PM_OFFSET__+0x7f8610>
 1e6:	80 91 11 06 	lds	r24, 0x0611	; 0x800611 <__RODATA_PM_OFFSET__+0x7f8611>
 1ea:	ce cf       	rjmp	.-100    	; 0x188 <main+0x80>
 1ec:	c0 93 43 09 	sts	0x0943, r28	; 0x800943 <__RODATA_PM_OFFSET__+0x7f8943>
 1f0:	80 91 44 09 	lds	r24, 0x0944	; 0x800944 <__RODATA_PM_OFFSET__+0x7f8944>
 1f4:	88 23       	and	r24, r24
 1f6:	21 f0       	breq	.+8      	; 0x200 <main+0xf8>
 1f8:	80 93 08 06 	sts	0x0608, r24	; 0x800608 <__RODATA_PM_OFFSET__+0x7f8608>
 1fc:	e0 93 0a 06 	sts	0x060A, r30	; 0x80060a <__RODATA_PM_OFFSET__+0x7f860a>
 200:	10 92 44 09 	sts	0x0944, r1	; 0x800944 <__RODATA_PM_OFFSET__+0x7f8944>
 204:	e6 cf       	rjmp	.-52     	; 0x1d2 <main+0xca>

00000206 <_exit>:
 206:	f8 94       	cli

00000208 <__stop_program>:
 208:	ff cf       	rjmp	.-2      	; 0x208 <__stop_program>
